From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Notifications about ACPI events in userspace?
Date: Sat, 13 May 2017 18:47:16 +0200
Message-ID: <35eb95e2-5876-5ed8-e8e9-6811fd656618@butterbrot.org>
References: <71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org>
 <20170512100652.GA22013@wunner.de>
 <22eb7eab-21b0-aa5b-a989-0e4e80c707fb@butterbrot.org>
 <20170513121824.GA685@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5xU5fShLm0dQkWEm23aSp4OJl2Bc0AS42"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:34105 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752726AbdEMQrW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 13 May 2017 12:47:22 -0400
In-Reply-To: <20170513121824.GA685@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5xU5fShLm0dQkWEm23aSp4OJl2Bc0AS42
Content-Type: multipart/mixed; boundary="f7eJ6VTbwCHSM64cJxE2uI9Qlm6EuC8aT";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <35eb95e2-5876-5ed8-e8e9-6811fd656618@butterbrot.org>
Subject: Re: Notifications about ACPI events in userspace?
References: <71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org>
 <20170512100652.GA22013@wunner.de>
 <22eb7eab-21b0-aa5b-a989-0e4e80c707fb@butterbrot.org>
 <20170513121824.GA685@wunner.de>
In-Reply-To: <20170513121824.GA685@wunner.de>

--f7eJ6VTbwCHSM64cJxE2uI9Qlm6EuC8aT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.05.2017 14:18, Lukas Wunner wrote:
>=20
> So to sum it up, the built-in panel on the iMac can be driven by a
> separate machine and we can switch between the two sources via the SMC.=

>
> [...]
>
> I guess you could register a vga_switcheroo handler which controls
> switching via the SMC.  You'd also have to register a vga_switcheroo
> client whenever you detect hotplug of an external source (and unregiste=
r
> on unplug).  The client is normally a DRM driver but would in this case=

> just be a pseudo device.
>=20
> Then you could switch back and forth via the vga_switcheroo interface.

Hm... since there's no power switching of any kind involved, would that s=
till
make sense?

> On macOS I can't find the "dppt" string in any kernel extension, but
> it's present in this user space component:
> /System/Library/LoginPlugins/BezelServices.loginPlugin/Contents/MacOS/B=
ezelServices
>=20
> Disassembling it reveals that it talks to a special Mach port to switch=

> the display but it's not listening to the Notify() events.  Perhaps thi=
s
> is only used with BootCamp?
>=20
> In any case the other end of the Mach port seems to be /usr/libexec/dpd=
=2E

I think the dpd binary is also somehow listening for ACPI events, or it i=
s
triggered by some other component when the ACPI Notify happens (in
com.apple.dpd.plist, you can also find the "smc-dppt" string,).

>> As far as I could tell, it's just a stub
>> for receiving the Notify() calls; the actual source switching is handl=
ed by
>> writing to SMC keys.
>=20
> Yes, the Notify() calls are used to generate some kind of interrupt,
> perhaps one for hotplug and the other one for unplug?

Correct, I already verified this with EC debugging turned on - _Q31 is tr=
iggered
when an external source is plugged in, _Q30 when it is removed.

>>> Perhaps apple-gmux.c could serve as a template for an APP000C driver.=

>>> The code should be easy to understand, if you have questions just ask=
 away.
>>
>> Since I need to modify the applesmc.c driver anyway, it would probably=
 make
>> sense to integrate the notify handler there?
>=20
> Sounds reasonable to me.

AFAICT, the alternative (which maybe would be more sensible, the more I t=
hink
about it) would be to export applesmc_{read,write}_key as public symbols =
and
just access them from a standalone driver for the APP000C ACPI device. Si=
nce
that should only be present on a Mac that actually supports TDM, there's =
also no
risk of writing to arbitrary SMC keys on unsupported devices.

> Which iMac model are you developing this on exactly, a 2009/2010 model
> (without Thunderbolt) or a newer one?  The newer ones can only be drive=
n
> via DP-over-Thunderbolt tunnels, so the HPD pin is coming from the
> Thunderbolt controller, not the socket.  We don't have support for
> setting up DP-over-Thunderbolt tunnels in thunderbolt.ko yet, only
> PCIe-over-Thunderbolt is supported.  If the external source is already
> present on boot, the tunnel may be established by the Thunderbolt EFI
> driver but will be gone after unplug.

I have a 2009/2010 model, so no Thunderbolt. If someone is feeling advent=
urous
with a Thunderbolt iMac, feel free to poke the SMC. I've written a short =
blog
post that should be sufficient as background information for some initial=

experiments: http://floe.butterbrot.org/matrix/hacking/tdm/ and
https://github.com/floe/smc_util (in particular, look at tdm_{on,off}.sh)=
=2E

Best, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--f7eJ6VTbwCHSM64cJxE2uI9Qlm6EuC8aT--

--5xU5fShLm0dQkWEm23aSp4OJl2Bc0AS42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkXOJQACgkQ7CzyshGvati0PACgxl10Iemh6itCl2iWPZOLhhlY
p1cAoN0OWUCyfN3cRgFwn8mVU+TreWBd
=O21E
-----END PGP SIGNATURE-----

--5xU5fShLm0dQkWEm23aSp4OJl2Bc0AS42--
