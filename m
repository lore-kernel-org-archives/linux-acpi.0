From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Notifications about ACPI events in userspace?
Date: Sun, 14 May 2017 11:25:48 +0200
Message-ID: <be932ef4-fbfb-2555-82b9-ba01b447ae7f@butterbrot.org>
References: <71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org>
 <20170512100652.GA22013@wunner.de>
 <22eb7eab-21b0-aa5b-a989-0e4e80c707fb@butterbrot.org>
 <20170513121824.GA685@wunner.de>
 <35eb95e2-5876-5ed8-e8e9-6811fd656618@butterbrot.org>
 <20170514081105.GB1255@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="c7OI6tRT4qQPo8s73gtUOAKf5o1AMSExV"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:48539 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751689AbdENJZ7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 14 May 2017 05:25:59 -0400
In-Reply-To: <20170514081105.GB1255@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, Henrik Rydberg <rydberg@bitmath.org>, Nicolas Boichat <nicolas@boichat.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c7OI6tRT4qQPo8s73gtUOAKf5o1AMSExV
Content-Type: multipart/mixed; boundary="NtkDS3haXQc0nOQH7xT1c4eGsEpnVPtmq";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Henrik Rydberg <rydberg@bitmath.org>, Nicolas Boichat <nicolas@boichat.ch>
Message-ID: <be932ef4-fbfb-2555-82b9-ba01b447ae7f@butterbrot.org>
Subject: Re: Notifications about ACPI events in userspace?
References: <71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org>
 <20170512100652.GA22013@wunner.de>
 <22eb7eab-21b0-aa5b-a989-0e4e80c707fb@butterbrot.org>
 <20170513121824.GA685@wunner.de>
 <35eb95e2-5876-5ed8-e8e9-6811fd656618@butterbrot.org>
 <20170514081105.GB1255@wunner.de>
In-Reply-To: <20170514081105.GB1255@wunner.de>

--NtkDS3haXQc0nOQH7xT1c4eGsEpnVPtmq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.05.2017 10:11, Lukas Wunner wrote:
> On Sat, May 13, 2017 at 06:47:16PM +0200, Florian Echtler wrote:
>> On 13.05.2017 14:18, Lukas Wunner wrote:
>>>
>>> Then you could switch back and forth via the vga_switcheroo interface=
=2E
>>
>> Hm... since there's no power switching of any kind involved, would tha=
t
>> still make sense?
>=20
> The handler's ->power_state hook would be a no-op.  Obviously not prett=
y,
> but we just don't have a better abstraction yet.  We represent an egres=
s
> connector on a graphics card as a drm_connector in sysfs.  What we migh=
t
> need is a representation of a sink (display) in sysfs with symlinks to =
the
> sources.  Such a source could be a drm_connector or something else
> entirely (a GPU on another machine in your case).

OK, I think it's the closest thing that's already in the kernel, and befo=
re I
add yet another custom sysfs node, vga_switcheroo is probably the easiest=
 route
to get things up and running.

>> AFAICT, the alternative (which maybe would be more sensible, the more =
I
>> think about it) would be to export applesmc_{read,write}_key as public=

>> symbols and just access them from a standalone driver for the APP000C
>> ACPI device. Since that should only be present on a Mac that actually
>> supports TDM, there's also no risk of writing to arbitrary SMC keys on=

>> unsupported devices.
>=20
> That might make sense if you feel the driver will grow large enough to
> make applesmc.c look messy, or if you feel it just doesn't fit there.

Everything else in applesmc.c is hwmon-related, IMHO it would be a kludge=
=2E So
for applesmc, I'd just need a tiny patch to export the main key access
functions, and everything else can (hopefully) be encapsulated in an "app=
le-tdm"
driver.

> I guess the only reason why Apple integrated the functionality into the=

> SMC is because they wanted to support TDM when the machine is powered o=
ff.
> The SMC is powered even in S5 (if the iMac is connected to AC), it just=

> needs to monitor HPD on the external port and turn on the backlight if
> something is plugged in.  (I'm not sure if TDM is actually supported
> during poweroff but technically it would seem to be supported.)

Hm, interesting, I hadn't yet thought of that. This would of course be
excellent, because right now it looks like a waste of power to run the wh=
ole
machine just because of the display.

Does the SMC have control over the backlight? Do you know which keys are
responsible? IIRC the apple_bl.c driver didn't work on my iMac anyway...

Best, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--NtkDS3haXQc0nOQH7xT1c4eGsEpnVPtmq--

--c7OI6tRT4qQPo8s73gtUOAKf5o1AMSExV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkYIpwACgkQ7CzyshGvatgsQwCgyDf1t2aTOQn7mPkKhT8ocGGt
HR8AoLHwJZnAHZzYuN2WhSm8RQfYCpkX
=yMCR
-----END PGP SIGNATURE-----

--c7OI6tRT4qQPo8s73gtUOAKf5o1AMSExV--
