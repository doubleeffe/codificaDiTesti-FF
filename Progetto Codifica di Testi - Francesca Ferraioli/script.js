var name_before = "";

//Evidenzia riga
function gestoreEvidenzia(name){  
	try {
		// togli la classe dalla selezione precedente
		if(name_before!='')
			document.getElementsByName(name_before).item(0).className='';
		// aggiungi la classe alla selezione attuale
		document.getElementsByName(name).item(0).className='dot';
    } catch(e) {
        alert("gestoreEvidenzia()"+e);   
    }
	// salva nel name_before
	name_before = name;
}
