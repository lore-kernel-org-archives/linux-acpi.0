From: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Subject: Re: Re: [patch 11/12] new sony_acpi driver
Date: Thu, 03 Mar 2005 11:01:23 +0100
Message-ID: <1109844083.4866.25.camel@nouse.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3002E2E026@hdsmsx401.amr.corp.intel.com>
	 <20050303092725.GA3346@crusoe.alcove-fr>
	 <1109842444.4866.16.camel@nouse.net>
	 <20050303094554.GC3346@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E7w2BoRvEqAMXNoI/224"
In-Reply-To: <20050303094554.GC3346-KwDxFO93HejPHUqn3ntIkQ@public.gmane.org>
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


--=-E7w2BoRvEqAMXNoI/224
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2005-03-03 at 10:45 +0100, Stelian Pop wrote:
[...]
>
>But the discussion here is pretty unrelated. We are talking about
>the implementation not interface, and what Len wants is to remove
>the specific {ibm,toshiba,asus} implementations and make generic ones=20
>based on the ACPI stantard.

Ah, OK.  I did not get this before.  Then, we've got a problem.  I mean,
when looking at the different implementations of the drivers it is
obvious that this will  not  work at all.  For example, I'm thinking of
the Toshiba HCI which needs to be polled to get hotkey information...

So, I'd really appreciate to see a comment from Len about his thoughts
which way to go.

>Stelian.

See you,

   -- Timo

..............................................................
Timo H=F6nig <thoenig at nouse dot net>
..................................................:: gpg ::...
Fingerprint: 0998 0ACA A1D2 2612 4D96 DD8B E03F 084B B305 4066

--=-E7w2BoRvEqAMXNoI/224
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCJuBz4D8IS7MFQGYRApyYAJ416equ1TRbiwi58m+yOLLjm2RergCePxKv
Xsjwejp8wNDJx/HtL/G66HM=
=iSQJ
-----END PGP SIGNATURE-----

--=-E7w2BoRvEqAMXNoI/224--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
