//
//  Object.hpp
//  CrossRiver
//
//  Created by 杜李 on 2018/12/21.
//  Copyright © 2018年 杜李. All rights reserved.
//

#ifndef ObjectStruct_h
#define ObjectStruct_h
#include <string>
#include <stdio.h>
using namespace std;
struct ObjectStruct{
    
    ObjectStruct* preydator[10];
    
    ObjectStruct* natualenemy[10];
    
    ObjectStruct* competitor[10];
    
    ObjectStruct* master;
    string name;
    bool isGood;//只有isGood为真的时候才需要运送到河对岸
    int leftBankNumber;
    int totalNumber;
    ObjectStruct(string name,int totalNumber,int leftBankNumber,bool isGood);
    ObjectStruct(ObjectStruct*);
};
#endif 
