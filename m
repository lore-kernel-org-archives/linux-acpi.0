From: Florian Echtler <floe@butterbrot.org>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
Date: Wed, 31 May 2017 10:48:37 +0200
Message-ID: <64a4829c-3141-6ff6-9369-6ca9ed0facf4@butterbrot.org>
References: <30380cb3-0f26-8aea-2689-d4886879129c@butterbrot.org>
 <20170526210340.GA5114@wunner.de>
 <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
 <20170530105404.GA29865@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DEk3OnxIxhROUmUIe23JTPq06d8MfX57Q"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:54554 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdEaIsk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 04:48:40 -0400
In-Reply-To: <20170530105404.GA29865@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DEk3OnxIxhROUmUIe23JTPq06d8MfX57Q
Content-Type: multipart/mixed; boundary="WVwu0j8hOdktEiMDk9GvGoF4A3Jib953h";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Message-ID: <64a4829c-3141-6ff6-9369-6ca9ed0facf4@butterbrot.org>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
References: <30380cb3-0f26-8aea-2689-d4886879129c@butterbrot.org>
 <20170526210340.GA5114@wunner.de>
 <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
 <20170530105404.GA29865@wunner.de>
In-Reply-To: <20170530105404.GA29865@wunner.de>

--WVwu0j8hOdktEiMDk9GvGoF4A3Jib953h
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 30.05.2017 12:54, Lukas Wunner wrote:
> On Tue, May 30, 2017 at 11:34:17AM +0200, Florian Echtler wrote:
>> On 26.05.2017 23:03, Lukas Wunner wrote:
>>> On Fri, May 26, 2017 at 02:13:29PM +0200, Florian Echtler wrote:
>>>> I'm running Ubuntu 16.04.2 on a 27" unibody iMac 10,1 from 2009. How=
ever, even
>>>> with the most recent HWE stack (kernel 4.8), the display stays black=
 after
>>>> suspend. I can ssh into the machine, so wakeup is OK, but the displa=
y is
>>>> entirely black (backlight stays off).
>=20
> So, just to confirm, if you never plug in an external DP source and the=
 iMac
> comes out of sleep, the display stays black?

Correct, verified this just now.

> If you log in via ssh and look at dmesg, was radeon able to train the D=
P
> link again?  No error messages, nothing?

Here are the relevant dmesg lines after wakeup:

[  157.622950] [drm] enabling PCIE gen 2 link speeds, disable with
radeon.pcie_gen2=3D0
[  157.626077] [drm] PCIE GART of 1024M enabled (table at 0x000000000014C=
000).
[  157.626094] radeon 0000:02:00.0: WB enabled
[  157.626097] radeon 0000:02:00.0: fence driver on ring 0 use gpu addr
0x0000000010000c00 and cpu addr 0xffffa1242dfd6c00
[  157.626098] radeon 0000:02:00.0: fence driver on ring 3 use gpu addr
0x0000000010000c0c and cpu addr 0xffffa1242dfd6c0c
[  157.626315] radeon 0000:02:00.0: fence driver on ring 5 use gpu addr
0x000000000005c598 and cpu addr 0xffffbc3081c1c598
[  157.672183] [drm] ring test on 0 succeeded in 1 usecs
[  157.672187] [drm] ring test on 3 succeeded in 2 usecs
[  157.847098] [drm] ring test on 5 succeeded in 1 usecs
[  157.847102] [drm] UVD initialized successfully.
[  157.847121] [drm] ib test on ring 0 succeeded in 0 usecs
[  157.847136] [drm] ib test on ring 3 succeeded in 0 usecs
[  158.524061] [drm] ib test on ring 5 succeeded

And this is logged in Xorg.0.log after wakeup:

[   229.956] (II) RADEON(0): Allocate new frame buffer 320x200 stride 384=

[   229.956] (II) RADEON(0): VRAM usage limit set to 219596K

xrandr still shows the eDP output as connected and active with 2560x1440 =
resolution.

> Is the panel off or is it on but merely with 0% brightness?

The backlight is definitely off. I've tried to shine a torch onto the pan=
el and
see if any content is visible, but it looks like the panel itself is off,=
 too.

> There's a block of pins on the GPU for "system management" which contai=
ns
> a bunch of GPIO, OEM and reserved pins.  Three of these are used to con=
trol
> the panel when it's switched to the radeon card:
> pin 23	   PNL_PWR_EN
> pin 25	   PNL_BL_EN
> pin 27	   PNL_BL_PWM
>=20
> Basically you'd need to know what these are set to before and after sle=
ep.
> I don't know how to access them, presumably via a BAR register.  A quic=
k
> look at the RV730-specific registers in drivers/gpu/drm/radeon/*.h did =
not
> yield anything useful, but someone at AMD may be able to find this out.=


Can I perhaps use radeontool for this? I.e. dump registers before and aft=
er
sleep and see if there's a difference? Or is radeontool too old to know a=
bout
the correct registers?

Best, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL



--WVwu0j8hOdktEiMDk9GvGoF4A3Jib953h--

--DEk3OnxIxhROUmUIe23JTPq06d8MfX57Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkug2UACgkQ7CzyshGvatibOgCglUrMFcfl5lvGW22qouqh/AkH
/AcAn3SmrAHOupctnXDFserE4/vo0GnK
=bqay
-----END PGP SIGNATURE-----

--DEk3OnxIxhROUmUIe23JTPq06d8MfX57Q--
