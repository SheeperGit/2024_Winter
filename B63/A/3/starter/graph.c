/*
 * Our graph implementation.
 *
 * Author: A. Tafliovich.
 */

#include "graph.h"

/*********************************************************************
 ** Helper function provided in the starter code
 *********************************************************************/

void printEdge(Edge* edge) {
  if (edge == NULL)
    printf("NULL");
  else
    printf("(%d -- %d, %d)", edge->fromVertex, edge->toVertex, edge->weight);
}

void printEdgeList(EdgeList* head) {
  while (head != NULL) {
    printEdge(head->edge);
    printf(" --> ");
    head = head->next;
  }
  printf("NULL");
}

void printVertex(Vertex* vertex) {
  if (vertex == NULL) {
    printf("NULL");
  } else {
    printf("%d: ", vertex->id);
    printEdgeList(vertex->adjList);
  }
}

void printGraph(Graph* graph) {
  if (graph == NULL) {
    printf("NULL");
    return;
  }
  printf("Number of vertices: %d. Number of edges: %d.\n\n", graph->numVertices,
         graph->numEdges);

  for (int i = 0; i < graph->numVertices; i++) {
    printVertex(graph->vertices[i]);
    printf("\n");
  }
  printf("\n");
}

/*********************************************************************
 ** Required functions
 *********************************************************************/
/* Returns a newly created Edge from vertex with ID 'fromVertex' to vertex
 * with ID 'toVertex', with weight 'weight'.
 */
Edge* newEdge(int fromVertex, int toVertex, int weight) {
  Edge* e = (Edge*) malloc(sizeof(Edge));
  if (e == NULL) {
    fprintf(stderr, "Error: Failed to create edge!\n"); // Should never happen
    exit(EXIT_FAILURE);
  }
  e->fromVertex = fromVertex;
  e->toVertex = toVertex;
  e->weight = weight;
  return e;
}

/* Returns a newly created EdgeList containing 'edge' and pointing to the next
 * EdgeList node 'next'.
 */
EdgeList* newEdgeList(Edge* edge, EdgeList* next) {
  // Standard Linked List Creation //
  EdgeList* eList = (EdgeList*) malloc(sizeof(EdgeList));
  if (eList == NULL) {
    fprintf(stderr, "Error: Failed to create EdgeList!\n"); // Should never happen
    exit(EXIT_FAILURE);
  }
  eList->edge = edge;
  eList->next = next;
  return eList;
}

/* Returns a newly created Vertex with ID 'id', value 'value', and adjacency
 * list 'adjList'.
 * Precondition: 'id' is valid for this vertex
 */
Vertex* newVertex(int id, void* value, EdgeList* adjList) {
  Vertex* v = (Vertex*) malloc(sizeof(Vertex));
  if (v == NULL) {
    fprintf(stderr, "Error: Failed to create vertex!\n");
    exit(EXIT_FAILURE);
  }
  v->id = id;
  v->value = value;
  v->adjList = adjList;
  return v;
}

/* Returns a newly created Graph with space for 'numVertices' vertices.
 * Precondition: numVertices >= 0
 */
Graph* newGraph(int numVertices) {
  Graph* graph = (Graph*) malloc(sizeof(Graph));
  if (graph == NULL) {
    fprintf(stderr, "Error: Failed to create graph!\n");
    exit(EXIT_FAILURE);
  }

  graph->numVertices = numVertices;
  graph->numEdges = 0;
  graph->vertices = (Vertex**) malloc(numVertices * sizeof(Vertex*));
  if (graph->vertices == NULL) {
    fprintf(stderr, "Error: Failed to create graph->vertices!\n");
    free(graph);
    exit(EXIT_FAILURE);
  }

  for (int i = 0; i < numVertices; i++) {
    graph->vertices[i] = NULL;
  }

  return graph;
}

/* Frees memory allocated for EdgeList starting at 'head'.
 */
void deleteEdgeList(EdgeList* head) {
  // Standard Linked List Deletion //
  while (head != NULL) {
    EdgeList* next = head->next;
    free(head->edge);
    free(head);
    head = next;
  }
}

/* Frees memory allocated for 'vertex' including its adjacency list.
 */
void deleteVertex(Vertex* vertex) {
  if (vertex != NULL) {
    deleteEdgeList(vertex->adjList);
    free(vertex);
  }
}

/* Frees memory allocated for 'graph'.
 */
void deleteGraph(Graph* graph) {
  if (graph != NULL) {
    for (int i = 0; i < graph->numVertices; i++) {
      deleteVertex(graph->vertices[i]);
    }
    free(graph->vertices);
    free(graph);
  }
}