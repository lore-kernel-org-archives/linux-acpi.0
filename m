From: Nico Schottelius <nico-linux-acpi-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org>
Subject: Sleep states fail, console broken
Date: Tue, 20 Sep 2005 23:19:59 +0200
Message-ID: <20050920211959.GN1463@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pjk796cY0SfIo9Z2"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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


--Pjk796cY0SfIo9Z2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I got a compaq N400C, I want to use suspend to RAM.

I do 'echo -n mem > /sys/power/state'. After I 'bootup' the system
again, the console I used echo on is logged out.
And the console is initialized differently: Before it used the whole
screen, now it uses only parts of it:

-------------------
| BEFOREBEFOREBEFO|
| BEFOREBEFOREBEFO|
| BEFOREBEFOREBEFO|
| BEFOREBEFOREBEFO|
-------------------

-------------------
|                 |
|      AfTER      |
|      AFTER      |
|                 |
-------------------

For a small time (1-2 seconds) the console looks 'funny':
There are coloured rectancles (looks like ascii-art somehow ;-), but
it is recorved soon.

As far as I remember, using /proc/acpi/sleep (or whatever the correct path =
was),
failed partly: S1,S4,S5 returns like invalid values, S2/S3 work partly.

But as far as I understood, using /proc/acpi/sleep is deprecated anyway?

Sincerly,

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--Pjk796cY0SfIo9Z2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQzB8/7OTBMvCUbrlAQJjLw/9E3McMdWIC2FKcZhmYZtBC5SyY8xJn+ug
foxY9D9DYOuuNMLvQ76W5n5V9X54NTLHMZMBZ5nudmmZYaIdalAMoY4RBzrg6x8M
FYmIYPtRSErMSHnanj0vgrQHxWbuFpcoUzD5qtatPBHkHhdKNTP/AeeQgeh21KVH
Oy+qsReYHTBRQxeDfs26RJxnpOnVAbhXAm9QIEG4ze+V99kP6HZvJdReozvEm034
O0zob2S3d56kqXynwWpnzgBLoN/llHiliiTHwih74RJKaS/LMUBgsDso+7CMXe67
v/KzPgaimO6Ol44AURWik9/rfc3AqjL73hvyVAs4pBnPAi8zqc8TaO4cpN758MiN
Eg7HWD9qujGuy1lK2HTwDX36+IDdkxQXTGwtNtYL00gpK3ak5pN81CL/uc3YjNfx
BD3v5/meS9jApFWNB2BPCjJ0q5gDOSnRgqbPl9HyCbC1Z8o2k4LQpCjmgGgB1yFb
IPMRjfv573tZz4mv1ZwsMRjqgM/rpTyZRg7scdqdkg1dV5URUznGbwmSdPrlDvTh
2xq55abeN7FMqNGjz6Puq8Ale+1VW3mBXE2IHUpgbivf7xAQQZeFyJJdukbmgNCi
4B8dPKEm7JYfuBe1CQrLdlX7BDwAGmBWEaJYDJc3jOLgvHMoJBxzIs+MZ7XwfXbq
5TGO9S+cJ/M=
=gNlW
-----END PGP SIGNATURE-----

--Pjk796cY0SfIo9Z2--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
