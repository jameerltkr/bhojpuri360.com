$(function () {
    //$('head').append('<link href="https://api.autoaddress.ie/2.0/control/css/autoaddress.min.css" type="text/css"/>');

    $('head').append('<link href="/resource/1402932484000/AutoAddressCSS" rel="stylesheet" type="text/css"/>');

    var queries = {};
    $.each($('script[src*="AutoAddressJs?"]').attr('src').substr(1).split('?')[1].split('&'), function (c, q) {
        var i = q.split('=');
        queries[i[0].toString()] = i[1].toString();
    });

    if (queries.key == "" || queries.textboxId == "")
        return;     // Key or Textbox Id is not found

    var key = queries.key;
    var textboxId = queries.textboxId;

    $("#" + textboxId).css('display', 'none');
    $("#" + textboxId).closest('td').append("<div id='myDiv'></div>")

    var language = queries.language;
    var autocomplete = queries.autocomplete;
    var autocompleteMinChars = queries.autocompleteMinChars;
    var optionsLimit = queries.optionsLimit;
    var vanityMode = queries.vanityMode;
    var addressProfile = queries.addressProfile;
    var width = queries.width;

    $("#myDiv").AutoAddress({
        // Key
        key: key,

        language: language != "" ? language : "EN",
        autocomplete: autocomplete != "" ? autocomplete : true,
        autocompleteMinChars: autocompleteMinChars != "" ? autocompleteMinChars : 3,
        optionsLimit: optionsLimit != "" ? optionsLimit : 20,
        vanityMode: vanityMode != "" ? vanityMode : false,
        addressProfile: addressProfile != "" ? addressProfile : "None",
        width: width != "" ? width : "Auto",

        // Address Found Callback
        onAddressFound: function (args) {
            if (args.postalAddress) {
                $.each(args.postalAddress, function (index, value) {
                    if (index == 0) {
                        $("#" + textboxId).text(value);
                        //$('.autoaddress-text-box').val(value);
                        $('.autoaddress-control').find('input').val(value);
                    }
                    if (index == 1)
                        $('#con19city').val(value);
                    if (index == 2)
                        $('#con19state').val(value);
                    if (index == 3)
                        $('#con19country').val(value);
                });
            }
            if (args.postcode) {
                //$(".autoaddress-text-box").val(args.postcode);
                $("#con19zip").val(args.postcode);
            }
        },

        // Search Completed Callback
        onSearchCompleted: function (data) {

        },

        // Error Callback
        onLookupError: function () {
            errorMessageLabel: "Sorry, an unexpected error has occurred.";
        }
    });

    if ($(".autoaddress-button").length != 0)
        $(".autoaddress-button").remove();

    $(".autoaddress-control").attr('style', 'margin:0');

    $(".autoaddress-text-box").removeClass();
    $('.autoaddress-control').find('input').attr('style', 'height:51px;width:190px;');

    if ($("#" + textboxId).val() != "") {
        //$('.autoaddress-text-box').val($("#" + temp_txtbox_id).val());
        $('.autoaddress-control').find('input').val($("#" + textboxId).val());
    }
});