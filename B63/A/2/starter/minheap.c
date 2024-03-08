/*
 * Our min-heap implementation.
 *
 * Author (starter code): A. Tafliovich.
 */

#include "minheap.h"

#define ROOT_INDEX 1
#define NOTHING -1

/*************************************************************************
 ** Suggested helper functions -- to help designing your code
 *************************************************************************/

/* Swaps contents of heap->arr[index1] and heap->arr[index2] if both 'index1'
 * and 'index2' are valid indices for minheap 'heap'. Has no effect
 * otherwise.
 */
void swap(MinHeap* heap, int index1, int index2) {
       return;
}

/* Bubbles up the element newly inserted into minheap 'heap' at index
 * 'nodeIndex', if 'nodeIndex' is a valid index for heap. Has no effect
 * otherwise.
 */
void bubbleUp(MinHeap* heap, int nodeIndex) {
       return;
}

/* Bubbles down the element newly inserted into minheap 'heap' at the root,
 * if it exists. Has no effect otherwise.
 */
void bubbleDown(MinHeap* heap) {
       return;
}

/* Returns the index of the left child of a node at index 'nodeIndex' in
 * minheap 'heap', if such exists.  Returns NOTHING if there is no such left
 * child.
 */
int leftIdx(MinHeap* heap, int nodeIndex) {
       return -1;
}

/* Returns the index of the right child of a node at index 'nodeIndex' in
 * minheap 'heap', if such exists.  Returns NOTHING if there is no such right
 * child.
 */
int rightIdx(MinHeap* heap, int nodeIndex) {
       return -1;
}

/* Returns the index of the parent of a node at index 'nodeIndex' in minheap
 * 'heap', if such exists.  Returns NOTHING if there is no such parent.
 */
int parentIdx(MinHeap* heap, int nodeIndex) {
       return -1;
}

/* Returns True if 'maybeIdx' is a valid index in minheap 'heap', and 'heap'
 * stores an element at that index. Returns False otherwise.
 */
bool isValidIndex(MinHeap* heap, int maybeIdx){
       return false;
}

/* Returns node at index 'nodeIndex' in minheap 'heap'.
 * Precondition: 'nodeIndex' is a valid index in 'heap'
 *               'heap' is non-empty
 */
HeapNode nodeAt(MinHeap* heap, int nodeIndex) {
       HeapNode newNode;
       newNode.id = -1;
       newNode.priority = -1;

       return newNode;
}

/* Returns priority of node at index 'nodeIndex' in minheap 'heap'.
 * Precondition: 'nodeIndex' is a valid index in 'heap'
 *               'heap' is non-empty
 */
int priorityAt(MinHeap* heap, int nodeIndex) {
       return -1;
}

/* Returns ID of node at index 'nodeIndex' in minheap 'heap'.
 * Precondition: 'nodeIndex' is a valid index in 'heap'
 *               'heap' is non-empty
 */
int idAt(MinHeap* heap, int nodeIndex) {
       return -1;
}

/* Returns index of node with ID 'id' in minheap 'heap'.
 * Precondition: 'id' is a valid ID in 'heap'
 *               'heap' is non-empty
 */
int indexOf(MinHeap* heap, int id) {
       return -1;
}

/*********************************************************************
 * Required functions
 ********************************************************************/

/* Returns the node with minimum priority in minheap 'heap'.
 * Precondition: heap is non-empty
 */
HeapNode getMin(MinHeap* heap){
    return heap->arr[ROOT_INDEX];
}

/* Removes and returns the node with minimum priority in minheap 'heap'.
 * Precondition: heap is non-empty
 */
HeapNode extractMin(MinHeap* heap) {
    HeapNode minNode = heap->arr[1];

    heap->arr[1] = heap->arr[heap->size]; // Replace root w/ last elem
    heap->indexMap[heap->arr[1].id] = 1;  // Update indexMap for the moved node
    heap->size--;

    // Bubble-down //
    int cur = 1;
    while (true) {
       int leftChild = cur * 2;
       int rightChild = cur * 2 + 1;
       int smallest = cur;

       // If there exists a leftChild and priority(leftChild) < priority(cur) //
       if (leftChild <= heap->size && heap->arr[leftChild].priority < heap->arr[cur].priority) {
              smallest = leftChild;
       }

       // If there exists a rightChild and priority(rightChild) < priority(cur) //
       if (rightChild <= heap->size && heap->arr[rightChild].priority < heap->arr[smallest].priority) {
              smallest = rightChild;
       }

       if (smallest != cur) {
              // Swap nodes //
              HeapNode temp = heap->arr[cur];
              heap->arr[cur] = heap->arr[smallest];
              heap->arr[smallest] = temp;

              // Update indexMap for swapped nodes //
              heap->indexMap[heap->arr[cur].id] = cur;
              heap->indexMap[heap->arr[smallest].id] = smallest;

              // Move on to next level //
              cur = smallest;
       } 
       
       // If cur node is smaller than both children, then the heap property holds //
       else {
              break; 
       }
    }

    return minNode;
}

/* Inserts a new node with priority 'priority' and ID 'id' into minheap 'heap'.
 * Precondition: 'id' is unique within this minheap
 *               0 <= 'id' < heap->capacity
 *               heap->size < heap->capacity
 */
void insert(MinHeap* heap, int priority, int id) {
    // Place new node at end of heap //
    int cur = ++heap->size;
    heap->arr[cur].priority = priority;
    heap->arr[cur].id = id;
    heap->indexMap[id] = cur;      // Update indexMap for new node

    // Bubble-Up //
    // If we're not at the top of the heap and priority(cur) < priority(cur->parent) //
    while (cur > 1 && heap->arr[cur].priority < heap->arr[cur / 2].priority) {
       // Swap the cur node w/ its parent //
       HeapNode temp = heap->arr[cur];
       heap->arr[cur] = heap->arr[cur / 2];
       heap->arr[cur / 2] = temp;

       // Update the indexMap for swapped nodes //
       heap->indexMap[heap->arr[cur].id] = cur;
       heap->indexMap[heap->arr[cur / 2].id] = cur / 2;

       // Move up to parent level //
       cur /= 2;
    }
}

/* Sets priority of node with ID 'id' in minheap 'heap' to 'newPriority', if
 * such a node exists in 'heap' and its priority is larger than
 * 'newPriority', and returns True. Has no effect and returns False, otherwise.
 * Note: this function bubbles up the node until the heap property is restored.
 */
bool decreasePriority(MinHeap* heap, int id, int newPriority) {
    int index = heap->indexMap[id];

    // Check if ID is OoB or doesn't exist in the heap //
    if (id < 0 || id >= heap->capacity || index == 0 || newPriority >= heap->arr[index].priority) {
       return false;
    }

    heap->arr[index].priority = newPriority;

    // Bubble-Up //
    // If we're not at the top of the heap and priority(cur) < priority(cur->parent) //
    while (index > 1 && heap->arr[index].priority < heap->arr[index / 2].priority) {
       // Swap cur node w/ its parent //
       HeapNode temp = heap->arr[index];
       heap->arr[index] = heap->arr[index / 2];
       heap->arr[index / 2] = temp;

       // Update indexMap for swapped nodes //
       heap->indexMap[heap->arr[index].id] = index;
       heap->indexMap[heap->arr[index / 2].id] = index / 2;

       // Move to parent level //
       index /= 2;
    }

    return true;
}


/*********************************************************************
 ** Helper function provided
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
