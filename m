From: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Subject: Re: clear/enable power button on resume
Date: Sun, 07 Mar 2004 21:02:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078689765.541.20.camel@sunshine>
References: <1078685555.541.9.camel@sunshine>  <404B7A1B.80006@pca.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-x5xWBHfOpcuItE0xtDhZ"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <404B7A1B.80006-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-x5xWBHfOpcuItE0xtDhZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-03-07 at 20:38, Luca Capello wrote:
> this is a known problem at least for resuming from S1, please refers to t=
he
> thread called 'ASUS M3N and sleep states' started 20031227 by me or the d=
irect
> link to the relevant post here:
> http://sourceforge.net/mailarchive/forum.php?thread_id=3D3676335&forum_id=
=3D6102

Since S1 is broken for me, I can not verify that.

> BTW, my simple workaround for S1 is using this trick on the ACPI power bu=
tton
> script:

Thanks. But I don't use the power event anyway. As long as acpi works I
am happy with suspend / resume. rm -rf /etc/acpi/events/powerbtn did it
for me.

Isn't the acpi spec telling whether the pressing of the power button
after suspending has to be reported to the OS?

  Timo

--=-x5xWBHfOpcuItE0xtDhZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAS3/l4D8IS7MFQGYRAtW7AKCAoAdGz+BdDXB3KozdfNpZcRhA4gCfW0Rg
nsCEWK1OpF9h9k22O4VltHw=
=B7vk
-----END PGP SIGNATURE-----

--=-x5xWBHfOpcuItE0xtDhZ--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
