//
//  myCppWrapper.hpp
//  FlappyBird
//
//  Created by 杜李 on 2019/1/11.
//

#ifndef MyCppWrapper_hpp
#define MyCppWrapper_hpp

#include <stdio.h>
#ifdef __cplusplus
extern "C"{
#endif
    struct tagCpp *GetInstance(void);
    void  ReleaseInstance(struct tagCpp **ppInstance);
    extern void init(struct tagCpp *pCpp,int objectsNumber,int boatMaxLoad);
    extern void startSearch(struct tagCpp *pCpp);
    extern void addObject(struct tagCpp *pCpp,int objectId,int num,int isGood,int isWaterman);
    extern void setPredation(struct tagCpp *pCpp,int preydator,int prey);
    extern void setInhibition(struct tagCpp *pCpp,int naturalenemy,int inhibitor);
    extern void setCompetitive(struct tagCpp *pCpp,int first,int second);
    extern void setBreeding(struct tagCpp *pCpp,int master,int livestock);
    extern int* getPath(struct tagCpp *pCpp);
    
#ifdef __cplusplus
}
#endif
#endif /* MyCppWrapper_hpp */
