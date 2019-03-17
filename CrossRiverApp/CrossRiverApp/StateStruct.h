#ifndef StateStruct_h
#define StateStruct_h
#include <string>
#include <iostream>
using namespace std;
#include "ObjectStruct.h"
struct StateStruct{
    ObjectStruct* objectStructs[20];
    int boat_site;
    int objectClassesNumber;
    StateStruct(int boat_site);
    StateStruct(StateStruct*);
    
    void addObject(string name,int leftBankNumber,int totalNumber,bool isGood);
    void boating(int numbers[]);
    bool isEqual(StateStruct*,int a[]);//预测移动后是否状态相等
    bool isEqual(StateStruct*);//预测状态是否相等
    int getObjectIndex(ObjectStruct*);
    int getObjectIndex(string ObjectName);
    void setPredation(string preydatorObjectName,string preyObjectName);
    void setCompetitive(string firstObjectName,string seconddatorObjectName);
    void setBreeding(string masterObjectName,string livestockObjectName);
    void setInhibition(string natualenemyObjectName,string inhibitorObjectName);
};
#endif /* StateStruct_h */
