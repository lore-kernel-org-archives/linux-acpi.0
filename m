From: Sebastian Henschel <shensche-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: database for DSDTs @ acpi.sf.net
Date: Tue, 25 Feb 2003 16:56:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030225155635.GA3899@enigma.daemon.sh>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi folks...

i am currently working on a little tool which lets all of you upload
fixed or for some reason modified DSDTs to acpi.sf.net. so that there
will be a kind of central place to download and compare DSDTs.

the question now is, which information shall be stored to describe a
DSDT. these things were thought of a couple of months (or years?) ago:

manufacturer    -- Mainboard-manufacturer
name            -- Mainboard-name
boardrev        -- Board-Revision
biosrev         -- BIOS-Revision
dual            -- SMP-System: y/n
dsdtvendor      -- "Vendor"-entry DSDT
dsdtproduct     -- "Product"-entry DSDT
dsdtrev         -- "Revision"-entry DSDT
s4bios_p        -- Supports S4BIOS
s2lat           -- S2-Wakeup-Latency
s3lat           -- S3-Wakeup-Latency
dutywidth       -- number of bits Throttling-Reg.
boot_p          -- Has BOOT-Table
apic_p          -- Has APIC-Table
original_p      -- Is original table from manufacturer


any more suggestions? or less?


cheers,
 sebastian
--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+W5IyreHfL3pi+bQRAh2UAJ4hd1oplrZiuuHuYtheppO2f3NV6wCghjh8
HtFGtRiEQdUEfAEIihioONo=
=jycC
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
