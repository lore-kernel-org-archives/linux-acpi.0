From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: OpRegion conflicts for Skylake LPSS
Date: Sun, 01 May 2016 00:47:58 +0200
Message-ID: <8737q24std.fsf@smart-cactus.org>
References: <87lh41nqqq.fsf@smart-cactus.org> <20160426155437.GA10202@lahna.fi.intel.com> <87eg9snkiw.fsf@smart-cactus.org> <87r3dona7g.fsf@smart-cactus.org> <20160429074227.GJ32610@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:55528 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbcD3WsH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Apr 2016 18:48:07 -0400
In-Reply-To: <20160429074227.GJ32610@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> On Fri, Apr 29, 2016 at 09:30:27AM +0200, Ben Gamari wrote:
>> Ben Gamari <ben@smart-cactus.org> writes:
>>=20
>> > [ Unknown signature status ]
>> > Mika Westerberg <mika.westerberg@linux.intel.com> writes:
>> >
>> >> On Tue, Apr 26, 2016 at 02:44:13AM +0200, Ben Gamari wrote:
>> >>>=20
>> > snip
>> >
>> >>> It looks very much like these are describing the same device. Perhaps
>> >>> the lpss driver should be binding to this ACPI node? Or perhaps this=
 is
>> >>> a firmware issue? Any guidance would be greatly appreciated.
>> >>
>> >> Can you send me full acpidump of that machine?
>> >
>> > It can be found at
>> > https://github.com/bgamari/dell-e7470-dsdt/blob/master/acpi.log.
>> >
>> Did this provide any insight? Let me know if more information would be
>> helpful.
>
> Sorry about the delay.
>
No worries.

> The GEXP device is most probably a GPIO expander that is connected to
> one of the I2C buses. And it indeed looks to use directly the I2C host
> controller registers so kernel rightfully complains about that.
>
> Are you able to run Windows on that machine? If yes, it would be nice to
> know if the INT3446 I2C device is shown in the device manager.
>
I had the original SSD that came with the machine with the original
Windows 7 installation intact. I popped it in and found no such device.
I then updated to Windows 10 (albeit still booting with the legacy BIOS,
not EFI) and found that once again there is no such device shown in
device manager.

>> Also, is there a way to simply allow the driver subsystem to allow
>> probing to proceed despite this resource conflict so that I can resume
>> debugging my original input device issue?
>
> Try to pass "acpi_enforce_resources=3Dlax" in the kernel command line.

Thanks, indeed this allows the driver to load. Unfortunately it didn't
take long to encounter further issues.

The motivation for all of this is to get the touchpad into I2C mode, since
currently it is merely exposed as a simple PS/2 device. Unfortunately it
seems that even Windows 10 doesn't use the touchpad's I2C mode (although
I suppose it's possible that this is guarded on UEFI boot; moreover
Windows appears to have proper support for configurating this touchpad
in PS/2 mode, which is unfortunately an ALPS devices).

Looking at the DSDT it seems that enabling the I2C interface may require
the help of the embedded controller, the state of which is exposed in
the DSDT through a mysteriously-named SDS1 field. It looks like this
field could take on a number of values which identify a variety of
different touchpads. Given that it looks like GPIO pin states may be
determined by the value of this field I'm a bit reluctant to go fiddling
around with it.=20

I do wish that firmware weren't such a nightmare.

Cheers,

=2D Ben

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXJTYeAAoJEHPt6ejPuu8BQesH/32Yr0yYNMM5p/EiFwmn2lrj
8bFxtL/n+H6/Nl1pqxPNlHXexp/u6c8xxnD1LghqTvKdU4dHnWdyKgkKKpbcV54N
DI0uX5kopH8wmLyPOqJl0xLS1O/+DYhIbOgxjkb2OlAmkDHj+52ZP6PYVOr9hdhw
gvqVygTz2NuTIuJMMatUtd9q6ln0c3SMW0pRc10ClgKxK9kHO2V/Q3R4nI27uEFA
K0pv3Ovv4ozwyUfUy/Qjkokb+J5vfNrbH6Gc0Qx4VWiNhGvvvCdrsDP3g+LI368V
h3CRB5EuwAerhOCRAaRJ5zBgFfMeNGheWsp+JNd+hvjKcUOuCtEpchIccMfx7DA=
=tDw0
-----END PGP SIGNATURE-----
--=-=-=--
