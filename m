From: "vincent.legarrec" <vincent.legarrec-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
Subject: RE: Impossible to compile iasl
Date: Fri, 26 Nov 2004 16:07:15 +0100
Message-ID: <20041126150639.053DE1C00CFE@mwinf0108.wanadoo.fr>
References: <6EDC9204B3704C4C8522539D5C1185E568C7D3@mssmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6EDC9204B3704C4C8522539D5C1185E568C7D3-g/v8ENnfjb4gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I've already changed flex to flex-old and install bison and bison-1.35 =
but
the problem exists enough.=20
Since, I reboot the computer and no change.

May you give me another help?

Regards,
Vincent

-----Message d'origine-----
De=A0: Starikovskiy, Alexey Y [mailto:alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]=20
Envoy=E9=A0: vendredi 26 novembre 2004 14:04
=C0=A0: vincent.legarrec
Objet=A0: RE: [ACPI] Impossible to compile iasl

This is the problem, which is fixed by changing flex to flex-old, I've
already mentioned that.

Regards,
Alex.

>-----Original Message-----
>From: vincent.legarrec [mailto:vincent.legarrec-39ZsbGIQGT5GWvitb5QawA@public.gmane.org]
>Sent: Friday, November 26, 2004 4:03 PM
>To: Starikovskiy, Alexey Y
>Subject: RE: [ACPI] Impossible to compile iasl
>
>Thanks a lot for all replies, one problem is solve but now I have the
>message :
>
>aslcompiler.l:846: error: `yytext_ptr' undeclared (first use in this
>function)
>aslcompiler.l:846: error: (Each undeclared identifier is reported only =
once
>aslcompiler.l:846: error: for each function it appears in.)
>make: *** [aslcompilerlex.o] Erreur 1
>
>Regards,
>
>Vincent
>
>-----Message d'origine-----
>De=A0: Starikovskiy, Alexey Y [mailto:alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
>Envoy=E9=A0: vendredi 26 novembre 2004 12:16
>=C0=A0: Arjen Verweij
>Cc=A0: vincent.legarrec; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Objet=A0: RE: [ACPI] Impossible to compile iasl
>
>Thanks, that is enough :)
>
>Edit aslcompiler.y and put semicolon ';' before the closing curly =
braket
>'}'
>
>Sorry for inconvenience,
>	Alex.
>






-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
