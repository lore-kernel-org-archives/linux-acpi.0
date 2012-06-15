From: Karol Babioch <karol@babioch.de>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with
 the sony-platform module]
Date: Sat, 16 Jun 2012 01:13:07 +0200
Message-ID: <4FDBC183.7050203@babioch.de>
References: <4FDA2051.3050108@babioch.de> <20120614203914.GA2645@kamineko.org> <4FDAE7FE.5030706@babioch.de> <20120615113637.GA5904@kamineko.org> <4FDB5202.706@babioch.de> <20120615223711.GA31180@kamineko.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6F4CA8C43934F47F9346824C"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from babioch.de ([176.9.120.167]:37067 "EHLO babioch.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758479Ab2FOXNN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Jun 2012 19:13:13 -0400
In-Reply-To: <20120615223711.GA31180@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6F4CA8C43934F47F9346824C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Am 16.06.2012 00:37, schrieb Mattia Dongili:
> ok, let's forget about gnome popups for a moment, can you try using the=

> sysfs files directly?
I suppose you expect me to use the "acpi_backlight=3Dvendor" parameter?
Because when leaving it out, I don't have any sony subdirectory within
/sys/class/backlight. The only directory is
/sys/class/backlight/acpi_video0, but changing the brightness directly
there doesn't change anything.

With the "acpi_backlight=3Dvendor" boot paramater I got a sony sub
directory (as well as a "nv" subdirectory), but see yourself:

[johnpatcher@vpcs ~]$ ls -l /sys/class/backlight/
insgesamt 0
lrwxrwxrwx 1 root root 0 16. Jun 2012  nv_backlight ->
=2E./../devices/pci0000:00/0000:00:01.0/0000:01:00.0/drm/card0/card0-LVDS=
-1/nv_backlight
lrwxrwxrwx 1 root root 0 16. Jun 01:00 sony ->
=2E./../devices/virtual/backlight/sony

I tried to change the brightness via sysfs with the following command:

[root@vpcs sony]# cat actual_brightness brightness max_brightness
-13
-13
242
[root@vpcs sony]# echo 150 > brightness

But nothing changed. dmesg reports the following:

[  419.046851] sony_laptop: found handle 0x0137 (offset: 0x0b)
[  419.169874] sony_laptop: __call_snc_method: [SN07:0x000000000000020b]
[  419.169877] sony_laptop: called SN07 with 0x020b (result: 0x0000)
[  423.710466] sony_laptop: found handle 0x0137 (offset: 0x0b)
[  423.834322] sony_laptop: __call_snc_method: [SN07:0x000000000000020b]
[  423.834324] sony_laptop: called SN07 with 0x020b (result: 0x0000)
[  456.260994] sony_laptop: found handle 0x0137 (offset: 0x0b)
[  456.384772] sony_laptop: __call_snc_method: [SN07:0x000000000000020b]
[  456.384774] sony_laptop: called SN07 with 0x020b (result: 0x0000)
[  461.256523] sony_laptop: found handle 0x0137 (offset: 0x0b)
[  461.386744] sony_laptop: __call_snc_method: [SN07:0x0000000000a3010b]
[  461.386746] sony_laptop: called SN07 with 0xa3010b (result: 0x0000)

Interestingly enough I can change the brightness via
/sys/class/backlight/nv_backlight:

[root@vpcs nv_backlight]# cat actual_brightness brightness max_brightness=

100
100
100
[root@vpcs nv_backlight]# echo 50 > brightness

By doing so, dmesg doesn't report anything, although the brightness is
actually changing.

To be honest, I don't understand what is going on here. Why are there
two backlight classes? Why does one work (but isn't registered to
Gnome), while the other doesn't work? I suppose that there is still
something wrong with the acpi video driver, as I have to append
"acpi_backlight=3Dvendor"?

Thanks so far. Hopefully you can make some sense out of this?

Best regards,
Karol Babioch


--------------enig6F4CA8C43934F47F9346824C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJP28GGAAoJEHSaZc1HnzIV0fwQAJUY3ycEHrh8mhHxs0+x7hjh
Fe5VxAfVKEBAYSCG5K5G6R183KaFeOqTs+0BSCZx+pmDrpS9hy05O58fIz+dRoUU
fOJX07NBP+pG3IHabzXHjoRpmXe9LBR8goiyWjzhmba2b7iEdzwEa0YkKAzgQeM/
L2O6TfqJG4oQGLMuPp44lWY1ZdTYYV1OXiSRuhzAt/46veL7tWFsVRA/ggWaTvg8
wv+s1pCH5v+qvwKrGF7l/NEknIimy68B7hp6suyPAvidZoTfZ3jehY62/PmoCdK6
fW0Ak6dP7iCbTqoUtCuSm9MlpjV2X0d10+SpMUh1a69na1J5HPgwJMioIHeYqNjC
uwJ/gyWVpeIT5GW61kiSB/MQbH5bCNrqxJQrhO28wYyPZAfCT1R3T5Ibg2WzJWOE
qEVMgMWWSkWb4mdEIGA0hYpjI2m9tueFUcjbfaMvloB4Ed6e7132vVYib5RjRNIM
2Ob8SDhwk4kZoWQg0BjN1rgx/zsnKku38J08FvMvxGDZacRYMe+xKx+KCbA1Kba3
Lqa3BZzmUXji+qYmjzxIw/COBU2C+Bbs58926quTTkg+E6vIJOiwHeoQL+vOUyUY
Q/QZ4w4OabKHXE9rNHVV55IWRU+j1n3lC/dRH4/mEWiAx/vrKPtzFKRS1p88ND9D
gb3Xzz3wx2HV/1oivuix
=aQJE
-----END PGP SIGNATURE-----

--------------enig6F4CA8C43934F47F9346824C--
