From: Florian Echtler <floe@butterbrot.org>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
Date: Tue, 30 May 2017 11:34:17 +0200
Message-ID: <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
References: <30380cb3-0f26-8aea-2689-d4886879129c@butterbrot.org>
 <20170526210340.GA5114@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LgtoB1uKisubUsSlaSTAUIJhtmqToj1BC"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:42640 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbdE3JeT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 May 2017 05:34:19 -0400
In-Reply-To: <20170526210340.GA5114@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LgtoB1uKisubUsSlaSTAUIJhtmqToj1BC
Content-Type: multipart/mixed; boundary="qII9nGj8BN9GPGn45blROA8Jg54dbMDRP";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Message-ID: <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
References: <30380cb3-0f26-8aea-2689-d4886879129c@butterbrot.org>
 <20170526210340.GA5114@wunner.de>
In-Reply-To: <20170526210340.GA5114@wunner.de>

--qII9nGj8BN9GPGn45blROA8Jg54dbMDRP
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 26.05.2017 23:03, Lukas Wunner wrote:
> On Fri, May 26, 2017 at 02:13:29PM +0200, Florian Echtler wrote:
>> I'm running Ubuntu 16.04.2 on a 27" unibody iMac 10,1 from 2009. Howev=
er, even
>> with the most recent HWE stack (kernel 4.8), the display stays black a=
fter
>> suspend. I can ssh into the machine, so wakeup is OK, but the display =
is
>> entirely black (backlight stays off).
>>
> The ATI card has MXM_PNL_PWR_EN and MXM_PNL_BL_EN pins.  Those must be
> enabled for the panel to light up.  Perhaps radeon needs to be extended=

> to do that.  One theory is that this is done via ACPI, but perhaps
> only if a certain operating system is running.  Dump the ACPI tables
> and search DSDT and SSDT* tables for methods relating to the ATI card
> and/or backlight.  If you find checks for OSDW there (e.g. in _PS0,
> i.e. on resume), it means the AML code is only executed on Darwin.
I've already had a look at the ACPI tables; there seem to be no reference=
s to
the "official" backlight/display control functions (no _BL? or _DO? metho=
ds).

> Conversely !OSDW means the code is only executed on Windows (Boot Camp)=
=2E
> Linux masquerades as Darwin, but this can be disabled with
> acpi_osi=3D!Darwin on the command line.  It's worth trying if that chan=
ges
> the behaviour.  If it does, then macOS likely sets those pins on resume=

> and we need to do the same in radeon.
There are OSDW checks present, however, booting with acpi_osi=3D!Darwin d=
oesn't
make a difference to the backlight behaviour.

I'd be grateful for other suggestions...

Best regards, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL



--qII9nGj8BN9GPGn45blROA8Jg54dbMDRP--

--LgtoB1uKisubUsSlaSTAUIJhtmqToj1BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlktPJkACgkQ7CzyshGvatjGTgCg8chDnYxLyo0K8gZJgnA/UDSX
8e0AoNmRn8/uSChY8J4chCvjGnivReS4
=KhIs
-----END PGP SIGNATURE-----

--LgtoB1uKisubUsSlaSTAUIJhtmqToj1BC--
