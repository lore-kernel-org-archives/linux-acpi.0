From: Sebastian Henschel <shensche-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: database for DSDTs @ acpi.sf.net
Date: Wed, 26 Feb 2003 09:38:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030226083759.GA935@enigma.daemon.sh>
References: <20030225155635.GA3899@enigma.daemon.sh> <3E5B4718.15266.1E8ED22F@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E5B4718.15266.1E8ED22F-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Russo, Richard" <russor-nDVljXDsN0s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi there...

Received at 2003-02-26 / 09:32 by Russo, Richard:
> In addition to those, it may be useful to have a configuration=20
> field... for some machines, the dsdt varies with how much ram and=20
> stuff is plugged in.

sorry, i forgot to mention a field which is currently called "features"
where you can put all the features which are not embraced by the list below.
did you mean something like that with "configuration"?

another thing to mention is perhaps the "supersede"-relation between two
DSDTs which you can also define with that application.

> On 25 Feb 2003 at 9:56, Sebastian Henschel wrote:
>=20
> > i am currently working on a little tool which lets all of you upload
> > fixed or for some reason modified DSDTs to acpi.sf.net. so that there
> > will be a kind of central place to download and compare DSDTs.
> >=20
> > the question now is, which information shall be stored to describe a
> > DSDT. these things were thought of a couple of months (or years?) ago:
> >=20
> > manufacturer    -- Mainboard-manufacturer
> > name            -- Mainboard-name
> > boardrev        -- Board-Revision
> > biosrev         -- BIOS-Revision
> > dual            -- SMP-System: y/n
> > dsdtvendor      -- "Vendor"-entry DSDT
> > dsdtproduct     -- "Product"-entry DSDT
> > dsdtrev         -- "Revision"-entry DSDT
> > s4bios_p        -- Supports S4BIOS
> > s2lat           -- S2-Wakeup-Latency
> > s3lat           -- S3-Wakeup-Latency
> > dutywidth       -- number of bits Throttling-Reg.
> > boot_p          -- Has BOOT-Table
> > apic_p          -- Has APIC-Table
> > original_p      -- Is original table from manufacturer
> >=20
> >=20
> > any more suggestions? or less?

bye,
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

iD8DBQE+XHznreHfL3pi+bQRAgTOAJ4ws3lGr1FRjFWpAo4pqsWE7VvM5wCgmZ6W
YJrHsSvAVVrht+aYwpY5OhY=
=ARk+
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--


-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
