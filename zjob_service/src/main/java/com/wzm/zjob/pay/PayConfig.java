package com.wzm.zjob.pay;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class PayConfig {
    @Value("${Pay_Address}")
    private String payAddress;
    @Value("${Pay_Port}")
    private String payPort;

    public String getPayAddress() {
        return payAddress;
    }

    public void setPayAddress(String payAddress) {
        this.payAddress = payAddress;
    }

    public String getPayPort() {
        return payPort;
    }

    public void setPayPort(String payPort) {
        this.payPort = payPort;
    }
}
