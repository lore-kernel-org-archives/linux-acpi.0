From: Kevin Kress <kkress-SERwydS1y29eoWH0uzbU5w@public.gmane.org>
Subject: Re: Dell DSDT patch request
Date: 10 Mar 2003 09:34:19 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1047317566.843.10.camel@quark>
References: <1046980416.915.11.camel@quark>
	 <20030306213936.GB5185@homerelay.wiesner-net.de>
	 <1046997667.836.8.camel@quark>  <3E6AA120.406@sympatico.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Yus1jUS59BKpMp5PxToP"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E6AA120.406-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Tippett <matthew.tippett-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-Yus1jUS59BKpMp5PxToP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Thanks for the help.

After some hacking on the code I found the following applied to
tbgetall.c did the trick:

first I generated acpi_driver.h with iasl -tc dsdt-i8100-a14-fixed.hex
and dumped this in drivers/acpi.tables/acpi_dsdt.h

then in tbgetall.c just above the function "acpi_tb_get_required_tables"
I added a #include of "acpi_dsdt.h"

Then on line 295 or so I did the following:

address.pointer_type  =3D ACPI_LOGICAL_POINTER | ACPI_LOGICAL_ADDRESSING;

//address.pointer.value =3D acpi_gbl_FADT->Xdsdt;
address.pointer.value =3D AmlCode;

where AmlCode is the variable name that was generated in acpi_dsdt.h

a quick recompile and reboot proved that the battery monitor and temp
monitor work just fine when actually reading from the correct AML
buffers.

So now I have mostly tested the DSDT and am confident that it will not
melt my system.... I should upload it to the Wiki.  Is there a procedure
for that or should I just go ahead and add it?

--Kevin

On Sat, 2003-03-08 at 18:04, Matthew Tippett wrote:
> Kevin,
>=20
> I have applied the dsdt and followed the=20
> http://www.cpqlinux.com/acpi-howto.html instructions.  It looks like the=20
> recent updates have moved the structure name has been moved from a=20
> structure tag (if my C terminology is correct), so you must replace=20
> 'acpi_table_header' with 'struct  acpi_table_header' and it will compile=20
> cleanly.
>=20
> Markus,
>=20
> It works great, Thermal Zone and Battery works fine.  There seems to be=20
> a *MAJOR* performance issues reading battery status.
>=20
> Regards,
>=20
> Matthew
>=20
> Kevin Kress wrote:
> > On Thu, 2003-03-06 at 13:39, Markus Wiesner wrote:
> >=20
> >>Kevin Kress schrieb:
> >>
> >>>I saw a message in the archives from mid Jan 03 about a fixed DSDT for=
 a
> >>>Dell notebook.  It mentioned that the patch worked for both a 82k and
> >>>another C class notebook.  I am assuming that said DSDT is the one
> >>>linked from the Wiki for fixed DSDTs.  Unfortunately that link is dead=
.=20
> >>
> >>I just added links to my patched version for the i8200.
> >>See http://acpi.sourceforge.net/wiki/index.php/FixedDsdts
> >>
> >>(hint: if someone else wants to add links containing a "~" to that page=
,
> >>encode it as "%7E" :-) )
> >>
> >>Markus Wiesner
> >=20
> >=20
> > Thanks a lot!  I was able to patch my i81k A14 DSDT with it, looks like
> > they used the same buggy code all over the place.  I will post my i81k
> > a14 DSDT as soon as I can verify it works.
> >=20
> > I am having trouble getting it to work in the latest patch (2.4.21-pre4
> > acpi-20030228).  It looks like the Wiki page on installing a custom DSD=
T
> > is out of date.  osl.c has some new override functionality now, but I
> > can't seem to find out where to hook my DSDT in.
> >=20
> > Could someone please update that Wiki page to reflect the new code
> > structure.
> >=20
> > Thanks,
> >=20
> > --Kevin Kress
--=20
Kevin Kress
kkress-n0UI4aU6OCcAvxtiuMwx3w@public.gmane.org

GnuPG Key ID: 92949032
Fingerprint : B7F9 2B08 6FC8 35CA 5B64  BD34 6A8B 325C 9294 9032

Direct access: http://www.myslo.com/~kkress/kkress-n0UI4aU6OCclr2RyoT947g@public.gmane.org

Via Keyserver: http://www.keyserver.net/en/findkey.html
(search for "Kevin Kress" or "0x92949032")

Get GnuPG at http://www.gnupg.org or PGP at http://www.pgpi.org


--=-Yus1jUS59BKpMp5PxToP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+bMw+aosyXJKUkDIRAtVPAKDAd2jC/XsHSEVwac/xrEJnkro7OQCdGTJu
QRo+AFtMm/9mr93qafDRwFc=
=Eqta
-----END PGP SIGNATURE-----

--=-Yus1jUS59BKpMp5PxToP--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
