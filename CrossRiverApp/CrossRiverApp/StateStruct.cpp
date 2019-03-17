#include "StateStruct.h"

StateStruct::StateStruct(int boat_site){
	this->boat_site = boat_site;
    this->objectClassesNumber = 0;
}
StateStruct::StateStruct(StateStruct* stateStruct){
    this->boat_site = stateStruct->boat_site;
    this->objectClassesNumber = stateStruct->objectClassesNumber;
    for(int i=0;i<this->objectClassesNumber;i++){
        this->objectStructs[i] = new ObjectStruct(stateStruct->objectStructs[i]);
        
    }
    
    for (int i=0;i<this->objectClassesNumber;i++){//赋值StateStruct后需要重新设置object之间的关系
        for (int j=0;j<10;j++){
            if(stateStruct->objectStructs[i]->preydator[j]!=NULL)
                setPredation(stateStruct->objectStructs[i]->preydator[j]->name,this->objectStructs[i]->name);
            if(stateStruct->objectStructs[i]->natualenemy[j]!=NULL)
                setInhibition(stateStruct->objectStructs[i]->natualenemy[j]->name, stateStruct->objectStructs[i]->name);
            if(stateStruct->objectStructs[i]->competitor[j]!=NULL)
                setCompetitive(this->objectStructs[i]->name, stateStruct->objectStructs[i]->competitor[j]->name);
        }

        if(stateStruct->objectStructs[i]->master!=NULL)
            setBreeding(stateStruct->objectStructs[i]->master->name, this->objectStructs[i]->name);

        
    }
    
}
void StateStruct::addObject(string name, int leftBankNumber, int totalNumber,bool isGood){

    ObjectStruct* object = new ObjectStruct(name,leftBankNumber,totalNumber,isGood);
    this->objectStructs[this->objectClassesNumber] = object;
    this->objectClassesNumber ++;
    
}
void StateStruct::boating(int numbers[]){
    if(this->boat_site == 1){//1代表船从左往右，0代表船从右往左
        for(int i=0;i<this->objectClassesNumber;i++){
            this->objectStructs[i]->leftBankNumber -= numbers[i];
        }
    } else {
        for(int i=0;i<this->objectClassesNumber;i++){
            this->objectStructs[i]->leftBankNumber += numbers[i];
        }
    }
    
    this->boat_site = 1 - this->boat_site;
}
bool StateStruct::isEqual(StateStruct* state,int a[]){
    if(this->boat_site != 1 - state->boat_site){
        return false;
    }
   
    
    for(int i=0;i<objectClassesNumber;i++){
        if(this->objectStructs[i]->leftBankNumber != state->objectStructs[i]->leftBankNumber - a[i]* (state->boat_site*2-1)){//(state->boat_site*2-1)表示船左(boat_site = 1)减(leftBankNumber - a[i])右(boat_site = 0)加(leftBankNumber + a[i])
            return false;
        }
    }
    
    return true;
}
bool StateStruct::isEqual(StateStruct* state){
    if(this->boat_site !=  state->boat_site){
        return false;
    }
    for(int i=0;i<objectClassesNumber;i++){
        if(this->objectStructs[i]->leftBankNumber != state->objectStructs[i]->leftBankNumber){
            return false;
        }
    }
    return true;
}
int StateStruct::getObjectIndex(ObjectStruct* o){
    for (int i=0;i< this->objectClassesNumber;i++){
        
        
        if(objectStructs[i]->name == o->name){
            
            return i;
        }
    }
    return -1;
}
int StateStruct::getObjectIndex(string objectName){
    for (int i=0;i< this->objectClassesNumber;i++){
        if(objectStructs[i]->name == objectName){
            return i;
        }
    }
    return -1;
}
void StateStruct::setPredation(string preydatorObjectName, string preyObjectName){
    if(this->getObjectIndex(preyObjectName)!=-1 && this->getObjectIndex(preydatorObjectName)!=-1){
        for (int i=0;i<10;i++){
            if (this->objectStructs[this->getObjectIndex(preyObjectName)]->preydator[i] == NULL){
                this->objectStructs[this->getObjectIndex(preyObjectName)]->preydator[i] = this->objectStructs[this->getObjectIndex(preydatorObjectName)];
                break;
            }
        }
        
    }
    
}
void StateStruct::setCompetitive(string firstObjectName, string secondObjectName){
    if(this->getObjectIndex(firstObjectName)!=-1 && this->getObjectIndex(secondObjectName)!=-1){
        for (int i=0;i<10;i++){
            if (this->objectStructs[this->getObjectIndex(firstObjectName)]->competitor[i] == NULL){
                this->objectStructs[this->getObjectIndex(firstObjectName)]->competitor[i] = this->objectStructs[this->getObjectIndex(secondObjectName)];
                break;
            }
        }
    }
}
void StateStruct::setBreeding(string masterObjectName, string livestockObjectName){
    if(this->getObjectIndex(masterObjectName)!=-1 && this->getObjectIndex(livestockObjectName)!=-1){
        this->objectStructs[this->getObjectIndex(livestockObjectName)]->master = this->objectStructs[this->getObjectIndex(masterObjectName)];
    }
}
void StateStruct::setInhibition(string natualenemyObjectName,string inhibitorObjectName){
    
    if(this->getObjectIndex(natualenemyObjectName)!=-1 && this->getObjectIndex(inhibitorObjectName)!=-1){
        for (int i=0;i<10;i++){
            
            if (this->objectStructs[this->getObjectIndex(inhibitorObjectName)]->natualenemy[i] == NULL){
                this->objectStructs[this->getObjectIndex(inhibitorObjectName)]->natualenemy[i] = this->objectStructs[this->getObjectIndex(natualenemyObjectName)];
                
                break;
            }
        }
        
    }
    
}
