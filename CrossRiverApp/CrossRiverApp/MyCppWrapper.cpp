//
//  myCppWrapper.cpp
//  FlappyBird
//
//  Created by 杜李 on 2019/1/11.
//

#include "MyCppWrapper.hpp"
#include "MyProcessControl.h"
#ifdef __cplusplus
extern "C"{
#endif
    struct tagCpp{
        MyProcessControlClass mCpp;
    };
    struct tagCpp *GetInstance(void){
        return new struct tagCpp;
    }
    void ReleaseInstance(struct tagCpp **ppInstance){
        delete *ppInstance;
        *ppInstance = 0;
    }
    void init(struct tagCpp *pCpp,int objectsNumber,int boatMaxLoad){
        pCpp->mCpp.initClass(objectsNumber, boatMaxLoad);
        
    }
    void addObject(struct tagCpp *pCpp,int objectId,int num,int isGood,int isWaterman){
        pCpp->mCpp.addObject(objectId, num, isGood, isWaterman);
    }
    void startSearch(struct tagCpp *pCpp){
        pCpp->mCpp.heuristic();
        pCpp->mCpp.startSearch();
    }
    void setPredation(struct tagCpp *pCpp,int preydator,int prey){
        pCpp->mCpp.setPredation(preydator, prey);
    }
    void setInhibition(struct tagCpp *pCpp,int naturalenemy,int inhibitor){
        pCpp->mCpp.setInhibition(naturalenemy, inhibitor);
    }
    void setCompetitive(struct tagCpp *pCpp,int first,int second){
        pCpp->mCpp.setCompetitive(first, second);
    }
    void setBreeding(struct tagCpp *pCpp,int master,int livestock){
        pCpp->mCpp.setBreeding(master, livestock);
    }
    int* getPath(struct tagCpp *pCpp){
        return pCpp->mCpp.getPath();
    }
    
#ifdef __cplusplus
}
#endif
