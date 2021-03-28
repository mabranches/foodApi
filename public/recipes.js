$(document).ready(function() {
    search_timer = null
    $("#search-field input").keyup(function (e) {
        if (search_timer != null) {
            clearTimeout(search_timer);
        }
        search_timer = setTimeout(function() { search(e.target.value)}, 300);
    });
});

function search(query){
    if (query.length > 2) {
        $.get( "/search?q=" + query, function(data) {
            result_div = $('#search-result');
            result_div.empty();
            data.forEach(function (d){
               update_result(result_div, d);
            })
        }).fail(function() {
            alert( "error" );
        });
    }
}

function update_result(div, search_element){
    template = $('#search-element-template').html();
    rendered = Mustache.render(template,
        {
            id: search_element.title,
            title: search_element.title,
            thumbnail: search_element.thumbnail,
            href: search_element.href,
            ingredients: search_element.ingredients
        });
    div.append(rendered);
}