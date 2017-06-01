From: Florian Echtler <floe@butterbrot.org>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
Date: Thu, 1 Jun 2017 10:27:34 +0200
Message-ID: <65c88b03-45d7-d67b-2a2c-6c7047a73c80@butterbrot.org>
References: <30380cb3-0f26-8aea-2689-d4886879129c@butterbrot.org>
 <20170526210340.GA5114@wunner.de>
 <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
 <20170530105404.GA29865@wunner.de>
 <64a4829c-3141-6ff6-9369-6ca9ed0facf4@butterbrot.org>
 <20170531092145.ytc2d6shpukxziie@wunner.de>
 <CADnq5_MGWOX47tcvkfjHRxRv_eTbo_kvpVKyTpo8WGNw+xBvPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9pnLC9VgkIp0WwGu3GaU0tvCeiGsTfELC"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:49053 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751577AbdFAI1w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Jun 2017 04:27:52 -0400
In-Reply-To: <CADnq5_MGWOX47tcvkfjHRxRv_eTbo_kvpVKyTpo8WGNw+xBvPA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>, Lukas Wunner <lukas@wunner.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9pnLC9VgkIp0WwGu3GaU0tvCeiGsTfELC
Content-Type: multipart/mixed; boundary="4nJbW0qup87U1xWeOIvtDm2hD8FEfddVX";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: Alex Deucher <alexdeucher@gmail.com>, Lukas Wunner <lukas@wunner.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Message-ID: <65c88b03-45d7-d67b-2a2c-6c7047a73c80@butterbrot.org>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
References: <30380cb3-0f26-8aea-2689-d4886879129c@butterbrot.org>
 <20170526210340.GA5114@wunner.de>
 <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
 <20170530105404.GA29865@wunner.de>
 <64a4829c-3141-6ff6-9369-6ca9ed0facf4@butterbrot.org>
 <20170531092145.ytc2d6shpukxziie@wunner.de>
 <CADnq5_MGWOX47tcvkfjHRxRv_eTbo_kvpVKyTpo8WGNw+xBvPA@mail.gmail.com>
In-Reply-To: <CADnq5_MGWOX47tcvkfjHRxRv_eTbo_kvpVKyTpo8WGNw+xBvPA@mail.gmail.com>

--4nJbW0qup87U1xWeOIvtDm2hD8FEfddVX
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 31.05.2017 14:57, Alex Deucher wrote:
> On Wed, May 31, 2017 at 5:21 AM, Lukas Wunner <lukas@wunner.de> wrote:
>> On Wed, May 31, 2017 at 10:48:37AM +0200, Florian Echtler wrote:
>>
>> Hm, try booting with drm.debug=3D0xf to see if link training for the
>> eDP connector succeeds.  If the link cannot be trained, it would
>> explain that the screen stays black.  Should this indeed be the
>> case, one possible explanation would be that the panel is muxed
>> to the external port on resume and an appropriate command needs to
>> be sent to the SMC to switch the mux to the radeon card.  This could
>> be done in the ->resume_early hook of your APP000C platform driver.
>> The apple-gmux driver contains something similar to power the discrete=

>> GPU down if it was off before suspend (because the BIOS always powers
>> it up on resume).

Here's the (substantial) dmesg output, with drm.debug=3D0xf:
http://floe.butterbrot.org/external/radeon/dmesg_after_suspend

I haven't been able to find any references to link training, though.

>> *shrug*  Unfortunately I'm not familiar at all with radeontool. :-(
>=20
> You can use the radeonreg tool to dump the display registers:
> https://cgit.freedesktop.org/~agd5f/radeontool/
> radeonreg regs dce3
> replace dce3 with whatever dce version your card has.

AFAICT the RV730 indeed has dce3, so I created a register dump before and=
 after
suspend:
http://floe.butterbrot.org/external/radeon/regs_before_suspend.txt
http://floe.butterbrot.org/external/radeon/regs_after_suspend.txt

The diff, however, is quite large, I have no idea which registers to look=
 for.

Best, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--4nJbW0qup87U1xWeOIvtDm2hD8FEfddVX--

--9pnLC9VgkIp0WwGu3GaU0tvCeiGsTfELC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkvz/wACgkQ7CzyshGvathbcwCfV3ks+AlPLSNxBN4cxobGzcmR
rxgAoO/gaEgBYT5rdom/RAVnlG3uDJnN
=MDK9
-----END PGP SIGNATURE-----

--9pnLC9VgkIp0WwGu3GaU0tvCeiGsTfELC--
