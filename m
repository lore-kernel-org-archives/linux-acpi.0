From: Philipp Wollermann <phil_wo-hi6Y0CQ0nG0@public.gmane.org>
Subject: Battery Status on Acer Extensa 4101
Date: Tue, 22 Mar 2005 11:14:19 +0100
Message-ID: <200503221114.22874.phil_wo@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2500979.j3u5J3ZePC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
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

--nextPart2500979.j3u5J3ZePC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello again,

well - no one replied to my last mail, so I'll post again with the current=
=20
status. :-) The ACPI errors on boot continue to appear, however the only=20
thing which isn't working is to get the status of the battery. I can see it=
=20
in /proc/acpi/battery/BAT1/state but it says:

# cat /proc/acpi/battery/BAT1/state
present:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0yes
ERROR: Unable to read battery status

I tried to use the sbs-cm patches but they don't apply to my DSDT (actually=
,=20
the DSDT doesn't even compile with the IASL without any patches. :-(). I th=
en=20
tried to use the program smartbatt which only needs a small kernel patch=20
(acpi-ec-2.6.10.diff which applies cleanly to my 2.6.11.3) and then tries t=
o=20
access the battery using i2c. However there are no i2c busses detected!

bash-2.05b# ./smartbattery
Error: No i2c-bus specified!
Syntax: smartbatt I2CBUS
Error: No I2C busses found!
Be sure you have done 'modprobe i2c-dev'
and also modprobed your i2c bus drivers

I did load the modules of course. Does anyone have an idea how I could get =
the=20
state of my battery?

Philipp

--nextPart2500979.j3u5J3ZePC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCP+/+KB6x+iNJiAgRAkNyAJ9khHE5c66xQ92b3szLXf+2iced7wCcCDXX
s2NewschjEXopQfDi73fRL0=
=jf5z
-----END PGP SIGNATURE-----

--nextPart2500979.j3u5J3ZePC--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
