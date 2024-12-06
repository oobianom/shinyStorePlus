/*! rpkg.net | (c) Written by Obi Obianom, www.obianom.com | all rights reserved */

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
    commonerr = "An error occurred, possibly because of wrong API key or configurations. Go to https://api.rpkg.net/endp/help to learn more or contact us at https://github.com/oobianom/rpkg.net";

function prepLikeButton(e, o = null) {
  $("#"+likebuttonid+"-totalv2").html(viewscount)
    Shiny.setInputValue("feedliketracker", {
        liked: e,
        total: viewscount
    });
}

function prepFollowButton(e, o = null) {
  $("#"+followbuttonid+"-totalv2").html(followerscount)
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
