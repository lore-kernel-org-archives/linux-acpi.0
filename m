From: Karol Babioch <karol@babioch.de>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with
 the sony-platform module]
Date: Sat, 16 Jun 2012 20:07:53 +0200
Message-ID: <4FDCCB79.9090305@babioch.de>
References: <4FDA2051.3050108@babioch.de> <20120614203914.GA2645@kamineko.org> <4FDAE7FE.5030706@babioch.de> <20120615113637.GA5904@kamineko.org> <4FDB5202.706@babioch.de> <20120615223711.GA31180@kamineko.org> <4FDBC183.7050203@babioch.de> <20120616025223.GA5200@kamineko.org> <4FDC6D0A.8080505@babioch.de> <20120616130705.GB2326@kamineko.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig76083B7CA619298BAAB3C3EA"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from babioch.de ([176.9.120.167]:37076 "EHLO babioch.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab2FPSH7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Jun 2012 14:07:59 -0400
In-Reply-To: <20120616130705.GB2326@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig76083B7CA619298BAAB3C3EA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Am 16.06.2012 15:07, schrieb Mattia Dongili:
> how about the sony-laptop stuff with 3.1+patches?
> What is the output of
> $ grep . /sys/class/backlight/*/*
> $ grep . /sys/devices/platform/sony-laptop/*
> and the kernel log after these two commands

Here you go:

/sys/class/backlight/nv_backlight/actual_brightness:1073864551
/sys/class/backlight/nv_backlight/bl_power:0
/sys/class/backlight/nv_backlight/brightness:1073864551
/sys/class/backlight/nv_backlight/max_brightness:1025
/sys/class/backlight/nv_backlight/type:raw
/sys/class/backlight/sony/actual_brightness:-13
/sys/class/backlight/sony/bl_power:0
/sys/class/backlight/sony/brightness:-13
/sys/class/backlight/sony/max_brightness:242
/sys/class/backlight/sony/type:platform

/sys/devices/platform/sony-laptop/battery_care_health:0
/sys/devices/platform/sony-laptop/battery_care_limiter:0
/sys/devices/platform/sony-laptop/handles:0x0100 0x0101 0x0105 0x0103
0x0114 0x011d 0x0122 0x0126 0x0134 0x0135 0x0136 0x0137 0x013a 0x0000
0x0000 0x0000
/sys/devices/platform/sony-laptop/kbd_backlight:1
/sys/devices/platform/sony-laptop/kbd_backlight_timeout:0
/sys/devices/platform/sony-laptop/modalias:platform:sony-laptop
/sys/devices/platform/sony-laptop/thermal_control:balanced
/sys/devices/platform/sony-laptop/thermal_profiles:balanced silent
performance
/sys/devices/platform/sony-laptop/touchpad:1
/sys/devices/platform/sony-laptop/uevent:DRIVER=3Dsony-laptop
/sys/devices/platform/sony-laptop/uevent:MODALIAS=3Dplatform:sony-laptop

[  296.031762] sony_laptop: found handle 0x0137 (offset: 0x0b)
[  296.146850] sony_laptop: __call_snc_method: [SN07:0x000000000000020b]
[  296.146852] sony_laptop: called SN07 with 0x020b (result: 0x0000)
[  304.972709] sony_laptop: found handle 0x0136 (offset: 0x0a)
[  304.973407] sony_laptop: __call_snc_method: [SN07:0x000000000000020a]
[  304.973412] sony_laptop: called SN07 with 0x020a (result: 0x0000)
[  304.973517] sony_laptop: found handle 0x0136 (offset: 0x0a)
[  304.974231] sony_laptop: __call_snc_method: [SN07:0x000000000000000a]
[  304.974235] sony_laptop: called SN07 with 0x000a (result: 0x0000)
[  304.974608] sony_laptop: found handle 0x0122 (offset: 0x06)
[  304.975082] sony_laptop: __call_snc_method: [SN07:0x0000000000000106]
[  304.975086] sony_laptop: called SN07 with 0x0106 (result: 0x0000)
[  304.975129] sony_laptop: found handle 0x0105 (offset: 0x02)
[  304.975681] sony_laptop: __call_snc_method: [SN07:0x0000000000000002]
[  304.975683] sony_laptop: called SN07 with 0x0002 (result: 0x0000)

> I'm trying to understand is if the patch series I sent works for
> you on the last working version of kernel (i.e. 3.1 apparently).
No, it doesn't work neither on 3.0 nor on 3.1. Interestingly the
original patch that definitely did work on 3.0 and 3.1. I'm not quite
sure what is the reason for this. I've basically compiled every kernel
version from 3.0 to 3.3 :(.

> it is actually. What did you have in the sony-laptop sysfs directories
> when booting with acpi_backlight=3Dvendor?
Unfortunately I don't know and can't reproduce a working solution here
:(. Any clue why this could be?

Best regards,
Karol Babioch


--------------enig76083B7CA619298BAAB3C3EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJP3Mt8AAoJEHSaZc1HnzIVQ3cQALZvHVlTTA0OTldsrxdmRQh5
Lh7GbGoBTytKoSUMmfKLCeqYcDbkkGps7856LehDl3jthEjB4THJiynpl7oNpyW8
HpA0uAab5aqEF/fLRE9nSdODQnLFP7ANmNfFCrubrbosOqfJZoEu5SZniviZ3SEs
K4kps1RYf/HtV4zgjhEZjqnXVAJIq4dHH9OBjc0ikE/61HAkW6RdvTm2xVmOjkjv
G5gHlMgq9yl25e6aP7mMNhCI6YVRFWr7ss+8Jy2olei/klC2u7HMut7tYTdG17Wv
Qmr62aB/JlkU52OTnn9EZe75QeQpdZcaQVXI72+IdfovejuV+OsBR49bOJlVaeyT
beTxFL7lAei5dsQK3ZQHxjpSTwDzZyg21152ctEVfIRx35RR+5EVkmF3twVuWC/v
jJRkO41qXy7ZnEZ7qwTjKNRTAZLvLEywhTmGPPypTZJUHgbuRASHfRDcFyew5owX
BbX33llKkLbHZrfKp19PaO6TwuySUzhgnbeuFz1nav6QD/9FJ7F0w//BmZoWMfXH
/SbrUka9DopdkDLIGaXW8Tso9d93jBWSOB+pVkmZy45/YUblVVT1RqO1QC5xLxRg
49aP8ZBxFTefs+m43ygH6CsbF3ihl9joPXTG/tGSc7sTECgleR9WbR6V+PFwl4Cj
hFYC10IzTf6YNINm70Ws
=ibYQ
-----END PGP SIGNATURE-----

--------------enig76083B7CA619298BAAB3C3EA--
