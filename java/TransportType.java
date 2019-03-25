package tinyb;

/**
 * TransportType determines type of bluetooth scan.
 */

/*
     Possible values:
     "AUTO"  - interleaved scan
     "BREDR" - BR/EDR inquiry
     "LE"    - LE scan only
     */
public enum TransportType{
    /**
     * interleaved scan
    */
    AUTO(0),
     /**
     * BR/EDR inquiry
     */
    BREDR(1),
     /**
     * LE scan only
     */
    LE(2),
    NONE(3),;

    private final int value;
    private TransportType(int value){
        this.value=value;
    }
    public int getValue(){
        return this.value;
    }
}