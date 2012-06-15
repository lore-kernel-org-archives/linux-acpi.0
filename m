From: Karol Babioch <karol@babioch.de>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with
 the sony-platform module]
Date: Fri, 15 Jun 2012 14:08:07 +0200
Message-ID: <4FDB25A7.5080809@babioch.de>
References: <4FDA2051.3050108@babioch.de> <20120614203914.GA2645@kamineko.org> <4FDAE7FE.5030706@babioch.de> <20120615113637.GA5904@kamineko.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig79E529D0F15EFEBC7B45E8CD"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20120615113637.GA5904@kamineko.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig79E529D0F15EFEBC7B45E8CD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Am 15.06.2012 13:36, schrieb Mattia Dongili:
> you are running a 3.3 kernel with the latest sony-laptop patches, right=
?
Yeah, right. The 3.4.x series doesn't work for me at all as I get a
black screen during boot. Will have to look into it. Probably has
nothing to do with the sony_laptop module, however.

Basically I've just applied your patches from 3.5-rc2 to the 3.3.8
kernel. As only sony_laptop.c is modified, I thought it would be fine.

Am 15.06.2012 13:36, schrieb Mattia Dongili:
> could you please test it?
Sure, will let you know. Probably will take some time to compile, though.=


Best regards,
Karol Babioch




--------------enig79E529D0F15EFEBC7B45E8CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJP2yWrAAoJEHSaZc1HnzIVPcEP/2N/ODPD7SUW4Hwwuqbgcn1K
0xyGS8iXv3+jWjMP6tnx4KrmsMIXUt8hDdXL6n2iOTF0dxF1Ff+5rptyYKxu4t89
9k79Zqj7kzBwZCDJQnC09agq3XgSWIe4dXPSQIIkPAORn9ZIKgoaRpNoUh/bdhAo
BMZy5WEOeyLkkXICX7sACo94fLqeMivgcKSgGuB57LiyPtpiVhbeYHGdRHOFwPRx
C7sxRcSZFRj63jNyrOlP7LOCQSztCNomQTkvnOOXYEf+NE2hGdCvr21l1C4LxYdn
7p9eAJa+RXa7xV6UZkabYANCJmOmzbaSHi8zTJzN+gpELXfc+7jDMF9fbFKS8Hxy
/W3WGFsIqlDFlFN+GETsmdokIgWCBG/t6ZPZ/QSVPO6i2SKFzHbIKi1cNOmRdszE
o96XSeqewiZ+ciIWN/o/XokRxrTiPZ2E71l07keu73TvVkN4yre1xDubIg8sT6iJ
RQlKS0teN3tR3Sk2fgoQ0cseNjlpxRGhVpyltrjo9YfTA0aYM7ZXhT7iUvU1bBvq
JAQrQaJ12O8oynF27stnJdl/eVvsFvrljEqsRqIrYIoHwcxQNVMxk4DiqA3z8ML6
0Ue15S5AiupE8qmJWezT06OfLUVFP+cuwbtjS0A14ms0NC/OFTQd7ou5M9SEQg5e
6z5V6kyViI7eMsZq5ecd
=qQkt
-----END PGP SIGNATURE-----

--------------enig79E529D0F15EFEBC7B45E8CD--
