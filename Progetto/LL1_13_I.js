function hoverArea(element, pos){
    var c = element.coords.split(',');
    var width = document.getElementById(element.parentNode.name).offsetWidth;
    var height = document.getElementById(element.parentNode.name).offsetHeight;
    var div = document.getElementById("mapSelector"+pos);
    div.style.left = c[0]+'px';
    div.style.top = c[1]+'px';
    div.style.right = width - c[2]+'px';
    div.style.bottom = height - c[3]+'px'; 
    div.style.color = '#FF000080';
}

function hoverLine(element,pos){
    hoverArea(element,pos);
    spanLine = document.getElementById("line_#"+element.id); 
    spanLine.style.color = '#FF000080';
    spanLine.innerHTML = '<i class="fa fa-angle-double-right"></i>';
}

function hover(element,pos){
    hoverArea(element,pos);
    spanDesc = document.getElementById("desc_#"+element.id);
    spanDesc.style.backgroundColor = '#FF000080';
}

function resetHover(pos){
    var div = document.getElementById("mapSelector"+pos);
    div.style.left = '';
    div.style.top = '';
    div.style.right = '';
    div.style.bottom = '';
    div.style.color = ''; 
}

function nohoverLine(pos,id){
    resetHover(pos);
    spanLine = document.getElementById("line_#"+id);
    spanLine.innerHTML = '';
}

function nohover(pos,id){
    resetHover(pos);
    spanDesc = document.getElementById("desc_#"+id);
    spanDesc.style.backgroundColor = '';
}

function linkTo(id){
    var xml_id = id.split("#");
    hoverLink = document.getElementById(xml_id[1]);
    hoverLink.style.backgroundColor = '#FF000080';
}

function linkToDown(id) {
    var xml_id = id.split("#");
    hoverLink = document.getElementById(xml_id[1]);
    hoverLink.style.backgroundColor = '';
}

function returnCoords(allCoordsImg){
    var coordsImg = [];
    for(var i=0; i<allCoordsImg.length; i++){
        coordsImg[i] = allCoordsImg[i].coords.split(',');
    }
    return coordsImg;
}

function resizeCoords(ratioWidth, coordsImg){
    var coordsResized = [];
    for(var i=0; i<coordsImg.length; i++){
        for(var j=0; j<4; j++){
            coordsImg[i][j] /= ratioWidth;
        }
        coordsResized[i] = coordsImg[i].join(',');
    }
    return coordsResized;
}

function calcRatio(width_prec, width){
    var ratioWidth;
    if(width_prec === undefined){
        ratioWidth = 1632/width;
    } else {
        ratioWidth = width_prec/width;
    }
    return ratioWidth;
}

function replaceCoords(area, coords){
    for(var i=0; i<area.length; i++){
        area[i].setAttribute("coords", coords[i])
    }
}

function resize(){
    var allAreaImg1 = document.getElementsByClassName("LL1.13_I_folio_1fr");
    var allAreaImg2 = document.getElementsByClassName("LL1.13_I_folio_1rv");
    var coordsImg1 = returnCoords(allAreaImg1);
    var coordsImg2 = returnCoords(allAreaImg2);
    var widthImg1 = document.getElementById("map1").width;
    var widthImg2 = document.getElementById("map2").width;
    var ratio1 = calcRatio(widthImg1_prec, widthImg1);
    var ratio2 = calcRatio(widthImg1_prec, widthImg1);
    var newCoordsImg1 = resizeCoords(ratio1, coordsImg1);
    var newCoordsImg2 = resizeCoords(ratio2, coordsImg2);
    replaceCoords(allAreaImg1, newCoordsImg1);
    replaceCoords(allAreaImg2, newCoordsImg2);
    widthImg1_prec = widthImg1;
    widthImg2_prec = widthImg2;
}

var spanLine;
var spanDesc;
var widthImg1_prec = undefined;
var widthImg2_prec = undefined;

window.onload = () => {
    resize();
    window.addEventListener("resize",resize);
}