From: Pavel Machek <pavel@ucw.cz>
Subject: linux-next on thinkpad x60: full battery is indicated as battery
 error in mate
Date: Mon, 12 Mar 2018 20:47:15 +0100
Message-ID: <20180312194715.GA3992@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Did something change recently with battery reporting? Fully charged
battery shows as empty battery with red "x" in Mate desktop. After
reboot to recent mainline problem goes away. Tooltip says "battery
waiting to charge".

/proc/acpi/battery/BAT0/state looks ok:
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mW
remaining capacity:      41240 mWh
present voltage:         16495 mV

Linux amd 4.16.0-rc3-next-20180302 #30 SMP Fri Mar 2 10:28:44 CET 2018
i686 GNU/Linux
pavel@amd:~$ cat /sys/class/power_supply/BAT0/status
Not charging

Thinkpad X60.
=20
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqm2UMACgkQMOfwapXb+vLI5QCggmZ6bojYOy2AeGEKe3funTd9
QqYAnjhQi5aL5lVTbpPcrwNugaTbJaRB
=o6Y4
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
