From: Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>
Subject: Re: [2.5.69] S3 does not come back / Sony Vaio C1MHP
Date: Tue, 27 May 2003 15:15:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030527131553.GA701@paradigm.rfc822.org>
References: <20030527101501.GB1247@paradigm.rfc822.org> <20030527131315.GS346@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030527131315.GS346-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2003 at 03:13:15PM +0200, Ducrot Bruno wrote:
> > Hi,
> > S3 would be the reason to switch to 2.5 - bad that it does not work for
> > me ;)=20
> >=20
> > Sony Vaio C1MHP=20
> > Transmeta TM5800
> >=20
> > echo 3 >/proc/acpi/sleep
> >=20
> > goes to sleep - The power led turns blinking red - good sign - after
> > pressing the powerbutton the machine powers up (Powerled turns green and
> > batterie led turns orange) but nothing happens. Backlight does not turn=
=20
> > on nor does the disk do anything. From looking at the screen in bright
> > light it does not write anything to it.
> >=20
> > I need to disconnect the battery to get to a defined state again. The
> > power-button does nothing and even then the first power-on does
> > nothing - need to powercyle once after battery disconnect.
>=20
> Could you try without frame buffer?
>=20

Its on pure VGA 80x25 the radeonfb does not get initialized - another
bug i am chasing.

Flo
--=20
Florian Lohoff                  flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org             +49-5201-669912
                        Heisenberg may have been here.

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+02UJUaz2rXW+gJcRAvFzAKDlqtKzDJLdvZJbofpE6tTDDu37ggCfQyNP
MhBPT0/FU5PuyAFjpjhSL24=
=L6ar
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
