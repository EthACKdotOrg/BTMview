/**
 *
 *  UTF-8 data encode / decode
 *  http://www.webtoolkit.info/
 *
 **/
var Utf8 = {
  // public method for url encoding
  encode : function (string) {
    string = string.replace(/\r\n/g,"\n");
    var utftext = "";
    for (var n = 0; n < string.length; n++) {
      var c = string.charCodeAt(n);
      if (c < 128) {
        utftext += String.fromCharCode(c);
      }
      else if((c > 127) && (c < 2048)) {
        utftext += String.fromCharCode((c >> 6) | 192);
        utftext += String.fromCharCode((c & 63) | 128);
      }
      else {
        utftext += String.fromCharCode((c >> 12) | 224);
        utftext += String.fromCharCode(((c >> 6) & 63) | 128);
        utftext += String.fromCharCode((c & 63) | 128);
      }
    }
    return utftext;
  },
  // public method for url decoding
  decode : function (utftext) {
    var string = "";
    var i = 0;
    var c = c1 = c2 = 0;
    while ( i < utftext.length ) {
      c = utftext.charCodeAt(i);
      if (c < 128) {
        string += String.fromCharCode(c);
        i++;
      }
      else if((c > 191) && (c < 224)) {
        c2 = utftext.charCodeAt(i+1);
        string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
        i += 2;
      }
      else {
        c2 = utftext.charCodeAt(i+1);
        c3 = utftext.charCodeAt(i+2);
        string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
        i += 3;
      }
    }
    return string;
  }
}
/*
 * http://snipplr.com/view/634/replace-newlines-with-br-platform-safe/
 */
function nl2br(text){
  text = escape(text);
  if(text.indexOf('%0D%0A') > -1){
    re_nlchar = /%0D%0A/g ;
  }else if(text.indexOf('%0A') > -1){
    re_nlchar = /%0A/g ;
  }else if(text.indexOf('%0D') > -1){
    re_nlchar = /%0D/g ;
  } else {
    re_nlchar = /1_1_1_1_1_1_1_1/g;
  }
  return unescape( text.replace(re_nlchar,'<br>') );
}

function timestamp2dateTime(t) {
  var date = new Date(t*1000);
  return date.toDateString() +' at '+ date.toLocaleTimeString();
}

function br2nl(text){
  return text.replace(/<br\s*\/?>/mg, "\n");
}

function imgStatus(stat) {
  var status_img = 'ok';
  if (stat == 'notfound') {
    status_img = 'remove';
  } else if (stat == 'msgqueued') {
    status_img = 'time';
  } else if (stat == 'broadcastqueued') {
    status_img = 'time';
  } else if (stat == 'broadcastsent') {
    status_img = 'upload';
  } else if (stat == 'doingpubkeypow') {
    status_img = 'time';
  } else if (stat == 'awaitingpubkey') {
    status_img = 'time';
  } else if (stat == 'doingmsgpow') {
    status_img = 'time';
  } else if (stat == 'forcepow') {
    status_img = 'flash';
  } else if (stat == 'msgsent') {
    status_img = 'upload';
  } else if (stat == 'msgsentnoackexpected') {
    status_img = 'ok';
  } else if (stat == 'ackreceived') {
    status_img = 'ok';
  }

  return status_img
}
