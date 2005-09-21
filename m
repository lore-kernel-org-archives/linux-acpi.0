From: Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: oops with asus_acpi on P30/P35
Date: Wed, 21 Sep 2005 16:39:27 +0200
Message-ID: <20050921143927.GT22403@orest.greek0.net>
References: <20050618004506.GE3690@orest.greek0.net> <1124634977.4952.9.camel@nouse.net> <20050921090810.GS22403@orest.greek0.net> <200509211347.13322.mail@hboeck.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BouVgDkIlpb7X6Bk"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200509211347.13322.mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hanno =?iso-8859-1?Q?B=F6ck?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--BouVgDkIlpb7X6Bk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2005 at 01:47:10PM +0200, Hanno B=F6ck wrote:
> Am Wednesday, 21. September 2005 11:08 schrieb Christian Aichinger:
> > Since the relevant part hasn't changed between P30 -> P35's DSDT, I
> > assume that there has been some change in the Linux ACPI code, that
> > causes integer returns now instead of no returns. This means we
> > could get rid of the P30 code in the (!buffer.pointer) path. I don't
> > have a P30 around to test this though :-/
>=20
> I have a P30 around to test and I'd gladly help, but your patch doesn't a=
pply=20
> to the current 2.6.14-rc1 and -git5 kernel.
> Also note that afaik asus_acpi-cvs and kernel aren't in sync at the momen=
t.

I think the conflict should be only a trivial whitespace thing
(according to git-whatchanged). The patch should apply fine to
2.6.14-rc2 (that had it's release mail on LKML on 2005-09-19, but
still isn't on kernel.org) or any recent git checkout.

I've attached a patch that should apply to -rc1. What would be
interesting is if dmesg shows "Samsung P35 detected", or "Samsung
P30 detected". If it indeed shows the former (i.e. the code path my
patch adds), we could probably really get rid of the old cruft.

Cheers,
Christian Aichinger

---
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

--BouVgDkIlpb7X6Bk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMXCfxsP1RlTwJHsRAkAzAJ9jNn7pINmBsm1hWkSoBnrK9XB5/QCglHdL
CqLHZy5zYUenf4d2IvoZ708=
=zD7N
-----END PGP SIGNATURE-----

--BouVgDkIlpb7X6Bk--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
