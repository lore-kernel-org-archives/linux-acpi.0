From: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Subject: Re: Re: [patch 11/12] new sony_acpi driver
Date: Thu, 03 Mar 2005 10:34:04 +0100
Message-ID: <1109842444.4866.16.camel@nouse.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3002E2E026@hdsmsx401.amr.corp.intel.com>
	 <20050303092725.GA3346@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-e1VljC6/KftomvbjYoQh"
In-Reply-To: <20050303092725.GA3346-KwDxFO93HejPHUqn3ntIkQ@public.gmane.org>
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
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-e1VljC6/KftomvbjYoQh
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2005-03-03 at 10:27 +0100, Stelian Pop wrote:
>Did you look at the code in those drivers ? There is no way you can
>delete them because each of them is very specific in the functionalities
>it offers and the way to achieve it.
>
>Sure, for basic stuff like the brightness you can hope to have a=20
>common code (like video.c today). It may even work on future laptops.
>But it won't work on older (todays) laptops (I'm not sure about the
>other brands, but it won't work on Sony Vaios). And even if when it
>works it won't do everything because vendors will always implement
>extensions.

Since the function implementations vary but their purpose is the same it
would be possible by creating generic wrapper functions (hotkey
implementation, trigger common hardware functions like fan,
bluetooth...).  I'm not sure which way would be the best to cover laptop
specific functions which are not covered by the generic wrapper
functions.

[...]
>
>Stelian.

See you,

  -- Timo

..............................................................
Timo H=F6nig <thoenig at nouse dot net>
..................................................:: gpg ::...
Fingerprint: 0998 0ACA A1D2 2612 4D96 DD8B E03F 084B B305 4066

--=-e1VljC6/KftomvbjYoQh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCJtoL4D8IS7MFQGYRAg81AKCBwFNz7t4hPTO5BYcnVgp0tPDqkgCeM3J7
W+5xrcGfhItx/r+5cJBnDs8=
=mzFb
-----END PGP SIGNATURE-----

--=-e1VljC6/KftomvbjYoQh--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
