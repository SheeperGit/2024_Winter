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
int height(RAVL_Node* node);

/* Returns the size (number of nodes) of the tree rooted at node 'node'.
 * Returns 0 if 'node' is NULL.  Note: this should be an O(1) operation.
 */
int size(RAVL_Node* node);

/* Updates the height of the tree rooted at node 'node' based on the heights
 * of its children. Note: this should be an O(1) operation.
 */
void updateHeight(RAVL_Node* node);

/* Updates the size of the tree rooted at node 'node' based on the sizes
 * of its children. Note: this should be an O(1) operation.
 */
void updateSize(RAVL_Node* node);

/* Returns the balance factor (height of left subtree - height of right
 * subtree) of node 'node'. Returns 0 if node is NULL.  Note: this should be
 * an O(1) operation.
 */
int balanceFactor(RAVL_Node* node);

/* Returns the result of performing the corresponding rotation in the RAVL
 * tree rooted at 'node'.
 */
// single rotations: right/clockwise
RAVL_Node* rightRotation(RAVL_Node* node);
// single rotations: left/counter-clockwise
RAVL_Node* leftRotation(RAVL_Node* node);
// double rotation: right/clockwise then left/counter-clockwise
RAVL_Node* rightLeftRotation(RAVL_Node* node);
// double rotation: left/counter-clockwise then right/clockwise
RAVL_Node* leftRightRotation(RAVL_Node* node);

/* Returns the successor node of 'node'. */
RAVL_Node* successor(RAVL_Node* node);

/* Creates and returns an RAVL tree node with key 'key', value 'value', height
 * and size of 1, and left and right subtrees NULL.
 */
RAVL_Node* createNode(int key, void* value);

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
  return NULL;
}

RAVL_Node* insert(RAVL_Node* node, int key, void* value) {
  return NULL;
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
