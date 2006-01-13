From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: t41, suspend on ram, power consumption
Date: Fri, 13 Jan 2006 15:04:50 +0100
Message-ID: <87y81kxlz1.fsf@gismo.pca.it>
References: <20060113095634.GA7112@mnementh.homelinux.org>
 <20060113101638.12055.qmail@web81607.mail.mud.yahoo.com>
 <20060113133023.GA6527@mnementh.homelinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha1; boundary="=-=-="
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20060113133023.GA6527-zdned+2MO19t+tyI2NedBz+iFHGzDt/a@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello!

On Fri, 13 Jan 2006 14:30:23 +0100, Fr=C3=A9d=C3=A9ric Gobry wrote:
>> Additionally, you probably want to consider the suspend2 kernel
>> patch series from http://www.suspend2.net/ to allow for reliably
>> shutting the system off without losing state and storing memory
>> into your swap partition or a file.
>
> Does suspend2 change the behavior of the system for suspend to mem,
> or is it only for suspend to disk? I hesitated to use these patches,
> as the debian kernel is far from a vanilla kernel, and I don't think
> they packaged a version of it.

As you're on Debian:
=3D=3D=3D=3D=3D
$ apt-cache search suspend2
kernel-patch-suspend2 - Linux kernel patch for software suspend 2

$ apt-cache policy kernel-patch-suspend2
kernel-patch-suspend2:
  Installed: (none)
  Candidate: 2.1.9.9-4
  Version table:
     2.1.9.9-4 0
          1 http://debian.fastweb.it experimental/main Packages
=3D=3D=3D=3D=3D

FWIW, I've a T42p with a vanilla 2.6.15: suspend-to-ram and
suspend-to-disk works out of the box, with all the drivers enabled
(included ipw2100, radeonfb and Xorg radeon without DRI), even with
multiple repeated cycles.

BTW, I'm on Debian unstable ;-)

Thx, bye,
Gismo / Luca

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDx7OFVAp7Xm10JmkRAmTiAJwKk2Xcm3PXoUYYg1oX8lnVePKIkQCggBeu
UVVpZod66BoIgoXr0RvwB5E=
=RP2B
-----END PGP SIGNATURE-----
--=-=-=--
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
