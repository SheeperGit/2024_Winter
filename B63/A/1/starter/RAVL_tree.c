/*
 *  RAVL (augmented with Rank AVL) tree implementation.
 *  Author (starter code): Anya Tafliovich.
 *  Based on materials developed by F. Estrada.
*/

#include "RAVL_tree.h"

/*************************************************************************
 ** Suggested helper functions
 *************************************************************************/

/* Returns the height (number of nodes on the longest root-to-leaf path) of
 * the tree rooted at node 'node'. Returns 0 if 'node' is NULL.  Note: this
 * should be an O(1) operation.
 */
int height(RAVL_Node* node){
  return (node == NULL) ? 0 : node->height;
}

/* Returns the size (number of nodes) of the tree rooted at node 'node'.
 * Returns 0 if 'node' is NULL.  Note: this should be an O(1) operation.
 */
int size(RAVL_Node* node){
  return (node == NULL) ? 0 : node->size;
}

/* Updates the height of the tree rooted at node 'node' based on the heights
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

/* Updates the size of the tree rooted at node 'node' based on the sizes
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
 * tree rooted at 'node'.
 */
// single rotations: right/clockwise
RAVL_Node* rightRotation(RAVL_Node* node){
  RAVL_Node *newRoot = node->left;
  RAVL_Node *tmp = newRoot->right;

  newRoot->right = node;
  node->left = tmp;

  return newRoot;
}
// single rotations: left/counter-clockwise
RAVL_Node* leftRotation(RAVL_Node* node){
  RAVL_Node *newRoot = node->right;
  RAVL_Node *tmp = newRoot->left;

  newRoot->left = node;
  node->right = tmp;

  return newRoot;
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
 ** Must run in O(log n) where n is the number of nodes in a tree rooted
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
  if (height(node->left) - height(node->right) > 1){
    RAVL_Node *problemNode = node->left;
    if (height(problemNode->left) >= height(problemNode->right)){
      rightRotation(problemNode); // Assign to which node? Create + Fill node where?
    }
    else {
      leftRightRotation(problemNode); // Assign to which node? Create + Fill node where?
    }
  }
  else if (height(node->right) - height(node->left) > 1){
    RAVL_Node *problemNode = node->right;
    if (height(problemNode->left) <= height(problemNode->right)){
      leftRotation(problemNode); // Assign to which node? Create + Fill node where?
    }
    else {
      rightLeftRotation(problemNode); // Assign to which node? Create + Fill node where?
    }
  }
  else {
    // Insert normally somehow?
  }
}

RAVL_Node* delete(RAVL_Node* node, int key) {
  return NULL;
}

int rank(RAVL_Node* node, int key) {
  return NOTIN;
}

RAVL_Node* findRank(RAVL_Node* node, int rank) {
  return NULL;
}
