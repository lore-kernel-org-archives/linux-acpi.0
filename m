From: Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 22:28:52 +0100
Message-ID: <1108502932.29172.5.camel@sponge.fungus>
References: <20050214211105.GA12808@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D/qzgXnlZmrfEGwBYxEt"
In-Reply-To: <20050214211105.GA12808-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-D/qzgXnlZmrfEGwBYxEt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2005-02-14 at 22:11 +0100, Pavel Machek wrote:
> Stefan provided me initial list of machines where S3 works (including
> video). If you have machine that is not on the list, please send me a
> diff. If you have eMachines... I'd like you to try playing with
> vbetool (it worked for me), and if it works for you supplying right
> model numbers.

I have S3 working with 2.6.11-rc4 here:

Model                           hack (or "how to do it")
---------------------------------------------------------------------------=
---
IBM TP X31 / Type 2672-XXH      LCD backlight must be turned off=20
                                manually using radeontool [1]

Sincerely,
Brix

[1]: http://fdd.com/software/radeon/
--=20
Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Gentoo Linux

--=-D/qzgXnlZmrfEGwBYxEt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCEmmUv+Q4flTiePgRAsLfAJ4gpmbP+onTyzPrmxe8lHUxSGStcwCeOcH3
WLUGItS94rAX+dyP/+D/jPI=
=HCtK
-----END PGP SIGNATURE-----

--=-D/qzgXnlZmrfEGwBYxEt--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
