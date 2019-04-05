package com.wzm.zjob.exception;

public class PositionNumException  extends Exception{
    public PositionNumException() {
        super();
    }

    public PositionNumException(String message) {
        super(message);
    }

    public PositionNumException(String message, Throwable cause) {
        super(message, cause);
    }

    public PositionNumException(Throwable cause) {
        super(cause);
    }

    protected PositionNumException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
