From: randy_dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Kernel oops with asus_acpi module
Date: Mon, 6 Jun 2005 13:54:59 -0700
Message-ID: <20050606135459.7ad699ae.rdunlap@xenotime.net>
References: <200506052340.41074.mail@hboeck.de>
	<200506061929.24663.mail@hboeck.de>
	<20050606114531.763eec37.rdunlap@xenotime.net>
	<200506062050.42632.mail@hboeck.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506062050.42632.mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hanno =?ISO-8859-1?B?QvZjaw==?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sziwan-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, julien.lerouge-GANU6spQydw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

(back to mailing lists + asus acpi maintainers)


On Mon, 6 Jun 2005 20:50:42 +0200 Hanno B=F6ck wrote:

| Am Montag, 6. Juni 2005 20:45 schrieben Sie:
| > 2 or 3 things:
| >
| > a.  I can't match that Code line to any code in my
| > compiler asus_acpi.o file.  What version of gcc are you using?
| > Can you send me your asus_acpi.o file?
|=20
| Attached.
| I'm using gcc4 (but that's probably not the reason, because matthias hent=
ges,=20
| who has a debian-system, has the same problem)

Well, gcc4 does have some known issues with the Linux kernel,
although I don't know the specifics of them.

| >
| > b.  That Code line is different from the first one that you posted.
| > That doesn't make much sense to me....
|=20
| Don't know why, but maybe because I recompiled the kernel with=20
| debugging-support?

OK, I see that part.

I'm including a patch for you to try.  Can you apply and test it
and report back on it, please?

---

From: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
linux-2612-rc5-mm2

model->string.pointer was NULL, so printk of it caused an oops.

Handle ASUS ACPI string descriptor with 0 length or NULL pointer
by trying the Samsung P30 support code exception handling.

Signed-off-by: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>

diffstat:=3D
 drivers/acpi/asus_acpi.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

diff -Naurp ./drivers/acpi/asus_acpi.c~asus_models ./drivers/acpi/asus_acpi=
.c
--- ./drivers/acpi/asus_acpi.c~asus_models	2005-03-01 23:37:53.000000000 -0=
800
+++ ./drivers/acpi/asus_acpi.c	2005-06-06 13:51:40.000000000 -0700
@@ -993,6 +993,7 @@ static int __init asus_hotk_get_info(voi
 	/* Samsung P30 has a device with a valid _HID whose INIT does not=20
 	 * return anything. Catch this one and any similar here */
 	if (buffer.pointer =3D=3D NULL) {
+try_p30:
 		if (asus_info && /* Samsung P30 */
 		    strncmp(asus_info->oem_table_id, "ODEM", 4) =3D=3D 0) {
 			hotk->model =3D P30;
@@ -1009,7 +1010,15 @@ static int __init asus_hotk_get_info(voi
 =09
 	model =3D (union acpi_object *) buffer.pointer;
 	if (model->type =3D=3D ACPI_TYPE_STRING) {
-		printk(KERN_NOTICE "  %s model detected, ", model->string.pointer);
+		if (!model->string.length || !model->string.pointer) {
+			printk(KERN_WARNING "  model string length or pointer "
+				"is 0, trying P30 exceptions (%u, %p)\n",
+				model->string.length, model->string.pointer);
+			goto try_p30;
+		}
+		else
+			printk(KERN_NOTICE "  %s model detected, ",
+				model->string.pointer);
 	}
=20
 	hotk->model =3D END_MODEL;


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
