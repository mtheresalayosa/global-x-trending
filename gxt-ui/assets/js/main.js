import { numberFormatter } from './number_formatter.js';
function showDetails(data, rank) {
    const tdata = JSON.parse(data);
    var detailsbox = document.getElementsByClassName("details-box")[0];
    detailsbox.style.visibility = "visible";
    document.getElementsById("trend-keyword").text = tdata.name;
    document.getElementsById("trend-location").text = tdata.location;
    document.getElementsById("trend-rank").text = tdata.rank;
    document.getElementsById("trend-volume").text = numberFormatter(tdata.tweet_volumes[0].volume, 1);
}
$(document).ready(function(){
    $(".details-box").hide();
    
    $.get("http://localhost:3000/trends/global_trends", function(res) { 
        let topTrends = "";
        const rdata = res;
        for(var i = 0; i < 10; i++) {
            var tdata = JSON.stringify(rdata[i]);
            console.log(`tdata= ${tdata}`)
            topTrends += "<tr>";
            topTrends += "<td>"+rdata[i].name+"</td>";
            topTrends += `<td onclick='showDetails(${tdata},${i})'>${numberFormatter(rdata[i].tweet_volumes[0].volume, 1)}</td>`;
            topTrends += "</tr>";
        }
        $("#top-10-trends table tbody").html(topTrends);
    }, "json");
});