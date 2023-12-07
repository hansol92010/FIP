 <c:choose>
   <c:when test="${product.brandCode eq 'nk'}">
   	<p class="detail_brand">NIKE</p>
   </c:when>
   <c:when test="${product.brandCode eq 'nb'}">
   	<p class="detail_brand">New Balance</p>
   </c:when>
   <c:when test="${product.brandCode eq 'mk'}">
   <p class="detail_brand">Matin Kim</p>
   </c:when>
   <c:when test="${product.brandCode eq 'pl'}">
   <p class="detail_brand">POLO</p>
   </c:when>
   <c:when test="${product.brandCode eq 'th'}">
   <p class="detail_brand">TOMMY HILFIGER</p>
   </c:when>
   <c:when test="${product.brandCode eq 'dn'}">
   <p class="detail_brand">thisisneverthat</p>
   </c:when>
   <c:when test="${product.brandCode eq 'dm'}">
   <p class="detail_brand">Dr. Martens</p>
   </c:when>
   <c:when test="${product.brandCode eq 'ae'}">
   <p class="detail_brand">ADERERROR</p>
   </c:when>
   <c:when test="${product.brandCode eq 'nf'}">
   <p class="detail_brand">The North Face</p>
   </c:when>
 </c:choose>