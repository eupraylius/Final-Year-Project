#include "untitled.h"

Define_Module(untitled);

void untitled::initialize()
{
    // Register signal for OMNeT++ stats
    throughputSignal = registerSignal("throughput");

    // Send init message to the other node
    cMessage *information = new cMessage("information");
    send(information, "port$o");
    msgrcvdsignal = registerSignal("messagesReceived");
    delaySignal = registerSignal("delay");
}

void untitled::handleMessage(cMessage *msg)
{
    // Count received message as 1k bytes
    bytesReceived += 1000;

    EV << getName() << " received message. Total bytes = " << bytesReceived << endl;

    cMessage *reply = new cMessage("reply");

    messagesReceived++;
    delay = uniform(1, 3);
    sendDelayed(reply, delay, "port$o");

//    delete msg;
    emit(msgrcvdsignal,messagesReceived);
    emit(delaySignal,delay);
}

void untitled::finish()
{
    // Calculate throughput in b/s
    double throughput = (bytesReceived * 8.0) / simTime().dbl();

    EV << getName() << " final throughput = " << throughput << " bps" << endl;

    // Record the throughput signal
    emit(throughputSignal, throughput);
}
