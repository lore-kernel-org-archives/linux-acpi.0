From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Re: Kernel oops with asus_acpi module
Date: Tue, 7 Jun 2005 00:21:51 +0200
Message-ID: <20050606222151.GB65@hell.org.pl>
References: <200506052340.41074.mail@hboeck.de> <20050606135459.7ad699ae.rdunlap@xenotime.net> <20050606213248.GA22238@hell.org.pl> <200506062347.10582.mail@hboeck.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200506062347.10582.mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hanno =?iso-8859-2?Q?B=F6ck?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Cc: randy_dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, julien.lerouge-GANU6spQydw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Hanno B=F6ck:
> Am Montag, 6. Juni 2005 23:32 schrieb Karol Kozimor:
> > May I see the DSDT? The Samsung P30 INIT method referenced in
> > asus_hotk_get_info() is not supposed to return anything, not even an =
empty
> > string. I believe the new ACPICA implicit return might be interfering=
.
> > Here's the relevant part of what I based the code on:

Thanks. This might also help:

--- a/drivers/acpi/asus_acpi.c	2005-04-26 00:38:20.000000000 +0200
+++ b/drivers/acpi/asus_acpi.c	2005-06-07 00:18:17.000000000 +0200
@@ -992,7 +992,7 @@
=20
 	/* Samsung P30 has a device with a valid _HID whose INIT does not=20
 	 * return anything. Catch this one and any similar here */
-	if (buffer.pointer =3D=3D NULL) {
+	if (buffer.pointer =3D=3D NULL || buffer.length =3D=3D 0) {
 		if (asus_info && /* Samsung P30 */
 		    strncmp(asus_info->oem_table_id, "ODEM", 4) =3D=3D 0) {
 			hotk->model =3D P30;

But I'd like to get the full oops with the matching asus_acpi.o file also
(might be off the list).

Best regards,

--=20
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you sho=
tput
a projector? How fast can you ride your desk chair down the office luge t=
rack?
If you want to score the big prize, get to know the little guy. =20
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=3D20
