From: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Subject: Re: Re: [patch 11/12] new sony_acpi driver
Date: Thu, 03 Mar 2005 11:06:11 +0100
Message-ID: <1109844371.4866.31.camel@nouse.net>
References: <200502230953.j1N9rPLp020723@shell0.pdx.osdl.net>
	 <1109790760.2097.587.camel@d845pe>
	 <20050302205324.GA5486@deep-space-9.dsnet>
	 <1109839245.4866.10.camel@nouse.net>
	 <20050303093949.GB3346@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UGIn5hYhD7wgMFERsdwX"
In-Reply-To: <20050303093949.GB3346-KwDxFO93HejPHUqn3ntIkQ@public.gmane.org>
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


--=-UGIn5hYhD7wgMFERsdwX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2005-03-03 at 10:39 +0100, Stelian Pop wrote:
[...]
>Maybe the problem here is that the ACPI based drivers should not
>be at all in the ACPI tree.
>
>drivers/acpi contain today both the ACPI layer and the ACPI drivers.
>Maybe a split up like the networking code would be saner: $KDIR/acpi
>for the layer and $KDIR/drivers/acpi for the drivers using the acpi
>API to implements specific drivers.

That sounds good to me.  If this is the way to go, I'd like to see a
discussion with the developers of all already available drivers.

>Stelian.

See you,

   -- Timo

..............................................................
Timo H=F6nig <thoenig at nouse dot net>
..................................................:: gpg ::...
Fingerprint: 0998 0ACA A1D2 2612 4D96 DD8B E03F 084B B305 4066

--=-UGIn5hYhD7wgMFERsdwX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCJuGT4D8IS7MFQGYRArddAJwN3b2XqjSxK9pgqXcLbfpJEloVhgCeJP6x
3INQvxM7YyXumQA6dTPSUF4=
=0NS1
-----END PGP SIGNATURE-----

--=-UGIn5hYhD7wgMFERsdwX--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
