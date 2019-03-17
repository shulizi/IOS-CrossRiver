//
//  test.h
//  FlappyBird
//
//  Created by 杜李 on 2019/1/11.
//

#ifndef test_h
#define test_h

#include <stdio.h>
void initC(int objectNumber,int boatMaxLoad);
void addObjectC(int objectId,int num,int isGood,int isWaterman);
int* searchC();
void setPredationC(int preydator,int prey);
void setInhibitionC(int naturalenemy,int inhibitor);
void setCompetitiveC(int first,int second);
void setBreedingC(int master,int livestock);
#endif /* test_h */
