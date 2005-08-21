From: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Subject: Re: oops with asus_acpi on P30/P35
Date: Sun, 21 Aug 2005 16:36:17 +0200
Message-ID: <1124634977.4952.9.camel@nouse.net>
References: <20050618004506.GE3690@orest.greek0.net>
	 <42C2BA01.2060806@gmx.net> <20050629155015.GB14659@hell.org.pl>
	 <200508191749.18016.mail@hboeck.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-u1DeK9cSEzEeKb5RtEJQ"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200508191749.18016.mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hanno =?ISO-8859-1?Q?B=F6ck?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-u1DeK9cSEzEeKb5RtEJQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2005-08-19 at 17:49 +0200, Hanno B=F6ck wrote:

[...]

> This is still not fixed within 2.6.13_rc6. As 2.6.13 seems to be on the=
 way=20
> and this bug is really grave/makes a piece of hardware unusable, can th=
is be=20
> pushed to the kernel tree as soon as possible?

This patch does fix the Samsung P30 but this fix will also break support
for other systems (like the ASUS W5A), too.  To get the W5A working
again, it needs something like the attached patch.

I assume that other models will stop working, too.

> cu,
>=20
> Hanno

See you,

   Timo

--=-u1DeK9cSEzEeKb5RtEJQ
Content-Disposition: attachment; filename=asus_w5a.patch
Content-Type: text/x-patch; name=asus_w5a.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- acpi_asus.c	2005-08-21 16:33:15.000000000 +0100
+++ acpu_asus.c	2005-08-21 16:33:41.000000000 +0100
@@ -1088,6 +1089,9 @@
 	 * return anything. Catch this one and any similar here */
 	if (model->type == ACPI_TYPE_STRING) {
 		printk(KERN_NOTICE "  %s model detected, ", model->string.pointer);
+	} else if (asus_info && /* Asus W5A needs this. Maybe others? */
+			strncmp(asus_info->oem_table_id, "0AAAA000", 8) == 0) {
+			printk(KERN_NOTICE "Found Asus ACPI without model type?\n");
 	} else {
 		if (asus_info && /* Samsung P30 */
 		    strncmp(asus_info->oem_table_id, "ODEM", 4) == 0) {


--=-u1DeK9cSEzEeKb5RtEJQ--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
