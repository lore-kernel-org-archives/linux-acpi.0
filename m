From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: 4.0-rc6 errors when opening LID
Date: Mon, 6 Apr 2015 12:02:05 +0200
Message-ID: <201504061202.05760@pali>
References: <201412241951.48652@pali> <201412270919.49540@pali> <1818900.MY9q0yfluC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2302127.WgGjK1nGBK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37027 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbbDFKCJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Apr 2015 06:02:09 -0400
In-Reply-To: <1818900.MY9q0yfluC@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: nick <xerofoify@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

--nextPart2302127.WgGjK1nGBK
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 27 December 2014 21:22:56 Rafael J. Wysocki wrote:
> On Saturday, December 27, 2014 09:19:49 AM Pali Roh=C3=A1r wrote:
> > Hello,
> >=20
> > in attachment is output of ls -l /sys/bus/acpi/devices from
> > both 3.13 and 3.19 kernels.
> >=20
> > Anyway Gabriele Mazzotta wrote me that new acpi devices
> > could be created after commit faae404ebdc6bba (ACPICA: Add
> > "Windows 2013" string to _OSI support).
> >=20
> > Maybe this another output could help you:
> >=20
> > $ cat /sys/bus/acpi/devices/INT33C5\:00/status
> > 0
> > $ cat /sys/bus/acpi/devices/INT33C5\:00/power_state
> > (unknown)
> >=20
> > Device INT33C5 is in that dmesg log:
> > acpi INT33C5:00: Cannot transition to non-D0 state from D3
>=20
> The appended patch should make these messages go away, please
> test.
>=20
> > And status 0 in sysnode could indicate that acpi device is
> > not present right?
>=20
> That's correct.
>=20
> ---
>  drivers/acpi/device_pm.c |    7 ++++---
>  include/acpi/acpi_bus.h  |    3 ++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> Index: linux-pm/include/acpi/acpi_bus.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -589,7 +589,8 @@ static inline u32 acpi_target_system_sta
>=20
>  static inline bool acpi_device_power_manageable(struct
> acpi_device *adev) {
> -	return adev->flags.power_manageable;
> +	return adev->flags.power_manageable
> +		&& (adev->status.present || adev->status.functional);
>  }
>=20
>  static inline bool acpi_device_can_wakeup(struct acpi_device
> *adev) Index: linux-pm/drivers/acpi/device_pm.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -68,7 +68,8 @@ int acpi_device_get_power(struct acpi_de
>  {
>  	int result =3D ACPI_STATE_UNKNOWN;
>=20
> -	if (!device || !state)
> +	if (!device || !state
> +	    || !(device->status.present ||
> device->status.functional)) return -EINVAL;
>=20
>  	if (!device->flags.power_manageable) {
> @@ -156,7 +157,7 @@ int acpi_device_set_power(struct acpi_de
>  	int result =3D 0;
>  	bool cut_power =3D false;
>=20
> -	if (!device || !device->flags.power_manageable
> +	if (!device || !acpi_device_power_manageable(device)
>=20
>  	    || (state < ACPI_STATE_D0) || (state >
>  	    || ACPI_STATE_D3_COLD))
>=20
>  		return -EINVAL;
>=20
> @@ -361,7 +362,7 @@ bool acpi_bus_power_manageable(acpi_hand
>  	int result;
>=20
>  	result =3D acpi_bus_get_device(handle, &device);
> -	return result ? false : device->flags.power_manageable;
> +	return result ? false :
> acpi_device_power_manageable(device); }
>  EXPORT_SYMBOL(acpi_bus_power_manageable);

Hello Rafael,

sorry for long delay. Now I tested your patch on top of 4.0-rc6=20
version and I'm still getting one acpi error message (and lot of =20
others) in dmesg each time I open LID of my laptop:

kernel: [   62.016803] acpi device:41: Cannot transition to power=20
state D3cold for parent in (unknown)

If it helps here is more info about that acpi "device:41":

/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/INT33C6:00/device:41
$ grep "" *
adr:0x00000001
path:\_SB_.PCI0.SDHC.WI01
power_state:D0
status:15

And here about parent ("../")

/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/INT33C6:00
$ grep "" *
adr:0x00170000
hid:INT33C6
modalias:acpi:INT33C6:PNP0D40:
path:\_SB_.PCI0.SDHC
status:0
uevent:MODALIAS=3Dacpi:INT33C6:PNP0D40:
uid:1

It is OK, that one device has status 0 (not present) and its=20
child has non zero status? Looks like here is problem...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2302127.WgGjK1nGBK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUiWZ0ACgkQi/DJPQPkQ1LIBwCfQr2WtuvcjyaUYbBtqP4aTKBx
XRYAnih6mEWQwAKYYLS0p4iNirupIUJa
=vywH
-----END PGP SIGNATURE-----

--nextPart2302127.WgGjK1nGBK--
