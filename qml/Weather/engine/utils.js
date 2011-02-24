function print(title, obj, recurrent, all, indent){
    if (typeof all == "undefined") {
        all=true;
    }
    if (typeof recurrent == "undefined") {
        recurrent=false;
    }
    if (recurrent == true) {
        recurrent=1;
    }
    if (typeof indent == "undefined") {
        indent="^.....";
    }
    if (recurrent==1) {
        console.log("---> " + title + ": " + obj + "; length: " + obj.length);
    }
    if (all) {
        if (obj.length) {
            for (var i = 0; i < obj.length; i++) {
                echo(obj,i,indent, title, all, recurrent);
            }
        }
        else {
            for (var i in obj) {
                echo(obj,i,indent, title, all, recurrent);
            }
        }
    }
}

function echo(obj,i,indent, title, all, recurrent) {
    if (obj[i] && obj[i]!="" && obj[i]!=null && typeof obj[i]!="undefined") {
        console.log(indent+"obj["+i+"]="+obj[i]);
        if (recurrent && recurrent<3 && (typeof obj[i] == "function" || typeof obj[i] == "object")) {
            print(title, obj[i], ++recurrent, all, indent+" ^.....");
        }
    }
}
