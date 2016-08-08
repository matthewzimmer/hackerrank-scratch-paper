#include <vector>
#include <iostream>
using namespace std;

struct node
{
    int data;
    node* left = NULL;
    node* right = NULL;
};

bool rootPrinted = false;
vector< vector< int > > levels;

node* test1() {
    node *root = new node;
    root->data = 3;

    root->left = new node;
    root->left->data = 5;
    root->left->left = new node;
    root->left->left->data = 1;
    root->left->right = new node;
    root->left->right->data = 4;

    root->right = new node;
    root->right->data = 2;
    root->right->left = new node;
    root->right->left->data = 6;

    return root;
}

node* test2() {
    // 1 3 2 5 4 6 7 9 8 11 13 12 10 15 14
    //                    1
    //            /               \
    //           3                  2
    //       /      \           /      \
    //     5          4        6         7
    //   /  \        / \      / \       / \
    //  9     8    11   13  12   10   15   14
    node *root = new node;
    root->data = 1;

    root->left = new node;
    root->left->data = 3;

    root->left->left = new node;
    root->left->left->data = 5;
    root->left->left->left = new node;
    root->left->left->left->data = 9;
    root->left->left->right = new node;
    root->left->left->right->data = 8;

    root->left->right = new node;
    root->left->right->data = 4;
    root->left->right->left = new node;
    root->left->right->left->data = 11;
    root->left->right->right = new node;
    root->left->right->right->data = 13;

    root->right = new node;
    root->right->data = 2;

    root->right->left = new node;
    root->right->left->data = 6;
    root->right->left->left = new node;
    root->right->left->left->data = 12;
    root->right->left->right = new node;
    root->right->left->right->data = 10;

    root->right->right = new node;
    root->right->right->data = 7;
    root->right->right->left = new node;
    root->right->right->left->data = 15;
    root->right->right->right = new node;
    root->right->right->right->data = 14;

    return root;
}

void printData(node* theNode);
void printNodeLevels(node* node);

void printData(node* theNode) {
    if(theNode != NULL) {
        cout << to_string(theNode->data) << " ";
    }
}

void printVector() {
    vector< vector< int > >::iterator it;  // declare an iterator to a vector of vector< int >s
    for(it=levels.begin() ; it < levels.end(); it++ ) {
        vector< int > nextLevels = *it;
        vector< int >::iterator jit;
        for(jit=nextLevels.begin() ; jit < nextLevels.end(); jit++ ) {
            cout << *jit << " ";  // prints d.
        }
    }
}

void insertLevels(vector<int> nextLevels) {
    levels.push_back(nextLevels);
}

void printNodeLevels(node* theNode) {
    if(theNode != NULL) {
        vector<int> nextLevels;
        if(theNode->left != NULL) {
            printData(theNode->left);
//            nextLevels.push_back(theNode->left->data);
        }
        if(theNode->right != NULL) {
            printData(theNode->right);
//            nextLevels.push_back(theNode->right->data);
        }
//        insertLevels(nextLevels);
    }
}

void run(node* theNode) {
    if(theNode->left != NULL)
        printNodeLevels(theNode->left);
    if(theNode->right != NULL)
        printNodeLevels(theNode->right);
    if(theNode->left != NULL)
        run(theNode->left);
    if(theNode->right != NULL)
        run(theNode->right);
}

void LevelOrder(node* root) {
//    vector<int> nextLevels;
//    nextLevels.push_back(root->data);
//    insertLevels(nextLevels);
    printData(root);
    printNodeLevels(root);
    run(root);
//    printVector();
}


int main() {
    LevelOrder(test2());
    return 0;
}