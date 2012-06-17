From: Karol Babioch <karol@babioch.de>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with
 the sony-platform module]
Date: Sun, 17 Jun 2012 12:50:39 +0200
Message-ID: <4FDDB67F.7090704@babioch.de>
References: <20120614203914.GA2645@kamineko.org> <4FDAE7FE.5030706@babioch.de> <20120615113637.GA5904@kamineko.org> <4FDB5202.706@babioch.de> <20120615223711.GA31180@kamineko.org> <4FDBC183.7050203@babioch.de> <20120616025223.GA5200@kamineko.org> <4FDC6D0A.8080505@babioch.de> <20120616130705.GB2326@kamineko.org> <4FDCCB79.9090305@babioch.de> <20120616231658.GC2326@kamineko.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9D33B3866B7E23836F97E603"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from babioch.de ([176.9.120.167]:37078 "EHLO babioch.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755023Ab2FQKuq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Jun 2012 06:50:46 -0400
In-Reply-To: <20120616231658.GC2326@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9D33B3866B7E23836F97E603
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Am 17.06.2012 01:16, schrieb Mattia Dongili:
> I'm a bit lost at this point. Are you saying that you cannot get a
> working backlight control with the old set-up you had?
Yeah, I can't get it working. Tried nearly every kernel from 3.0
onwards. Don't know what is going on here :(. Any idea what could have
caused this?

> If so what else did you change in your set up?
Well, I'm on Arch Linux, which is a rolling release distribution. So
there is probably a lot of stuff, which has changed during the course of
the last two to three months :(.

> Also, any chance you could try to inspect/poke the acpi_video0 or
> sony-laptop backlight directories without loading the nouveau driver?
Yeah, sure. In both cases the brightness won't change. Here you have
some excerpts in the case of "acpi_backlight=3Dvendor" again:

[root@vpcs ~]# grep . /sys/class/backlight/sony/*/*
/sys/class/backlight/sony/actual_brightness:-13
/sys/class/backlight/sony/bl_power:0
/sys/class/backlight/sony/brightness:-13
/sys/class/backlight/sony/max_brightness:242
/sys/class/backlight/sony/type:platform

I then echoed 100 to /sys/class/backlight/sony/brightness and dmesg
reported the following:

[   89.631235] sony_laptop: found handle 0x0137 (offset: 0x0b)
[   89.753455] sony_laptop: __call_snc_method: [SN07:0x000000000000020b]
[   89.753457] sony_laptop: called SN07 with 0x020b (result: 0x0000)

Not sure what this means, but probably nouveau is not the culprit here.

Best regards,
Karol Babioch


--------------enig9D33B3866B7E23836F97E603
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJP3baCAAoJEHSaZc1HnzIVBUEP/RS+Y0RUBZ9sR4EAIcZvTIsZ
jt9fAWSkgsbI12f/hp3jQAiLSMRlRQpf6krURVJal/e0dRAuLTHQmi36TKFsBI4m
4EX4RFRgPo0ptsVEoxF6bR47TqN1RA7xl+f9eitCJctOhSfH0GPLisYQ7D1bFufn
dyD5FyjcN4DicmNiaMTf89f91HfCzAlIvjX+m0Xa+ziu6EP7SKnXEy+oEFPb+0tW
e09XZNwzg6/tjIqu7Nja6mMFKoYGVj6ajjJnp3Gcx0Yx87DozIRqk9hF8SqBCb4Z
6I+b4qmuLKYVG7r9mPKrPg8apgm5FdwoWz8dYCs/8Oz05O1MUtmiEKNTFN2IrSP5
YSObYbruX/5A/+RVyimydR/2LnFNi0J90AQxHGwvchD3CxrB9DgIkEZSQJq5TPjd
w6nGyEEM7+96JSX6BMFi2jWGImvE8NjEtkjDYnLV6EHWgm/E+9HFaw786o93fYdU
Uy+3rk9Dm4lsN89vgsqbiVyxQkKxkz1l7+66vvr1VbnGlOWAypAhIBGiGRaqB5/s
32TFi0cYP1FZMbL0dB6sFTTGMg3xxF3JZVMAIOmH1eB3rrr8OjkTvL/NYiYb8VFV
YqpF3U/j5ID+9jwWpsww5z/fY9PoUI3I/FouF1p5xuVj9xgnVHFkvstavE7dfJg/
j6aFC8kY5ANBBAlHweuW
=uD1y
-----END PGP SIGNATURE-----

--------------enig9D33B3866B7E23836F97E603--
