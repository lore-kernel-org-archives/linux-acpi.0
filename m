From: Florian Echtler <floe@butterbrot.org>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
Date: Tue, 25 Jul 2017 09:53:57 +0200
Message-ID: <265edc8d-007e-b720-85b9-91733943c0ae@butterbrot.org>
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
 <29cdd744-8fac-557b-bc5f-087e84adcae7@butterbrot.org>
 <fdd1f9fa-f4a5-3b3b-0a0b-8bbff0ef2e5f@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LM3qtKo7At0IXfc08GnearsUSWE4R2D1l"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:46407 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750769AbdGYHyD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Jul 2017 03:54:03 -0400
In-Reply-To: <fdd1f9fa-f4a5-3b3b-0a0b-8bbff0ef2e5f@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Kleiner <mario.kleiner.de@gmail.com>, Lukas Wunner <lukas@wunner.de>
Cc: Alex Deucher <alexdeucher@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LM3qtKo7At0IXfc08GnearsUSWE4R2D1l
Content-Type: multipart/mixed; boundary="coATDHNo8qPfcwhMJk69CBVuVlOsVgUGT";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: Mario Kleiner <mario.kleiner.de@gmail.com>, Lukas Wunner <lukas@wunner.de>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Message-ID: <265edc8d-007e-b720-85b9-91733943c0ae@butterbrot.org>
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
 <29cdd744-8fac-557b-bc5f-087e84adcae7@butterbrot.org>
 <fdd1f9fa-f4a5-3b3b-0a0b-8bbff0ef2e5f@gmail.com>
In-Reply-To: <fdd1f9fa-f4a5-3b3b-0a0b-8bbff0ef2e5f@gmail.com>

--coATDHNo8qPfcwhMJk69CBVuVlOsVgUGT
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 25.07.2017 07:14, Mario Kleiner wrote:
> On 07/24/2017 03:45 PM, Florian Echtler wrote:
>=20
> That's the same here with my patch applied. After a suspend -> resume, =
the
> internal panel stays black, the patch doesn't help for that. Somethig i=
 didn't
> notice btw., apparently i never suspend->resumed it.

OK - I'm guessing if the panel/connector mess gets properly sorted out in=

general, then it will probably also start working after suspend/resume...=


> The internal panel always works during boot, until the radeon kms drive=
r loads
> and modesetting gets initialized, then the panel goes dark.

Weirdly enough, this is now the behaviour I'm getting, too, no matter if =
I use
the patched driver or the original one. So there's definitely some bit of=

persistent state somewhere that got flipped during experimentation, proba=
bly
inside that stupid SMC.

> Without my patch the internal panel stays dark, but plugging in an exte=
rnal
> hdmi/dvi display gets both internal+external to light up.
>=20
> Another way i was able to force the internal panel to stay on without m=
y patch
> and without an external display connected is to use the kernel cmdline =
option
> "video=3DDP-1:2560x1440D" to force the external output on, although not=
hing is
> connected.

None of the video options, either with "DP" or "eDP", made a difference i=
n my
case. The one scenario where I suddenly got the internal panel to turn on=
 was
when I plugged in a DP _source_ (my laptop). Also caused the same DP link=
 train
error messages to appear in dmesg.

> So the same machine model behaves differently with the same patch, and =
worse in
> your case than without it? Maybe different hardware or firmware?
>=20
> Apples website lists two models of late 2009 iMac10,1 and Radeon HD 467=
0, to
> which the patch should apply. One 21.5 inch model without TDM and a 27 =
inch
> model with TDM. Mine is the 27 inch one. I assume yours as well due to =
TDM?
> Attached is the output of dmidecode on mine, not sure what to look for =
for
> differences?

Yes, also 27 inch. I've compared the dmidecode output, only notable diffe=
rences
are data from RAM modules, so it's the same machine and same FW versions.=


> Also attached a dmesg snippet for comparison wrt. SMBIOS version etc.

Nearly everything identical, except my dmesg doesn't show the following l=
ines:

-[    0.000000] efi: EFI v1.10 by Apple
-[    0.000000] efi:  ACPI=3D0xbfeee000  ACPI 2.0=3D0xbfeee014  SMBIOS=3D=
0xbfec4000

I'm booting Linux via rEFIt, so I would have assumed that it's a "regular=
" EFI
boot, but apparently not. What's your boot configuration?

> Lukas idea that some hardware mux gets switched into the wrong position=
 on
> models with TDM sounds pretty appealing to me, but how to test?

I'm using TDM regularly; interestingly enough, this works completely reli=
ably,
even if the panel was dark before. My code is at
https://github.com/floe/smc_util if you want to give it a try, but appare=
ntly
there's more to it than just the two keys (MVMR/MVHR) which I'm currently=
 using.

Maybe you can run smc_dump_linux.sh on your machine (should be safe, only=
 reads
keys) and see if there's some difference between keys depending on what s=
tate
the panel is in?

Best, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--coATDHNo8qPfcwhMJk69CBVuVlOsVgUGT--

--LM3qtKo7At0IXfc08GnearsUSWE4R2D1l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll2+RYACgkQ7CzyshGvatiy4QCeKeuFud/wleJyteOkjK45XnIM
eiUAn1a3ZboYMSzEkp86L91i4Q00gDaB
=NGk+
-----END PGP SIGNATURE-----

--LM3qtKo7At0IXfc08GnearsUSWE4R2D1l--
