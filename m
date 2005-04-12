From: Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: ACPI errors with 2.6.12-rc1
Date: Tue, 12 Apr 2005 11:27:01 +0200
Message-ID: <1113298021.26323.4.camel@sponge.fungus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-y2OHHaFg8YtIvA0yoz3n"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org


--=-y2OHHaFg8YtIvA0yoz3n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

After upgrading to linux-2.6.12-rc1 I often receive the following error
messages in my system log:

Apr 12 11:22:07 sponge ACPI-0294: *** Error: Looking up [SERN] in namespace=
, AE_ALREADY_EXISTS
Apr 12 11:22:07 sponge ACPI-1138: *** Error: Method execution failed [\_SB_=
.PCI0.LPC_.EC__.GBIF] (Node c14d2940), AE_ALREADY_EXISTS
Apr 12 11:22:07 sponge ACPI-0643: *** Error: Looking up [SERN] in namespace=
, AE_NOT_FOUND
Apr 12 11:22:07 sponge ACPI-1138: *** Error: Method execution failed [\_SB_=
.PCI0.LPC_.EC__.GBIF] (Node c14d2940), AE_NOT_FOUND
Apr 12 11:22:07 sponge ACPI-1138: *** Error: Method execution failed [\_SB_=
.PCI0.LPC_.EC__.BAT0._BIF] (Node c14d16e0), AE_NOT_FOUND

My system is an IBM ThinkPad X31 (2672-XXH). I've never seen these
warnings in the past.

Anybody have a clue to what these messages mean - and why they started
occurring with 2.6.12-rc1?

Sincerely,
Brix
--=20
Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Gentoo Linux

--=-y2OHHaFg8YtIvA0yoz3n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCW5Rlv+Q4flTiePgRAs52AJ91hbfyDEWRzOBAGZe2MNE/W2LmLgCfYznu
FT6RSpowOSDVSeATvJq27WE=
=rqhg
-----END PGP SIGNATURE-----

--=-y2OHHaFg8YtIvA0yoz3n--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
