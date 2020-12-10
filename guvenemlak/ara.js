
        $(function () {
            $("#aramayap").autocomplete({
                source: function (request, response) {
                    var param = { empdetails: $('#aramayap').val() };
                    $.ajax({
                        url: "aramakodlari.aspx/GetEmp",
                        data: JSON.stringify(param),
                        type: "post",
                        contentType: "application/json; charset=utf-8",
                        datafilter: function (data) { return data; },
                        success: function (data) {
                            response($.map(data.d, function (item) { return { value: item } }))
                        },
                    });

                },
                minLength: 1
            });
        });
