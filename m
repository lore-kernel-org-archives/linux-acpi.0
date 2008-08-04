From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: Check for ACPI backlight support otherwise use vendor
	ACPIdrivers - version 4
Date: Mon, 04 Aug 2008 08:09:52 +0200
Message-ID: <1217830192.4580.8.camel@hidalgo>
References: <1217605083-31003-1-git-send-email-trenn@suse.de>
	 <1217632817.4610.6.camel@hidalgo>  <1217812580.2969.184.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YlXifzAkaUQtIA+/L+9N"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from molly.corsac.net ([81.57.48.219]:44629 "EHLO molly.corsac.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753901AbYHDGJw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Aug 2008 02:09:52 -0400
In-Reply-To: <1217812580.2969.184.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, hmh@debian.org


--=-YlXifzAkaUQtIA+/L+9N
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On lun, 2008-08-04 at 09:16 +0800, Zhang Rui wrote:
> I think you're using the laptop that this patch does break.
> Please try acpi_backlight=3Dvendor.

When booting to single user with acpi_backlight=3Dvendor, thinkpad-acpi
takes over backlight:

Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: ThinkPad ACPI Extras v0.21
Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: http://ibm-acpi.sf.net/
Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: ThinkPad BIOS 7LETB9WW (2.19=
 ), EC 7KHT24WW-1.08
Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: Lenovo ThinkPad T61, model 8=
897CTO
Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: radio switch found; radios a=
re enabled
Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: This ThinkPad has standard A=
CPI backlight brightness control, supported by the ACPI video driver
Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: Disabling thinkpad-acpi brig=
htness events by default...
Aug  4 07:54:38 hidalgo kernel: Registered led device: tpacpi::thinklight
Aug  4 07:54:38 hidalgo kernel: Registered led device: tpacpi::power
Aug  4 07:54:38 hidalgo kernel: Registered led device: tpacpi:orange:batt
Aug  4 07:54:38 hidalgo kernel: Registered led device: tpacpi:green:batt
Aug  4 07:54:38 hidalgo kernel: Registered led device: tpacpi::dock_active
Aug  4 07:54:38 hidalgo kernel: Registered led device: tpacpi::bay_active
Aug  4 07:54:38 hidalgo kernel: Registered led device: tpacpi::dock_batt
Aug  4 07:54:38 hidalgo kernel: Registered led device: tpacpi::unknown_led
Aug  4 07:54:38 hidalgo kernel: Registered led device: tpacpi::standby
Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: Standard ACPI backlight inte=
rface not available, thinkpad_acpi driver will take over control
Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: detected a 16-level brightne=
ss capable ThinkPad
Aug  4 07:54:38 hidalgo kernel: input: ThinkPad Extra Buttons as /devices/v=
irtual/input/input6
Aug  4 07:54:38 hidalgo kernel: usb 1-1: new full speed USB device using uh=
ci_hcd and address 4
Aug  4 07:54:38 hidalgo kernel: usb 1-1: configuration #1 chosen from 1 cho=
ice

But when in user mode, brightness keys doesn't do anything either.
Echo'ing to /proc/acpi/ibm/brightness doesn't work, but echoing
to /sys/class/backlight/thinkpad_screen/brightness works.

Cat'ing /proc/acpi/events still gives:
video LCD0 00000086 00000000
video LCD0 00000087 00000000

At one time I get the 750ms delay, but I don't have the=20
ibm/hotkey HKEY 00000080 00005010 at all.

In X, same thing, no brightness keys, but xbacklight does work in
standard mode (=E2=80=9Ckernel=E2=80=9D).

(btw it seems my mails don't reach linux-acpi, I don't really know why
and postmaster don't answer, maybe they didn't have my mail either).

Cheers,
--=20
Yves-Alexis

--=-YlXifzAkaUQtIA+/L+9N
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiWnTAACgkQTUTAIMXAW67LbwCgmLJXSJSQiONpQG/L8pe1q/0u
FH0AnjpWRWN0e5Y7D8t3HjzhTgIviGIc
=2W1D
-----END PGP SIGNATURE-----

--=-YlXifzAkaUQtIA+/L+9N--
