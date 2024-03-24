/*
 * Our min-heap implementation.
 *
 * Author (starter code): A. Tafliovich.
 */

#include "minheap.h"

#define ROOT_INDEX 1
#define NOTHING -1

/*************************************************************************
 ** Suggested helper functions -- part of starter code
 *************************************************************************/
/* Returns True if 'maybeIdx' is a valid index in minheap 'heap', and 'heap'
 * stores an element at that index. Returns False otherwise.
 */
bool isValidIndex(MinHeap* heap, int maybeIdx) {
    return (maybeIdx >= ROOT_INDEX && maybeIdx <= heap->size);
}

/* Returns the index of the left child of a node at index 'nodeIndex' in
 * minheap 'heap', if such exists.  Returns NOTHING if there is no such left
 * child.
 */
int leftIdx(MinHeap* heap, int nodeIndex) {
    int leftChildIndex = 2 * nodeIndex;
    return isValidIndex(heap, leftChildIndex) ? leftChildIndex : NOTHING;
}

/* Returns the index of the right child of a node at index 'nodeIndex' in
 * minheap 'heap', if such exists.  Returns NOTHING if there is no such right
 * child.
 */

int rightIdx(MinHeap* heap, int nodeIndex) {
    int rightChildIndex = 2 * nodeIndex + 1;
    return isValidIndex(heap, rightChildIndex) ? rightChildIndex : NOTHING;
}

/* Returns the index of the parent of a node at index 'nodeIndex' in minheap
 * 'heap', if such exists.  Returns NOTHING if there is no such parent.
 */
int parentIdx(MinHeap* heap, int nodeIndex) {
    int parentIndex = nodeIndex / 2;      // Effectively floor(nodeIndex / 2), since integer division!
    return (nodeIndex != ROOT_INDEX && isValidIndex(heap, parentIndex)) ? parentIndex : NOTHING;
}

/* Returns node at index 'nodeIndex' in minheap 'heap'.
 * Precondition: 'nodeIndex' is a valid index in 'heap'
 *               'heap' is non-empty
 */
HeapNode nodeAt(MinHeap* heap, int nodeIndex) {
    return heap->arr[nodeIndex];
}

/* Returns priority of node at index 'nodeIndex' in minheap 'heap'.
 * Precondition: 'nodeIndex' is a valid index in 'heap'
 *               'heap' is non-empty
 */
int priorityAt(MinHeap* heap, int nodeIndex) {
    return heap->arr[nodeIndex].priority;
}

/* Returns ID of node at index 'nodeIndex' in minheap 'heap'.
 * Precondition: 'nodeIndex' is a valid index in 'heap'
 *               'heap' is non-empty
 */
int idAt(MinHeap* heap, int nodeIndex) {
    return heap->arr[nodeIndex].id;
}

/* Returns index of node with ID 'id' in minheap 'heap'.
 * Precondition: 'id' is a valid ID in 'heap'
 *               'heap' is non-empty
 */
int indexOf(MinHeap* heap, int id) {
    return heap->indexMap[id];
}

/* Swaps contents of heap->arr[index1] and heap->arr[index2] if both 'index1'
 * and 'index2' are valid indices for minheap 'heap'. Has no effect
 * otherwise.
 */
void swap(MinHeap* heap, int index1, int index2) {
    if (isValidIndex(heap, index1) && isValidIndex(heap, index2)) {
       // Swapping... //
       HeapNode tmp = heap->arr[index1];
       heap->arr[index1] = heap->arr[index2];
       heap->arr[index2] = tmp;
       
       // Update indices //
       heap->indexMap[heap->arr[index1].id] = index1;
       heap->indexMap[heap->arr[index2].id] = index2;
    }
}

/* Bubbles up the element newly inserted into minheap 'heap' at index
 * 'nodeIndex', if 'nodeIndex' is a valid index for heap. Has no effect
 * otherwise.
 */
void bubbleUp(MinHeap* heap, int nodeIndex) {
    if (nodeIndex > ROOT_INDEX) {
       int parentIndex = parentIdx(heap, nodeIndex);
       if (isValidIndex(heap, parentIndex) && priorityAt(heap, nodeIndex) < priorityAt(heap, parentIndex)) {
              swap(heap, nodeIndex, parentIndex);
              bubbleUp(heap, parentIndex);
       }
    }
}

/* Bubbles down the element newly inserted into minheap 'heap' at the root,
 * if it exists. Has no effect otherwise.
 */
void bubbleDown(MinHeap* heap) {
    int nodeIndex = ROOT_INDEX;
    while (nodeIndex < heap->size) {
       int leftChild = leftIdx(heap, nodeIndex);
       int rightChild = rightIdx(heap, nodeIndex);
       int minIndex = nodeIndex;
       
       if (isValidIndex(heap, leftChild) && priorityAt(heap, leftChild) < priorityAt(heap, rightChild)) {
              minIndex = leftChild;
       }
       
       if (isValidIndex(heap, rightChild) && priorityAt(heap, leftChild) > priorityAt(heap, rightChild)) {
              minIndex = rightChild;
       }
       
       if (minIndex != nodeIndex) {
              swap(heap, nodeIndex, minIndex);
              nodeIndex = minIndex;
       } else {
              break;
       }
    }
}

/*********************************************************************
 * Required functions
 ********************************************************************/
/* Returns the node with minimum priority in minheap 'heap'.
 * Precondition: heap is non-empty
 */
HeapNode getMin(MinHeap* heap) {
    return heap->arr[ROOT_INDEX];
}

/* Removes and returns the node with minimum priority in minheap 'heap'.
 * Precondition: heap is non-empty
 */
HeapNode extractMin(MinHeap* heap) {
    HeapNode minNode = heap->arr[ROOT_INDEX];

    heap->arr[ROOT_INDEX] = heap->arr[heap->size--];    // Assignment and Post-Decrement in one step
    bubbleDown(heap);

    return minNode;
}

/* Inserts a new node with priority 'priority' and ID 'id' into minheap 'heap'.
 * Precondition: 'id' is unique within this minheap
 *               0 <= 'id' < heap->capacity
 *               heap->size < heap->capacity
 */
void insert(MinHeap* heap, int priority, int id) {
    int newIndex = ++heap->size;   // Pre-Increment and assignment in one step

    heap->arr[newIndex].priority = priority;
    heap->arr[newIndex].id = id;
    heap->indexMap[id] = newIndex;

    bubbleUp(heap, newIndex);
}

/* Returns priority of the node with ID 'id' in 'heap'.
 * Precondition: 'id' is a valid node ID in 'heap'.
 */
int getPriority(MinHeap* heap, int id) {
    return heap->arr[indexOf(heap, id)].priority;
}

/* Sets priority of node with ID 'id' in minheap 'heap' to 'newPriority', if
 * such a node exists in 'heap' and its priority is larger than
 * 'newPriority', and returns True. Has no effect and returns False, otherwise.
 * Note: this function bubbles up the node until the heap property is restored.
 */
bool decreasePriority(MinHeap* heap, int id, int newPriority) {
    int index = indexOf(heap, id);
    if (index == NOTHING || heap->arr[index].priority <= newPriority) {
       return false;
    }
    heap->arr[index].priority = newPriority;
    bubbleUp(heap, index);
    return true;
}

/* Returns a newly created empty minheap with initial capacity 'capacity'.
 * Precondition: capacity >= 0
 */
MinHeap* newHeap(int capacity) {
    // Note: There may be an excessive amt of error checking here, but this is done for good practice //
    MinHeap* heap = (MinHeap*) malloc(sizeof(MinHeap));
    if (heap == NULL) {
       fprintf(stderr, "Error: No more memory available for heap!\n");  // Should never happen
       exit(EXIT_FAILURE);
    }

    heap->size = 0;
    heap->capacity = capacity;
    heap->arr = (HeapNode*) malloc((capacity + 1) * sizeof(HeapNode)); // +1 to account for skipping the 0 index
    if (heap->arr == NULL) {
       fprintf(stderr, "Error: No more memory available for heap->arr!\n\n");      // Should never happen
       free(heap);
       exit(EXIT_FAILURE);
    }

    heap->indexMap = (int*) malloc((capacity + 1) * sizeof(int)); // +1 to account for skipping the 0 index
    if (heap->indexMap == NULL) {
       fprintf(stderr, "Error: No more memory available for heap->indexMap!\n");
       free(heap->arr);
       free(heap);
       exit(EXIT_FAILURE);
    }

    return heap;
}

/* Frees all memory allocated for minheap 'heap'.
 */
void deleteHeap(MinHeap* heap) {
    free(heap->arr);
    free(heap->indexMap);
    free(heap);
}

/*********************************************************************
 ** Helper function provided in the starter code
 *********************************************************************/
void printHeap(MinHeap* heap) {
  printf("MinHeap with size: %d\n\tcapacity: %d\n\n", heap->size,
         heap->capacity);
  printf("index: priority [ID]\t ID: index\n");
  for (int i = 0; i < heap->capacity; i++)
    printf("%d: %d [%d]\t\t%d: %d\n", i, priorityAt(heap, i), idAt(heap, i), i,
           indexOf(heap, i));
  printf("%d: %d [%d]\t\t\n", heap->capacity, priorityAt(heap, heap->capacity),
         idAt(heap, heap->capacity));
  printf("\n\n");
}
