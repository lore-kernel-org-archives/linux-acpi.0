From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: ACPI: Unable to turn cooling device 'on' (Quadcore-AMD64,
	Ubuntu64)
Date: Tue, 06 Jan 2009 09:00:17 +0800
Message-ID: <1231203617.4026.2.camel@yakui_zhao.sh.intel.com>
References: <4961D742.6050702@tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16532 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbZAFAtr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Jan 2009 19:49:47 -0500
In-Reply-To: <4961D742.6050702@tugraz.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alois =?ISO-8859-1?Q?Schl=F6gl?= <alois.schloegl@tugraz.at>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "acpi-bugzilla@lists.sourceforge.net" <acpi-bugzilla@lists.sourceforge.net>

On Mon, 2009-01-05 at 17:47 +0800, Alois Schl=C3=B6gl wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> kern.log shows this sequence
It seems that this is related with BIOS.
Will you please try the boot option of "acpi.power_nocheck=3D1" and see
whether this issue still exists?

It will be great if you can attach the output of acpidump.

Please file a bug report at
http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI and attach the
output of acpidump, dmesg, dmidecode.
Thanks.


>=20
> ...
> Jan  2 09:09:45 schloegl-desktop kernel: [  136.114080] sd 7:0:0:0:
> Attached scsi generic sg6 type 0
> Jan  2 18:01:35 schloegl-desktop kernel: [32046.051225] usb 6-2: USB
> disconnect, address 2
> Jan  2 18:06:37 schloegl-desktop kernel: [32348.396058] ACPI Exceptio=
n
> (thermal-0469): AE_ERROR, ACPI thermal trip point state changed
> Jan  2 18:06:37 schloegl-desktop kernel: [32348.396083] Please send
> acpidump to linux-acpi@vger.kernel.org
> Jan  2 18:06:37 schloegl-desktop kernel: [32348.396085]  [20080609]
> Jan  2 18:06:37 schloegl-desktop kernel: [32348.396540] ACPI: Critica=
l
> trip point
> Jan  2 18:06:37 schloegl-desktop kernel: [32348.396568] Critical
> temperature reached (71 C), shutting down.
> Jan  2 18:06:37 schloegl-desktop kernel: [32348.396598] ACPI: Unable =
to
> turn cooling device [ffff88012fa34a60] 'on'
> Jan  2 18:06:43 schloegl-desktop kernel: [32354.396226] Critical
> temperature reached (58 C), shutting down.
> Jan  2 18:06:47 schloegl-desktop kernel: [32358.303777] ip6_tables: (=
C)
> 2000-2006 Netfilter Core Team
> Jan  5 09:01:55 schloegl-desktop kernel: Inspecting
> /boot/System.map-2.6.27-9-generic
> ...
>=20
> acpidump.bin is attached.
>=20
> This happenend on my new quad-core amd64 with ubuntu 64, starting a
> heavy computing batch (using matlab, distributing the load on all 4
> cpu's) before I left work on Jan 2nd. About 10 minutes later the mach=
ine
> shut down by itself.
>=20
>=20
> The bug is also reported at
> https://bugs.launchpad.net/ubuntu/+source/acpi/+bug/314001
>=20
>=20
>=20
> Best regards,
>     Alois
>=20
>=20
>=20
>=20
>=20
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>=20
> iEYEARECAAYFAklh1z4ACgkQzSlbmAlvEIjFUgCgpNT5j7XTDurSS2CObAjaJtom
> 3m4An0IZgOgxAldB/pNERVE1zEntVvw5
> =3Dwn3B
> -----END PGP SIGNATURE-----

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
