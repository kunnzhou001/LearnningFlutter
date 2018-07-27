package com.example.kunn.loanflutter;

import android.content.Context;
import android.widget.Toast;

public class PlateformMethod implements PlateformMethodInterFace {

    @Override
    public void tip(Context context,String msg, int longth) {
        Toast.makeText(context,msg,longth).show();
    }
}
