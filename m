From: Rob Hughes <rob-d2NfoQ5nhImakBO8gow8eQ@public.gmane.org>
Subject: acpi-20030328-2.4.21-pre6.diff on Toshiba hard locks
Date: 22 Apr 2003 22:38:33 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1051069113.26470.17.camel@kahuna-ws.robhughes.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jyyduI+VGZ/7WbJa1ngM"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-jyyduI+VGZ/7WbJa1ngM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Got the acpi-20030328 patch, applied it to a vanilla 2.4.21-pre6 and
compiled. Everything went cleanly, but I'm having a problem with the
sound hardware. I've tried both the oss and alsa intel sound modules,
and both produce hard locks on my Tos 5005-S504. I'm not able to break
to a debug prompt, and there is no oops. Dmesg produces no useful output
at boot, or at least, it's not any different in content from previous
patches where this configuration was working. Adding "pci=3Dnoacpi"
prevents the lock, but also keeps all sound modules from loading as the
hardware isn't initialized. Any hints on where I could/should start
looking? Other than the above, I'm not sure what other info to include
here, as I'm not entirely sure what's relevant.

Thanks,
Rob

--=-jyyduI+VGZ/7WbJa1ngM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Please use bofh key to send me personal data.

iD8DBQA+pgq4/9y+qWKu6HERAvfsAJ9jppWwmoDgbQRzczZg6YvJ5d2AAwCeJOFD
lyel03gLmv1gV9U0sE05LUM=
=xEXk
-----END PGP SIGNATURE-----

--=-jyyduI+VGZ/7WbJa1ngM--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
