/*
 *  RAVL (augmented with Rank AVL) tree implementation.
 *  Author (starter code): Anya Tafliovich.
 *  Based on materials developed by F. Estrada.
*/

#include "RAVL_tree.h"

/*************************************************************************
 ** Suggested helper functions
 *************************************************************************/

/* Returns the height (number of nodes on the longest node-to-leaf path) of
 * the tree nodeed at node 'node'. Returns 0 if 'node' is NULL.  Note: this
 * should be an O(1) operation.
 */
int height(RAVL_Node* node){
  return (node == NULL) ? 0 : node->height;
}

/* Returns the size (number of nodes) of the tree nodeed at node 'node'.
 * Returns 0 if 'node' is NULL.  Note: this should be an O(1) operation.
 */
int size(RAVL_Node* node){
  return (node == NULL) ? 0 : node->size;
}

/* Updates the height of the tree nodeed at node 'node' based on the heights
 * of its children. Note: this should be an O(1) operation.
 */
void updateHeight(RAVL_Node* node){
  // Not sure if this check is necessary but it's SAFE //
  if (node == NULL){
    return;
  }

  // Leaf Node //
  if (node->left == NULL && node->right == NULL){
    node->height = 1; 
    return;
  }

  if (node->left == NULL){
    node->height = node->right->height + 1; 
    return;
  }

  if (node->right == NULL){
    node->height = node->left->height + 1; 
    return;
  }

  node->height = (node->left->height > node->right->height) ? node->left->height + 1 : node->right->height + 1;
}

/* Updates the size of the tree nodeed at node 'node' based on the sizes
 * of its children. Note: this should be an O(1) operation.
 */
void updateSize(RAVL_Node* node){
  // Not sure if this check is necessary but it's SAFE //
  if (node == NULL){
    return;
  }

  // Leaf Node //
  if (node->left == NULL && node->right == NULL){
    node->size = 1; 
    return;
  }

  if (node->left == NULL){
    node->size = node->right->size + 1; 
    return;
  }

  if (node->right == NULL){
    node->size = node->left->size + 1; 
    return;
  }

  node->size = node->left->size + node->right->size + 1;
}

/* Returns the balance factor (height of left subtree - height of right
 * subtree) of node 'node'. Returns 0 if node is NULL.  Note: this should be
 * an O(1) operation.
 */
int balanceFactor(RAVL_Node* node){
  return (node == NULL) ? 0 : height(node->left) - height(node->right);
}

/* Returns the result of performing the corresponding rotation in the RAVL
 * tree nodeed at 'node'.
 */
// single rotations: right/clockwise
RAVL_Node* rightRotation(RAVL_Node* node){
  RAVL_Node *newnode = node->left;
  RAVL_Node *tmp = newnode->right;

  newnode->right = node;
  node->left = tmp;

  return newnode;
}
// single rotations: left/counter-clockwise
RAVL_Node* leftRotation(RAVL_Node* node){
  RAVL_Node *newnode = node->right;
  RAVL_Node *tmp = newnode->left;

  newnode->left = node;
  node->right = tmp;

  return newnode;
}
// double rotation: right/clockwise then left/counter-clockwise
RAVL_Node* rightLeftRotation(RAVL_Node* node){
  node->right = rightRotation(node->right);
  return leftRotation(node);
}
// double rotation: left/counter-clockwise then right/clockwise
RAVL_Node* leftRightRotation(RAVL_Node* node){
  node->left = leftRotation(node->left);
  return rightRotation(node);
}

/* Returns the successor node of 'node'. */
RAVL_Node* successor(RAVL_Node* node){
  if (node->right == NULL){
    return NULL;
  }

  node = node->right;
  while (node->left != NULL){
    node = node->left;
  }
  return node;
}

/* Creates and returns an RAVL tree node with key 'key', value 'value', height
 * and size of 1, and left and right subtrees NULL.
 */
RAVL_Node* createNode(int key, void* value){
  RAVL_Node *newNode = (RAVL_Node *) malloc(sizeof(RAVL_Node));

  // Anyone who took CSCA48 should remember this case! //
  if (newNode == NULL){
    return NULL;
  }

  newNode->key = key;
  newNode->value = value;
  newNode->height = 1;
  newNode->size = 1;
  newNode->left = NULL;
  newNode->right = NULL;

  return newNode;
}

/*************************************************************************
 ** Provided functions
 *************************************************************************/

void printTreeInorder_(RAVL_Node* node, int offset) {
  if (node == NULL) return;
  printTreeInorder_(node->right, offset + 1);
  printf("%*s %d [%d / %d]\n", offset, "", node->key, node->height, node->size);
  printTreeInorder_(node->left, offset + 1);
}

void printTreeInorder(RAVL_Node* node) {
  printTreeInorder_(node, 0);
}

void deleteTree(RAVL_Node* node) {
  if (node == NULL) return;
  deleteTree(node->left);
  deleteTree(node->right);
  free(node);
}

/*************************************************************************
 ** Required functions
 ** Must run in O(log n) where n is the number of nodes in a tree nodeed
 **  at 'node'.
 *************************************************************************/

RAVL_Node* search(RAVL_Node* node, int key) {
  while (node != NULL){
    if (node->key == key){
      return node; // Found it! //
    }
    if (node->key > key){
      node = node->left; // Look in left subtree //
    }
    else{
      node = node->right; // Look in right subtree //
    }
  }

  return NULL; // Key not found //
}

RAVL_Node* insert(RAVL_Node* node, int key, void* value) {
  if (node == NULL) {
    return createNode(key, value);
  }

  if (node->key > key) {
    // Insert into left subtree //
    node->left = insert(node->left, key, value);
  } 
  else if (node->key < key) {
    // Insert into right subtree //
    node->right = insert(node->right, key, value);
  } 
  else {
    // If duplicate key, just update the value. (Assumption) //
    node->value = value;
    return node;
  }

  node->height = (node->left->height > node->right->height) ? node->left->height + 1 : node->right->height + 1;
  int balance = balanceFactor(node); // More efficient to compute balanceFactor() once, rather than compute height() several times //

  if (balance > 1) {
    if (node->left->key > key) { // CR //
      return rightRotation(node); 
    } 
    else {                      // CCR -> CR //
      node->left = leftRotation(node->left);
      return rightRotation(node);
    }
  }

  if (balance < -1) {
    if (node->right->key < key) { // CCR //
      return leftRotation(node);
    } 
    else {                        // CR -> CCR //
      node->right = rightRotation(node->right);
      return leftRotation(node);
    }
  }

  return node;
}


RAVL_Node* delete(RAVL_Node* node, int key) {
  if (node == NULL) {
    return NULL;
  }

  // Found the node to delete! //
  if(node->key == key){
    // No children //
    if (node->left == NULL && node->right == NULL){
      free(node);
      return NULL;
    }

    // Right Child Only //
    if (node->left == NULL){
      RAVL_Node *tmp = node->right;
      free(node);
      return tmp;
    }

    // Left Child Only //
    if (node->right == NULL){
      RAVL_Node *tmp = node->left;
      free(node);
      return tmp;
    }

    // Two children //
    RAVL_Node *tmp = successor(node->right);

    // Copy over contents of successor to soon-to-be-deleted node //
    node->key = tmp->key;
    node->value = tmp->value;

    // Delete successor //
    node->right = delete(node->right, tmp->key);
  }

  if (node->key > key){
    node->left = delete(node->left, key);
  } 
  else {
    node->right = delete(node->right, key);
  }

  // Don't forget to update height and size! //
  node->height = (node->left->height > node->right->height) ? node->left->height + 1 : node->right->height + 1;
  node->size = size(node->left) + size(node->right) + 1;

  return node;
}


int rank(RAVL_Node* node, int key) {
  if (node == NULL) {
    return NOTIN;
  }
  if (node->key > key) {
    return rank(node->left, key);
  } 
  else if (node->key < key) {
    return 1 + size(node->left) + rank(node->right, key);
  } 
  else {
    return size(node->left) + 1;
  }
}

// Equivalent to `select` //
RAVL_Node* findRank(RAVL_Node* node, int rank) {
  if (node == NULL){
    return NULL;
  }
  
  int leftSize = size(node->left) + 1;
  if (leftSize > rank) {
    return findRank(node->left, rank); // Look for `rank` in left subtree //
  }
  if (leftSize == rank) {
    return node; // Found it! //
  }
  return findRank(node->right, rank - leftSize); // Look for `rank` in right subtree //
}

