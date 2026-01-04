#ifndef __DEMO_UNTITLED_H_
#define __DEMO_UNTITLED_H_

#include <omnetpp.h>
using namespace omnetpp;

class untitled : public cSimpleModule
{
  private:
    long bytesReceived = 0;         // total bytes received
    simsignal_t throughputSignal;   // signal to record throughput

  protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
    virtual void finish() override;

  private:
    int messagesReceived=0;
    double delay = 0.0;
    simsignal_t msgrcvdsignal;
    simsignal_t delaySignal;
};

#endif
