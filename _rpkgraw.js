/*! rpkg.net | (c) Written by Obi Obianom, www.obianom.com | all rights reserved */


   d888888o.   8 8888        8  8 8888 b.             8 `8.`8888.      ,8' d888888o. 8888888 8888888888 ,o888888o.     8 888888888o.   8 8888888888   8 888888888o   8 8888      8 8888      88    d888888o.
 .`8888:' `88. 8 8888        8  8 8888 888o.          8  `8.`8888.    ,8'.`8888:' `88.     8 8888    . 8888     `88.   8 8888    `88.  8 8888         8 8888    `88. 8 8888      8 8888      88  .`8888:' `88.
 8.`8888.   Y8 8 8888        8  8 8888 Y88888o.       8   `8.`8888.  ,8' 8.`8888.   Y8     8 8888   ,8 8888       `8b  8 8888     `88  8 8888         8 8888     `88 8 8888      8 8888      88  8.`8888.   Y8
 `8.`8888.     8 8888        8  8 8888 .`Y888888o.    8    `8.`8888.,8'  `8.`8888.         8 8888   88 8888        `8b 8 8888     ,88  8 8888         8 8888     ,88 8 8888      8 8888      88  `8.`8888.
  `8.`8888.    8 8888        8  8 8888 8o. `Y888888o. 8     `8.`88888'    `8.`8888.        8 8888   88 8888         88 8 8888.   ,88'  8 888888888888 8 8888.   ,88' 8 8888      8 8888      88   `8.`8888.
   `8.`8888.   8 8888        8  8 8888 8`Y8o. `Y88888o8      `8. 8888      `8.`8888.       8 8888   88 8888         88 8 888888888P'   8 8888         8 888888888P'  8 8888      8 8888      88    `8.`8888.
    `8.`8888.  8 8888888888888  8 8888 8   `Y8o. `Y8888       `8 8888       `8.`8888.      8 8888   88 8888        ,8P 8 8888`8b       8 8888         8 8888         8 8888      8 8888      88     `8.`8888.
8b   `8.`8888. 8 8888        8  8 8888 8      `Y8o. `Y8        8 8888   8b   `8.`8888.     8 8888   `8 8888       ,8P  8 8888 `8b.     8 8888         8 8888         8 8888      ` 8888     ,8P 8b   `8.`8888.
`8b.  ;8.`8888 8 8888        8  8 8888 8         `Y8o.`        8 8888   `8b.  ;8.`8888     8 8888    ` 8888     ,88'   8 8888   `8b.   8 8888         8 8888         8 8888        8888   ,d8P  `8b.  ;8.`8888
 `Y8888P ,88P' 8 8888        8  8 8888 8            `Yo        8 8888    `Y8888P ,88P'     8 8888       `8888888P'     8 8888     `88. 8 888888888888 8 8888         8 888888888888 `Y88888P'    `Y8888P ,88P'


document.addEventListener("DOMContentLoaded", function() {
    Shiny.addCustomMessageHandler("triggerViewsLikesFollows", function(m) {
        likebuttonid = m.likes
        followbuttonid = m.follows
        viewsbuttonid = m.views
        if (m.follows != null) {
            fetchFollowing(api)
            ewl("#" + followbuttonid).then((e) => {
                e.addEventListener(clik, function() {
                    toggleFollow(api);
                });
            })
        }
        if (m.views != null) updateViews(api, m.views)
        if (m.likes != null) {
            fetchLike(api)
            ewl("#" + likebuttonid).then((e) => {
                e.addEventListener(clik, function() {
                    toggleLike(api);
                });
            })
        }


    });
});
const eapi = document.getElementById("rpkgapiscript");
const api = eapi.getAttribute("identifier"),
    likeic = "Like",
    likeib = "♥",
    followc = "Follow",
    followb = "★",
    clik = "click";
var apiendpoint = "https://api.rpkg.net/endp/",
    viewsbuttonid = "views",
    liked00x020 = !1,
    liked00x040 = !1,
    likebuttonid = "button1",
    liketext = document.querySelector(likebuttonid + " .te1x1tres"),
    likecount = document.querySelector(likebuttonid + " .tex1tc1ount"),
    followd00x020 = !1,
    followd00x040 = !1,
    followbuttonid = "follow1",
    followtext = document.querySelector(followbuttonid + " .te1x1tres"),
    followcount = document.querySelector(followbuttonid + " .tex1tc1ount"),
    viewsname = " views",
    viewscount = 0,
    methd = "GET",
    followerscount = 0,
    commonerr = "An error occurred, possibly because of wrong API key or configurations. Go to https://api.rpkg.net/endp/help to learn more or open an issue with us at https://github.com/oobianom/rpkg.api/issues";
var fchgc = vchgc = "exc"
function prepLikeButton(e, o = null) {
  if(vchgc == "exc") vchgc = e;
  let altc = vchgc == true ? viewscount - 1 : viewscount + 1
  $("#"+likebuttonid+"-totalv2").html($("#"+likebuttonid+"-totalv2").html().toString() === viewscount.toString() ? altc : viewscount)
    Shiny.setInputValue("feedliketracker", {
        liked: e,
        total: viewscount
    });
}

function prepFollowButton(e, o = null) {
   if(fchgc == "exc") fchgc = e;
  let altc = fchgc == true ? followerscount - 1 : followerscount + 1
  $("#"+followbuttonid+"-totalv2").html($("#"+followbuttonid+"-totalv2").html().toString() === followerscount.toString() ? altc : followerscount)
    Shiny.setInputValue("feedfollowtracker", {
        followed: e,
        total: followerscount
    });
}

function updateViewId(e, o) {
  $("#"+viewsbuttonid).html(e)
    Shiny.setInputValue("totalviewstracker", e);
}

function toggleLike(e) {
    try {
        let o = new XMLHttpRequest();
        o.open(methd, apiendpoint + "likeornot/" + e + "?type=ssl"),
            o.send(),
            (o.responseType = "json"),
            (o.onload = () => {
                if (4 == o.readyState && 200 == o.status) {
                    let e = o.response;
                    if (5 == e.detached) return alert(commonerr), !1;
                    (window.liked00x020 = Boolean(e.attached[0])), prepLikeButton(window.liked00x020);
                } else console.log(`Error: ${o.status}`);
            });
    } catch (t) {
        console.log("The following error has occurred due to misconfigurations"), console.log(t.message);
    }
}

function toggleFollow(e) {
    try {
        let o = new XMLHttpRequest();
        o.open(methd, apiendpoint + "followmeornot/" + e + "?type=ssl"),
            o.send(),
            (o.responseType = "json"),
            (o.onload = () => {
                if (4 == o.readyState && 200 == o.status) {
                    let e = o.response;
                    if (5 == e.detached) return alert(commonerr), !1;
                    (window.followd00x020 = Boolean(e.attached[0])), prepFollowButton(window.followd00x020);
                } else console.log(`Error: ${o.status}`);
            });
    } catch (t) {
        console.log("The following error has occurred due to misconfigurations"), console.log(t.message);
    }
}

function fetchLike(e) {
    try {
        let o = new XMLHttpRequest();
        o.open(methd, apiendpoint + "fetchlikes/" + e + "?type=ssl"),
            o.send(),
            (o.responseType = "json"),
            (o.onload = () => {
                if (4 == o.readyState && 200 == o.status) {
                    let e = o.response;
                    if (5 == e.detached) return alert(commonerr), !1;
                    (window.viewscount = e.attached[0]), (window.liked00x040 = Boolean(e.liked[0])), prepLikeButton(liked00x040, viewscount);
                } else console.log(`Error: ${o.status}`);
            });
    } catch (t) {
        console.log("The following error has occurred due to misconfigurations"), console.log(t.message);
    }
    return viewscount;
}

function fetchFollowing(e) {
    try {
        let o = new XMLHttpRequest();
        o.open(methd, apiendpoint + "fetchfollow/" + e + "?type=ssl"),
            o.send(),
            (o.responseType = "json"),
            (o.onload = () => {
                if (4 == o.readyState && 200 == o.status) {
                    let e = o.response;
                    if (5 == e.detached) return alert(commonerr), !1;
                    (window.followerscount = e.attached[0]), (window.followd00x040 = Boolean(e.liked[0])), prepFollowButton(followd00x040, followerscount);
                } else console.log(`Error: ${o.status}`);
            });
    } catch (t) {
        console.log("The following error has occurred due to misconfigurations"), console.log(t.message);
    }
    return followerscount;
}

function updateViews(e, o) {
    let t = new XMLHttpRequest();
    t.open(methd, apiendpoint + "updateviews/" + e + "?type=ssl"),
        t.send(),
        (t.responseType = "json"),
        (t.onload = () => {
            if (4 == t.readyState && 200 == t.status) {
                let e = t.response;
                if (5 == e.detached) return alert(commonerr), !1;
                updateViewId(e.attached[0] + viewsname, o);
            } else console.log(`Error: ${t.status}`);
        });
}

function ewl(e) {
    return new Promise((o) => {
        if (document.querySelector(e)) return o(document.querySelector(e));
        let t = new MutationObserver((n) => {
            document.querySelector(e) && (o(document.querySelector(e)), t.disconnect());
        });
        t.observe(document.body, {
            childList: !0,
            subtree: !0
        });
    });
}

