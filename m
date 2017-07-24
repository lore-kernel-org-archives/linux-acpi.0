From: Florian Echtler <floe@butterbrot.org>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
Date: Mon, 24 Jul 2017 15:45:58 +0200
Message-ID: <29cdd744-8fac-557b-bc5f-087e84adcae7@butterbrot.org>
References: <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
 <20170530105404.GA29865@wunner.de>
 <64a4829c-3141-6ff6-9369-6ca9ed0facf4@butterbrot.org>
 <20170531092145.ytc2d6shpukxziie@wunner.de>
 <CADnq5_MGWOX47tcvkfjHRxRv_eTbo_kvpVKyTpo8WGNw+xBvPA@mail.gmail.com>
 <65c88b03-45d7-d67b-2a2c-6c7047a73c80@butterbrot.org>
 <CADnq5_Mvyz1KUw26Emt8_d_XNeQ=MUqx8WF=iCxa6jagCXNCQQ@mail.gmail.com>
 <171a9895-b020-7630-b90c-d166f45e44e3@butterbrot.org>
 <CADnq5_P_H8ZZXnXOoUcxNOFece3BRyzhZh2Z3mkw53eA20KiMQ@mail.gmail.com>
 <c1ed89a5-e6a1-1903-05ee-a9dfcdb2ef61@butterbrot.org>
 <20170717090235.GB3993@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uu9v51A6kphUv3cD9wAgIxpdJHe627Oj9"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:37050 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753605AbdGXNqD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jul 2017 09:46:03 -0400
In-Reply-To: <20170717090235.GB3993@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Alex Deucher <alexdeucher@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Mario Kleiner <mario.kleiner.de@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uu9v51A6kphUv3cD9wAgIxpdJHe627Oj9
Content-Type: multipart/mixed; boundary="QAsjn1wbDbqUNKB3gDEA3gTsKWLP5xRMG";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Mario Kleiner <mario.kleiner.de@gmail.com>
Message-ID: <29cdd744-8fac-557b-bc5f-087e84adcae7@butterbrot.org>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
References: <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
 <20170530105404.GA29865@wunner.de>
 <64a4829c-3141-6ff6-9369-6ca9ed0facf4@butterbrot.org>
 <20170531092145.ytc2d6shpukxziie@wunner.de>
 <CADnq5_MGWOX47tcvkfjHRxRv_eTbo_kvpVKyTpo8WGNw+xBvPA@mail.gmail.com>
 <65c88b03-45d7-d67b-2a2c-6c7047a73c80@butterbrot.org>
 <CADnq5_Mvyz1KUw26Emt8_d_XNeQ=MUqx8WF=iCxa6jagCXNCQQ@mail.gmail.com>
 <171a9895-b020-7630-b90c-d166f45e44e3@butterbrot.org>
 <CADnq5_P_H8ZZXnXOoUcxNOFece3BRyzhZh2Z3mkw53eA20KiMQ@mail.gmail.com>
 <c1ed89a5-e6a1-1903-05ee-a9dfcdb2ef61@butterbrot.org>
 <20170717090235.GB3993@wunner.de>
In-Reply-To: <20170717090235.GB3993@wunner.de>

--QAsjn1wbDbqUNKB3gDEA3gTsKWLP5xRMG
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello Lukas,

On 17.07.2017 11:02, Lukas Wunner wrote:
> On Fri, Jun 02, 2017 at 06:47:07PM +0200, Florian Echtler wrote:
>=20
> Sorry for the delay Florian.  Commit 564d8a2cf3ab by Mario Kleiner (+cc=
)
> landed in Linus' tree last week and is included in 4.13-rc1.  It is
> supposed to fix black screen issues with the iMac10,1 that you're also
> using, though in Mario's case they seem to occur upon boot, rather than=

> on suspend, still might be worth a try:

thanks for the hint. I've applied this patch to the v4.12 tree I'm curren=
tly
running, and it didn't seem to make any difference (i.e. display stays bl=
ack
after suspend).

Without the patch, when I plug in an external display (via MiniDP-to-DVI)=
, then
the internal panel stays black when booting, only the external display wo=
rks.

Actually, the patch then makes things slightly worse in my case: with the=
 patch
applied, not even the external sink works anymore. When I log in remotely=
 and
run "DISPLAY=3D:0.0 xrandr", both DP connections are shown as active, but=
 neither
does actually show an image.

I'd be grateful about a bit of background information here, I'd really li=
ke to
help fix this.

Best, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--QAsjn1wbDbqUNKB3gDEA3gTsKWLP5xRMG--

--uu9v51A6kphUv3cD9wAgIxpdJHe627Oj9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll1+hYACgkQ7CzyshGvatgSbQCghB/5TK7LAtPYFSe8lDJ1k3Vc
kRwAn3b4iN5E1Is7Vaa3aZewhvwbmon6
=gW/0
-----END PGP SIGNATURE-----

--uu9v51A6kphUv3cD9wAgIxpdJHe627Oj9--
