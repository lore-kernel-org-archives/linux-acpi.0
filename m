From: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Subject: Re: Re: [patch 11/12] new sony_acpi driver
Date: Thu, 03 Mar 2005 09:40:45 +0100
Message-ID: <1109839245.4866.10.camel@nouse.net>
References: <200502230953.j1N9rPLp020723@shell0.pdx.osdl.net>
	 <1109790760.2097.587.camel@d845pe>
	 <20050302205324.GA5486@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iSlyqrE7ur2oTezD+6RH"
In-Reply-To: <20050302205324.GA5486-/EcPb+iqZQprbWk4mQFQhaxOck334EZe@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-iSlyqrE7ur2oTezD+6RH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-03-02 at 21:53 +0100, Stelian Pop wrote:
[...]
>
>I have no problem keeping it out of the tree, it has been this was
>for quite a long time now. Anyway the distro maintainers are starting
>to put it into their kernels so it won't be a problem for endusers
>any longer. BTW, it was those distro maintainers who asked me to
>resubmit the driver lately...
>
I guess you're talking about me.  I did not contact you being a distro
maintainer.  As developer, my intention was -- and still is -- that we
really should get as many laptop specific functions into mainline as
possible.  I care about happy users.

It's a shame that there are actually drivers out there but users simply
do not benefit from them because they are not merged with mainline.

Anyway, as Len proposed, a generic solution is definitely the best
solution.  Let's get this work done.

>But still, I don't see why there is no place for a sony acpi somewhere
>where there are already drivers for ibm, toshiba and asus laptops.

They will disappear once the generic solution is implemented.

[...]
>
>Stelian.

See you,

  -- Timo

..............................................................
Timo H=F6nig <thoenig at nouse dot net>
..................................................:: gpg ::...
Fingerprint: 0998 0ACA A1D2 2612 4D96 DD8B E03F 084B B305 4066

--=-iSlyqrE7ur2oTezD+6RH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCJs2N4D8IS7MFQGYRAmenAJ93e5ONkgD/EkgA4RpgcW7wKTYHtQCghDyj
OsUG+ATQ1BA0lcsbbQpInqY=
=UzhC
-----END PGP SIGNATURE-----

--=-iSlyqrE7ur2oTezD+6RH--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
