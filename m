From: Kevin Kress <kkress-SERwydS1y29eoWH0uzbU5w@public.gmane.org>
Subject: Re: Dell DSDT patch request
Date: 06 Mar 2003 16:41:07 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1046997667.836.8.camel@quark>
References: <1046980416.915.11.camel@quark>
	 <20030306213936.GB5185@homerelay.wiesner-net.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kjec8taskVThXyhV1+7u"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030306213936.GB5185-aCYJ90g6FbN3mO1V46hDx7oZL2q1Rlic@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Markus Wiesner <list-acpi-9/ybXWNEfnWFBUTzTaTVRY/15xujVBPPG9Ur7JDdleE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-kjec8taskVThXyhV1+7u
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-03-06 at 13:39, Markus Wiesner wrote:
> Kevin Kress schrieb:
> > I saw a message in the archives from mid Jan 03 about a fixed DSDT for =
a
> > Dell notebook.  It mentioned that the patch worked for both a 82k and
> > another C class notebook.  I am assuming that said DSDT is the one
> > linked from the Wiki for fixed DSDTs.  Unfortunately that link is dead.=
=20
>=20
> I just added links to my patched version for the i8200.
> See http://acpi.sourceforge.net/wiki/index.php/FixedDsdts
>=20
> (hint: if someone else wants to add links containing a "~" to that page,
> encode it as "%7E" :-) )
>=20
> Markus Wiesner

Thanks a lot!  I was able to patch my i81k A14 DSDT with it, looks like
they used the same buggy code all over the place.  I will post my i81k
a14 DSDT as soon as I can verify it works.

I am having trouble getting it to work in the latest patch (2.4.21-pre4
acpi-20030228).  It looks like the Wiki page on installing a custom DSDT
is out of date.  osl.c has some new override functionality now, but I
can't seem to find out where to hook my DSDT in.

Could someone please update that Wiki page to reflect the new code
structure.

Thanks,

--Kevin Kress

--=-kjec8taskVThXyhV1+7u
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+Z+qjaosyXJKUkDIRAriaAJ9cIE/uZrPT+vSIwa4/SIklr0o39ACeMEoN
pfjT86rTOBJnppNKe6KWNJE=
=ohsc
-----END PGP SIGNATURE-----

--=-kjec8taskVThXyhV1+7u--



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
