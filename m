From: Scott James Remnant <scott-Umf49k1wg4FWk0Htik3J/w@public.gmane.org>
Subject: S3 resume problems on HP compaq nc4010
Date: Wed, 05 May 2004 18:23:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1083777804.4093.71.camel@descent.netsplit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bOSx8WSNKKauvi1NXwJO"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-bOSx8WSNKKauvi1NXwJO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi there,

This seemed like the most likely place to bring up my ACPI woes :)  I've
recently purchased an HP compaq nc4010 (it's mostly identical to the
nc4000) and haven't been able to get ACPI S3 (memory) suspend working.

I've tried a handful of different 2.6 kernels (including 2.6.6-rc3.mm1
for kicks) all of which exhibit the same behaviour.  On the whole, ACPI
works flawlessly and returns incredibly detailed information about every
part of the system.

I can enter S3 sleep by "echo -n 3>/proc/acpi/sleep" or
"echo mem>/sys/power/state" and the laptop switches to a console vt,
prints a few things which seem reasonable about going to sleep, and
powers down.

The wireless goes out, and the power light flashes in a manner I'd
expect from a sleeping laptop.

If I reactive the laptop (usually with the power button) the wireless
light comes back on, the power light goes green and the fan spins up.
But nothing else.

The screen remains black and un-backlit, the keyboard doesn't respond to
events (caps lock key doesn't light the light and typing "find /"
doesn't produce disk activity) and afaict the network card doesn't come
back either (I can't ping the machine from elsewhere).

So it almost entirely seems to be not waking up from sleep.

I've tried the various tricks outlined in the kernel documentation, an
all-modules kernel with no framebuffer booted with init=3D/bin/bash still
produces the same behaviour.

I'd like to get this working; are there any further tricks I could try?
If not, what's the best way to go about starting to debug *why* this
doesn't work?

Thanks,

Scott
(Please Cc: me, I'm not subscribed)
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?

--=-bOSx8WSNKKauvi1NXwJO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAmSMMIexP3IStZ2wRAsx8AKCkSVRc4Ha4W/Dnayq7AFVPI71r5QCeJQwK
LgAqLKXvo3xgRUD9IlMa7PA=
=+NYk
-----END PGP SIGNATURE-----

--=-bOSx8WSNKKauvi1NXwJO--



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
