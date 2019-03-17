//
//  test.c
//  FlappyBird
//
//  Created by 杜李 on 2019/1/11.
//

#include "SwiftC.h"
#include "MyCppWrapper.hpp"

struct tagCpp *pCpp;

void initC(int objectNumber,int boatMaxLoad)
{
    pCpp = GetInstance();
    init(pCpp,objectNumber, boatMaxLoad);
    
}
void addObjectC(int objectId,int num,int isGood,int isWaterman){
    addObject(pCpp,objectId, num, isGood, isWaterman);
}
void setPredationC(int preydator,int prey){
    setPredation(pCpp, preydator, prey);
}
void setInhibitionC(int naturalenemy,int inhibitor){
    setInhibition(pCpp, naturalenemy, inhibitor);
    
}
void setCompetitiveC(int first,int second){
    setCompetitive(pCpp, first, second);
}
void setBreedingC(int master,int livestock){
    setBreeding(pCpp, master, livestock);
}
int* searchC(){
    startSearch(pCpp);
    
//    ReleaseInstance(&pCpp);
    return getPath(pCpp);
}
