From: Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: oops with asus_acpi on P30/P35
Date: Wed, 21 Sep 2005 11:08:10 +0200
Message-ID: <20050921090810.GS22403@orest.greek0.net>
References: <20050618004506.GE3690@orest.greek0.net> <42C2BA01.2060806@gmx.net> <20050629155015.GB14659@hell.org.pl> <200508191749.18016.mail@hboeck.de> <1124634977.4952.9.camel@nouse.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G+DT6X5ssgZ56VG3"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1124634977.4952.9.camel-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
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
Cc: Hanno =?iso-8859-1?Q?B=F6ck?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--G+DT6X5ssgZ56VG3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 21, 2005 at 04:36:17PM +0200, Timo Hoenig wrote:
> Hi,
>=20
> On Fri, 2005-08-19 at 17:49 +0200, Hanno B=F6ck wrote:
>=20
> [...]
>=20
> > This is still not fixed within 2.6.13_rc6. As 2.6.13 seems to be on the=
 way=20
> > and this bug is really grave/makes a piece of hardware unusable, can th=
is be=20
> > pushed to the kernel tree as soon as possible?
>=20
> This patch does fix the Samsung P30 but this fix will also break support
> for other systems (like the ASUS W5A), too.  To get the W5A working
> again, it needs something like the attached patch.
>=20
> I assume that other models will stop working, too.

OK, it's getting a little frustrating that this still isn't fixed.
I've now written a patch that tests for ACPI_TYPE_INTEGER, and it
tests for possible return values from P35's INIT.

Since the relevant part hasn't changed between P30 -> P35's DSDT, I
assume that there has been some change in the Linux ACPI code, that
causes integer returns now instead of no returns. This means we
could get rid of the P30 code in the (!buffer.pointer) path. I don't
have a P30 around to test this though :-/

I got the -1/0x58/0x38 values from my DSDT:
INIT there calls WLED, which calls \_SB.PCI0.LPCB.EC0.STC5, last
call with arg 0x58 or 0x38. That function then returns with either
Ones (which I gathered is ~0, i.e. -1) or with Arg0. That's the last
return that happens within the INIT call, so I thought that might be
the result of the call as a whole.

That fits nicely, since 0x58 is really returned on my laptop.

If this fix still breaks other laptops I'd really be puzzled, since
currently the value is dereferenced later when doing the string
comparisons. So the patch at least shouldn't break it more than it
already is ;)

I can resubmit my patch with a proper changelog entry and
Signed-off-by line if it should be merged.

Cheers,
Christian Aichinger

---
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

--G+DT6X5ssgZ56VG3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMSL6xsP1RlTwJHsRAmsjAKCdyHPA8niROgCsgazd4bWh/xM6QACfRaJY
LXiZ8pClYIPO9Ton2ROprX4=
=zLy5
-----END PGP SIGNATURE-----

--G+DT6X5ssgZ56VG3--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
