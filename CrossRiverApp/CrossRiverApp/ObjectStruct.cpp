//
//  Object.cpp
//  CrossRiver
//
//  Created by 杜李 on 2018/12/21.
//  Copyright © 2018年 杜李. All rights reserved.
//

#include "ObjectStruct.h"
ObjectStruct::ObjectStruct(string name,int totalNumber,int leftBankNumber,bool isGood){

    this->name = name;
    this->leftBankNumber = leftBankNumber;
    this->totalNumber = totalNumber;
    this->isGood = isGood;
    
    for (int i=0;i<10;i++){
        this->preydator[i] = NULL;
        this->natualenemy[i] = NULL;
        this->competitor[i] = NULL;
    }
   
    
    
    this->master = NULL;
    
}
ObjectStruct::ObjectStruct(ObjectStruct* object){
    
    
    this->isGood = object->isGood;
    this->name = object->name;
    this->leftBankNumber = object->leftBankNumber;
    this->totalNumber = object->totalNumber;
    for (int i=0;i<10;i++){
        this->preydator[i] = NULL;
        this->natualenemy[i] = NULL;
        this->competitor[i] = NULL;
    }
    
    
    this->master = NULL;
}
