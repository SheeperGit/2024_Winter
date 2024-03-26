/*
 * Graph algorithms.
 *
 * Author (of starter code): A. Tafliovich.
 */

#include <limits.h>

#include "graph.h"
#include "minheap.h"

#define NOTHING -1
#define DEBUG 0
#define INF INT_MAX   // New macro for infinity

typedef struct records {
  int numVertices;    // total number of vertices in the graph
                      // vertex IDs are 0, 1, ..., numVertices-1
  MinHeap* heap;      // priority queue
  bool* finished;     // finished[id] is true iff vertex id is finished
                      //   i.e. no longer in the PQ
  int* predecessors;  // predecessors[id] is the predecessor of vertex id
  Edge* tree;         // keeps edges for the resulting tree
  int numTreeEdges;   // current number of edges in mst
} Records;

/*************************************************************************
 ** Suggested helper functions -- part of starter code
 *************************************************************************/
/* Creates, populates, and returns a MinHeap to be used by Prim's and
 * Dijkstra's algorithms on Graph 'graph' starting from vertex with ID
 * 'startVertex'.
 * Precondition: 'startVertex' is valid in 'graph'
 */
MinHeap* initHeap(Graph* graph, int startVertex) {
  MinHeap* heap = newHeap(graph->numVertices);
  for (int i = 0; i < graph->numVertices; i++) {
    insert(heap, (i == startVertex) ? 0 : INF, i);
  }

  return heap;
}

/* Returns true iff 'heap' is NULL or is empty. */
bool isEmpty(MinHeap* heap) {
    return (heap == NULL || heap->size == 0);
}

/* Add a new edge to records at index ind. */
void addTreeEdge(Records* records, int ind, int fromVertex, int toVertex, int weight) {
  records->tree[ind].fromVertex = fromVertex;
  records->tree[ind].toVertex = toVertex;
  records->tree[ind].weight = weight;
  records->numTreeEdges++;
}

/* Creates, populates, and returns all records needed to run Prim's and
 * Dijkstra's algorithms on Graph 'graph' starting from vertex with ID
 * 'startVertex'.
 * Precondition: 'startVertex' is valid in 'graph'
 */
Records* initRecords(Graph* graph, int startVertex) {
  Records* r = (Records*) malloc(sizeof(Records));
  if (r == NULL) {
    fprintf(stderr, "Error: Failed to create records!\n");
    exit(EXIT_FAILURE);
  }

  r->numVertices = graph->numVertices;
  r->heap = initHeap(graph, startVertex);
  r->finished = (bool*) calloc(graph->numVertices, sizeof(bool));
  if (r->finished == NULL) {
    fprintf(stderr, "Error: Failed to create records->finished!\n");
    free(r);
    exit(EXIT_FAILURE);
  }

  r->predecessors = (int*) malloc(graph->numVertices * sizeof(int));
  if (r->predecessors == NULL) {
    fprintf(stderr, "Error: Failed to create records->predecessors!\n");
    free(r->finished);
    free(r);
    exit(EXIT_FAILURE);
  }

  for (int i = 0; i < graph->numVertices; i++) {
    r->predecessors[i] = NOTHING;
  }
  r->tree = NULL;
  r->numTreeEdges = 0;

  return r;
}

/* Creates and returns a path from 'vertex' to 'startVertex' from edges
 * in the distance tree 'distTree'.
 */
EdgeList* makePath(Edge* distTree, int vertex, int startVertex) {
  EdgeList* path = NULL;
  while (vertex != startVertex) {
    EdgeList* newEdgeNode = newEdgeList(&distTree[vertex], path);
    path = newEdgeNode;
    vertex = distTree[vertex].fromVertex;
  }

  return path;
}

/*************************************************************************
 ** Required functions
 *************************************************************************/
/* Runs Prim's algorithm on Graph 'graph' starting from vertex with ID
 * 'startVertex', and return the resulting MST: an array of Edges.
 * Returns NULL is 'startVertex' is not valid in 'graph'.
 * Precondition: 'graph' is connected.
 */
Edge* getMSTprim(Graph* graph, int startVertex) {
  if (startVertex < 0 || startVertex >= graph->numVertices) {
    // fprintf(stderr, "Error: startVertex is not valid in graph!\n");
    return NULL;
  }

  Records* r = initRecords(graph, startVertex);
  r->tree = (Edge*) malloc((graph->numVertices - 1) * sizeof(Edge));
  if (r->tree == NULL) {
    fprintf(stderr, "Error: Failed to create records->tree! (Prim's)\n");
    deleteHeap(r->heap);
    free(r->finished);
    free(r->predecessors);
    free(r);
    exit(EXIT_FAILURE);
  }

  while (!isEmpty(r->heap)) {
    // printRecords(records);
    HeapNode minNode = extractMin(r->heap);
    int curVertex = minNode.id;
    r->finished[curVertex] = true;

    if (r->predecessors[curVertex] != NOTHING) {
      addTreeEdge(r, r->numTreeEdges, r->predecessors[curVertex], curVertex, minNode.priority);
    }

    Vertex* curVertexPtr = graph->vertices[curVertex];
    EdgeList* adjList = curVertexPtr->adjList;
    while (adjList != NULL) {
      int adjVertex = adjList->edge->toVertex;
      if (!r->finished[adjVertex]) {
        int prio = getPriority(r->heap, adjVertex);
        int newPrio = adjList->edge->weight;
        if (newPrio < prio) {
          decreasePriority(r->heap, adjVertex, newPrio);
          r->predecessors[adjVertex] = curVertex;
        }
      }
      adjList = adjList->next;
    }
  }

  // Freeing stuff is important! //
  deleteHeap(r->heap);
  free(r->finished);
  free(r->predecessors);
  Edge* MST = r->tree;
  free(r);

  return MST;
}

/* Runs Dijkstra's algorithm on Graph 'graph' starting from vertex with ID
 * 'startVertex', and return the resulting distance tree: an array of edges.
 * Returns NULL if 'startVertex' is not valid in 'graph'.
 * Precondition: 'graph' is connected.
 */
Edge* getDistanceTreeDijkstra(Graph* graph, int startVertex) {
  // Thankfully, Dijkstra's is very similar to Prim's //
  if (startVertex < 0 || startVertex >= graph->numVertices) {
    // fprintf(stderr, "Error: Start vertex is not valid in the graph\n");
    return NULL;
  }

  Records* r = initRecords(graph, startVertex);
  r->tree = (Edge*) malloc((graph->numVertices - 1) * sizeof(Edge));
  if (r->tree == NULL) {
    fprintf(stderr, "Error: Failed to create records->tree! (Dijkstra's)\n");
    deleteHeap(r->heap);
    free(r->finished);
    free(r->predecessors);
    free(r);
    exit(EXIT_FAILURE);
  }
  r->heap = initHeap(graph, startVertex);
  r->predecessors[startVertex] = startVertex;

  while (!isEmpty(r->heap)) {
    // printRecords(records);
    HeapNode minNode = extractMin(r->heap);
    int curVertex = minNode.id;
    r->finished[curVertex] = true;

    if (r->predecessors[curVertex] != NOTHING) {
      addTreeEdge(r, r->numTreeEdges, r->predecessors[curVertex], curVertex, minNode.priority);
      // r->numTreeEdges++;
      r->finished[curVertex] = true;
    }

    Vertex* curVertexPtr = graph->vertices[curVertex];
    EdgeList* adjList = curVertexPtr->adjList;
    while (adjList != NULL) {
      int adjVertex = adjList->edge->toVertex;
      if (!r->finished[adjVertex]) {
        int prio = getPriority(r->heap, adjVertex);
        int newPrio = minNode.priority + adjList->edge->weight;   // This `+` is basically the only real change from Prim's
        if (r->finished[adjVertex] == false && newPrio < prio) {
          decreasePriority(r->heap, adjVertex, newPrio);
          r->predecessors[adjVertex] = curVertex;
        }
      }
      adjList = adjList->next;
    }
    r->finished[curVertex] = true;
  }

  // Freeing stuff is important! //
  deleteHeap(r->heap);
  free(r->finished);
  free(r->predecessors);
  Edge* distTree = r->tree;
  free(r);

  return distTree;
}

/* Creates and returns an array 'paths' of shortest paths from every vertex
 * in the graph to vertex 'startVertex', based on the information in the
 * distance tree 'distTree' produced by Dijkstra's algorithm on a graph with
 * 'numVertices' vertices and with the start vertex 'startVertex'.  paths[id]
 * is the list of edges of the form
 *   [(id -- id_1, w_0), (id_1 -- id_2, w_1), ..., (id_n -- start, w_n)]
 *   where w_0 + w_1 + ... + w_n = distance(id)
 * Returns NULL if 'startVertex' is not valid in 'distTree'.
 */
EdgeList** getShortestPaths(Edge* distTree, int numVertices, int startVertex) {
  EdgeList** paths = (EdgeList**) malloc(numVertices * sizeof(EdgeList*));
  if (paths == NULL) {
    fprintf(stderr, "Error: Failed to create paths!\n");
    exit(EXIT_FAILURE);
  }

  for (int i = 0; i < numVertices; i++) {
    paths[i] = NULL;
    if (i == startVertex) { // Skip //
      continue;
    }

    int vertex = i;
    while (vertex != startVertex) {
      EdgeList* newEdgeNode = newEdgeList(&distTree[vertex], paths[i]);
      paths[i] = newEdgeNode;
      vertex = distTree[vertex].fromVertex;
    }
  }

  return paths;
}


/*************************************************************************
 ** Provided helper functions -- part of starter code to help you debug!
 *************************************************************************/
void printRecords(Records* records) {
  if (records == NULL) return;

  int numVertices = records->numVertices;
  printf("Reporting on algorithm's records on %d vertices...\n", numVertices);

  printf("The PQ is:\n");
  printHeap(records->heap);

  printf("The finished array is:\n");
  for (int i = 0; i < numVertices; i++)
    printf("\t%d: %d\n", i, records->finished[i]);

  printf("The predecessors array is:\n");
  for (int i = 0; i < numVertices; i++)
    printf("\t%d: %d\n", i, records->predecessors[i]);

  printf("The TREE edges are:\n");
  for (int i = 0; i < records->numTreeEdges; i++) printEdge(&records->tree[i]);

  printf("... done.\n");
}
