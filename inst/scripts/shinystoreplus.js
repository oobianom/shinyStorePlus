/*! shinyStorePlus v0.7 | (c) Written by Obi Obianom, www.obianom.com | all rights reserved */
function initialize(a) {
    let b = "app" + hashCode(a.appname),
        c = new Dexie(b);
    c.version(1).stores({ shinyStoresPlus: "++id,app,var,type,value,created" }),
        retrieveAllInputs(b, c).then(function (a) {
            a.length && returnValues(a);
        }),
        "boolean" == typeof a.input && a.input && initializeAllInputs(b, c),
        "object" == typeof a.input && a.input.length && initializeAllInputs(b, c, a.input),
        "boolean" == typeof a.output && a.output && initializeAllOutputs(b, c);
}
function initializeAllOutputs(a, b, c = null) {
    $.each([".shiny-text-output.shiny-bound-output"], function (e, d) {
        $(d).each(function (f, g) {
            let h = 0,
                e = this,
                i = $(e).attr("id"),
                j = $(e).html();
            $(e).on("DOMSubtreeModified", function () {
                (j = $(e).html()),
                    getInputById(a, i, d, b).then(function (e) {
                        void 0 != e && (h = e.id), 0 == h ? setInputById(a, i, d, j, c, b) : updateInputById(a, i, d, j, h, c, b);
                    });
            });
        });
    });
}
function initializeAllInputs(a, b, c = null) {
    $.each(["input.shiny-bound-input", "textarea.shiny-bound-input", "select.shiny-bound-input"], function (e, d) {
        $(d).each(function (g, h) {
            let i = 0,
                j = d,
                e = this,
                f = $(e).attr("id");
            void 0 == f && console.log($(e).attr("name") + "is undefined.");
            let k = $(e).val();
            $(e).change(function () {
                "checkbox" == $(e).attr("type") ? ((d = "checkbox.shiny-bound-input"), (k = $(e).is(":checked"))) : ((d = j), (k = $(e).val())),
                    getInputById(a, f, d, b).then(function (e) {
                        void 0 != e && (i = e.id), 0 == i ? setInputById(a, f, d, k, c, b) : updateInputById(a, f, d, k, i, c, b);
                    });
            }),
                $(e).keyup(function () {
                    (d = j),
                        (k = $(e).val()),
                        getInputById(a, f, d, b).then(function (e) {
                            void 0 != e && (i = e.id), 0 == i ? setInputById(a, f, d, k, c, b) : updateInputById(a, f, d, k, i, c, b);
                        });
                });
        });
    });
    let d = [],
        e = [];
    $.each(["div.shiny-bound-input:has(div.shiny-options-group)", "div.shiny-bound-input:has(input[type='text'])"], function (g, f) {
        $(f).each(function (h, i) {
            let j = 0,
                k = $(this).attr("id"),
                l = $(this).val();
            $(this)
                .find('input[type="radio"]')
                .change(function () {
                    (f = "radio.shiny-bound-input"),
                        (l = $(this).val()),
                        getInputById(a, k, f, b).then(function (d) {
                            void 0 != d && (j = d.id), 0 == j ? setInputById(a, k, f, l, c, b) : updateInputById(a, k, f, l, j, c, b);
                        });
                }),
                (d[h] = []),
                $(this)
                    .find('input[type="checkbox"]')
                    .each(function (d, e) {
                        (f = "checkboxgroup.shiny-bound-input"), (l = $(this).val());
                        var g = $(this).attr("name");
                        $(this).change(function () {
                            (l = []),
                                document.getElementsByName(g).forEach((a) => {
                                    a.checked ? l.push(a.value) : (l = removeItemOnce(l, a.value)), (l = [...new Set(l)]);
                                }),
                                getInputById(a, k, f, b).then(function (d) {
                                    void 0 != d && (j = d.id), 0 == j ? setInputById(a, k, f, l, c, b) : updateInputById(a, k, f, l, j, c, b);
                                });
                        });
                    });
            let g = $(this).find('input[type="text"]');
            1 == g.length &&
                g.change(function () {
                    (f = "dateinput.shiny-bound-input"),
                        (l = $(this).val()),
                        getInputById(a, k, f, b).then(function (d) {
                            void 0 != d && (j = d.id), 0 == j ? setInputById(a, k, f, l, c, b) : updateInputById(a, k, f, l, j, c, b);
                        });
                }),
                (e[h] = []),
                2 == g.length &&
                    g.each(function () {
                        (f = "dateinputrange.shiny-bound-input"),
                            $(this).change(function () {
                                (e[h] = [g.first().val(), g.first().next().next().val()]),
                                    getInputById(a, k, f, b).then(function (d) {
                                        void 0 != d && (j = d.id), 0 == j ? setInputById(a, k, f, e[h], c, b) : updateInputById(a, k, f, e[h], j, c, b);
                                    });
                            });
                    });
        });
    });
}
function removeItemOnce(a, c) {
    var b = a.indexOf(c);
    return b > -1 && a.splice(b, 1), a;
}
function replaceNonAlphanumeric(a) {
    return a.replace(/[^A-Za-z0-9]/g, "");
}
function timeIntVal() {
    return Math.floor(Date.now());
}
function hashCode(b) {
    let a = 0;
    if (0 == b.length) return a;
    for (i = 0; i < b.length; i++) (a = (a << 5) - a + (ch = b.charCodeAt(i))), (a &= a);
    return a;
}
function retrieveAllInputs(a, b) {
    return b.shinyStoresPlus.where({ app: a }).toArray();
}
function getInputById(b, c, e, d) {
    let a = d.shinyStoresPlus.where({ app: b, var: c });
    return (
        a.toArray().then(function (a) {
            a.length > 1 && d.shinyStoresPlus.delete(a[1].id);
        }),
        a.first()
    );
}
function setInputById(d, b, e, f, c, g) {
    let a = !1;
    null == c ? (a = !0) : c.includes(b) && (a = !0),
        a &&
            g.shinyStoresPlus.add({ app: d, var: b, type: e, value: f, created: timeIntVal() }).catch(function (a) {
                console.error("Unable to update the input:" + a.stack);
            });
}
function updateInputById(d, b, h, e, f, c, g) {
    let a = !1;
    null == c ? (a = !0) : c.includes(b) && (a = !0), a && g.shinyStoresPlus.update(f, { app: d, var: b, value: e, created: timeIntVal() });
}
function clearDatabase(a) {
    console.log("Clearing storage for " + a + "..."), new Dexie(a).delete();
}
function sendWarning(a) {
    Shiny.setInputValue("transmittedWarningx0x0ssp", JSON.stringify(a));
}
function returnValues(a) {
    Shiny.setInputValue("transmittedDatax0x", JSON.stringify(a));
}
Shiny.addCustomMessageHandler("retriever", function (a) {
    void 0 !== a && initialize(a);
}),
    Shiny.addCustomMessageHandler("clearStorage", function (a) {
        clearDatabase("app" + hashCode(a));
    });

$(document).on('shiny:connected', function(event) {
  const currURL = new URL(window.location.href);
    var dataJSON = {};
currURL.searchParams.forEach(function(value, key) {
  dataJSON[key] = value;
});
Shiny.setInputValue("sSP1locationParams", JSON.stringify(dataJSON));
});

