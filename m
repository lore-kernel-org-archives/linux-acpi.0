From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Notifications about ACPI events in userspace?
Date: Fri, 12 May 2017 13:05:21 +0200
Message-ID: <22eb7eab-21b0-aa5b-a989-0e4e80c707fb@butterbrot.org>
References: <71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org>
 <20170512100652.GA22013@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="d09fVQgVMkkSH09RpAXATIgt4bBU25i0J"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:44646 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932220AbdELLFb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 May 2017 07:05:31 -0400
In-Reply-To: <20170512100652.GA22013@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d09fVQgVMkkSH09RpAXATIgt4bBU25i0J
Content-Type: multipart/mixed; boundary="Qhc6KKeVRkLcE17320LU4uSueGCLI8FKP";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>
Message-ID: <22eb7eab-21b0-aa5b-a989-0e4e80c707fb@butterbrot.org>
Subject: Re: Notifications about ACPI events in userspace?
References: <71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org>
 <20170512100652.GA22013@wunner.de>
In-Reply-To: <20170512100652.GA22013@wunner.de>

--Qhc6KKeVRkLcE17320LU4uSueGCLI8FKP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.05.2017 12:06, Lukas Wunner wrote:
> On Fri, May 12, 2017 at 10:37:47AM +0200, Florian Echtler wrote:
>> I'm currently adding support for the iMac's target display mode (TDM) =
to
>> Linux.
>=20
> Cool!

:-)

>> However, I'm not seeing anything happening with either acpi_listen or
>> kacpimon.
>> Does this require any kernel changes, or could I subscribe to these
>> events somehow?
>=20
> You can subscribe to these events by calling acpi_install_notify_handle=
r().
> See drivers/platform/x86/apple-gmux.c for an example.  That's a driver =
for
> APP000B, a custom chip found on dual-GPU MacBook Pros dubbed GMUX which=
 is
> responsible for multiplexing the panel between the GPUs.

OK, but this has to happen in a kernel context, correct? No way to see th=
ese
from userspace?

> I'm not sure what APP000C is, could be a similar custom controller, I'd=
 have
> to do some research first to know what it does.  Surely "DP" stands for=

> DisplayPort, but what does "PT" stand for?

I'm guessing DPPT is for "DisPlayPorT". As far as I could tell, it's just=
 a stub
for receiving the Notify() calls; the actual source switching is handled =
by
writing to SMC keys.

> Perhaps apple-gmux.c could serve as a template for an APP000C driver.
> The code should be easy to understand, if you have questions just ask a=
way.

Since I need to modify the applesmc.c driver anyway, it would probably ma=
ke
sense to integrate the notify handler there?

The other approach would be to write a dedicated TDM module, but I'm not =
sure
how to access the SMC, then...

Best, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--Qhc6KKeVRkLcE17320LU4uSueGCLI8FKP--

--d09fVQgVMkkSH09RpAXATIgt4bBU25i0J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkVlvEACgkQ7CzyshGvathS6wCfcJoOYrmN/pwa2z8ecf9a/Zhw
5icAoNfp2ySItFaWDc+SjFSR74c9FLTI
=RtlA
-----END PGP SIGNATURE-----

--d09fVQgVMkkSH09RpAXATIgt4bBU25i0J--
