From: Kenneth Johansson <ken-+AkyqHw8l9jYtjvyW6yDsg@public.gmane.org>
Subject: ACPI S1 problem
Date: Sun, 03 Oct 2004 16:22:59 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1096813379.2753.9.camel@tiger>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PIfYRdRp6WsrgT1d0sB6"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-PIfYRdRp6WsrgT1d0sB6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I wanted to have standby mode working on my desktop so I do not have to
listen to the fan all the time and also have a quick start.=20

As I understand it I should be using S3 mode for this but
cat /proc/acpi/sleep only reports support for "S0 S1 S4 S5" so I tried
S1. Dose S1 turn of the hard disks and fan ?

For some reason  mysql do not want to play=20
--
kernel: Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
kernel:  stopping tasks failed (1 tasks remaining)
kernel: Restarting tasks...<6> Strange, mysqld not stopped
--

After stopping mysql by hand I still have problem.=20
--
kernel: Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D|
kernel: NVRM: ACPI: device not initialized!
kernel: Could not suspend device 0000:01:00.0: error -1
kernel: Restarting tasks... done
--
That device is the graphics card.=20
0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown device =
0045 (rev a1)

I have seen that others have this working with nvidia card why dose it not =
work for me?

What dose the -1 error code mean?


--=-PIfYRdRp6WsrgT1d0sB6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBYAtBmDGOmJIy9x8RAt40AJ9NRCZJ+3KxN9hPnG+BaLukBEhoNwCfW9so
qS6ITy6DxYJ+4mK7dwCGzGw=
=9wA2
-----END PGP SIGNATURE-----

--=-PIfYRdRp6WsrgT1d0sB6--



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
