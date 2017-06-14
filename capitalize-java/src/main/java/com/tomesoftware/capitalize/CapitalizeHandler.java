package com.tomesoftware.capitalize;

public class CapitalizeHandler implements CapitalizeService.Iface {

    public String capitalize(String text) {
        return text.toUpperCase();
    }

}
