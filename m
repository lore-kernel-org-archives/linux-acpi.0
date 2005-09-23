From: Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
Subject: [PATCH] acpi: Fix oops in asus_acpi.c on Samsung P30/P35 Laptops
Date: Sat, 24 Sep 2005 01:36:25 +0200
Message-ID: <20050923233625.GF6860@orest.greek0.net>
References: <20050618004506.GE3690@orest.greek0.net> <42C2BA01.2060806@gmx.net> <20050629155015.GB14659@hell.org.pl> <200508191749.18016.mail@hboeck.de> <1124634977.4952.9.camel@nouse.net> <20050921090810.GS22403@orest.greek0.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9sSKoi6Rw660DLir"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050921090810.GS22403-eJYrgmUciHpxYM3rXe3Iuw@public.gmane.org>
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
Cc: Hanno =?iso-8859-1?Q?B=F6ck?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--9sSKoi6Rw660DLir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Samsung P35's INIT returns an integer (instead of a string or a
plain buffer), which caused an oops when the result was treated as
string in asus_hotk_get_info() (since an invalid pointer got
dereferenced).

This patch explicitly checks for ACPI_TYPE_INTEGER and for the
return values possible on the P30/P35.

Signed-off-by: Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
---

 drivers/acpi/asus_acpi.c |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

c51f431351c648519a9b91de3c5e1d636246d7bc
diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -1006,6 +1006,24 @@ static int __init asus_hotk_get_info(voi
 	}
=20
 	model =3D (union acpi_object *)buffer.pointer;
+
+	/* INIT on Samsung's P35 returns an integer, possible return
+	 * values are tested below */
+	if (model->type =3D=3D ACPI_TYPE_INTEGER) {
+		if (model->integer.value =3D=3D -1 ||
+			model->integer.value =3D=3D 0x58 ||
+			model->integer.value =3D=3D 0x38) {
+			hotk->model =3D P30;
+			printk(KERN_NOTICE
+				       "  Samsung P35 detected, supported\n");
+			goto out_known;
+		} else {
+			printk(KERN_WARNING=20
+				"  unknown integer returned by INIT\n");
+			goto out_unknown;
+		}
+	}
+
 	if (model->type =3D=3D ACPI_TYPE_STRING) {
 		printk(KERN_NOTICE "  %s model detected, ",
 		       model->string.pointer);
@@ -1057,9 +1075,7 @@ static int __init asus_hotk_get_info(voi
 		hotk->model =3D L5x;
=20
 	if (hotk->model =3D=3D END_MODEL) {
-		printk("unsupported, trying default values, supply the "
-		       "developers with your DSDT\n");
-		hotk->model =3D M2E;
+		goto out_unknown;
 	} else {
 		printk("supported\n");
 	}
@@ -1088,6 +1104,15 @@ static int __init asus_hotk_get_info(voi
 	acpi_os_free(model);
=20
 	return AE_OK;
+
+out_unknown:
+	printk(KERN_WARNING "  unsupported, trying default values, "
+			"supply the developers with your DSDT\n");
+	hotk->model =3D M2E;
+out_known:
+	hotk->methods =3D &model_conf[hotk->model];
+	acpi_os_free(model);
+	return AE_OK;
 }
=20
 static int __init asus_hotk_check(void)

--9sSKoi6Rw660DLir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDNJF4xsP1RlTwJHsRAkv9AKCdTiqkiR9gWiI5jfaSN+RWUFkszwCgkEoz
8ao8TUfAKNmzRznzUngrpDM=
=7oZY
-----END PGP SIGNATURE-----

--9sSKoi6Rw660DLir--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
