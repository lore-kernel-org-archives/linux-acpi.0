From: Federico Di Gregorio <fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: 19 Sep 2002 11:47:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1032428873.6326.5.camel@momo>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-OJfDBnngoK4o7Z05qKsj"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE80-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-OJfDBnngoK4o7Z05qKsj
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Il gio, 2002-09-19 alle 08:27, Grover, Andrew ha scritto:
> I wanted to make a special request for testing of the 2.4 patch (or shoul=
d I
> say, MEGA-patch).
>=20
> Marcelo has asked for widespread testing of it, in anticipation of likely
> 2.4 mainline inclusion. I will be posting a call for testing to linux-ker=
nel
> soon, but am posting this here first to hopefully weed out any really bad
> bugs that may have crept in.
>=20
> The main issues of importance are:
>=20
> - DOES IT BOOT?

yep. here are the first lines, to identify my laptop model:

ACPI: RSDP (v000 ASUS                       ) @ 0x000f71d0
ACPI: RSDT (v001 ASUS   S1300A   12336.12337) @ 0x0f7e9000
ACPI: FADT (v001 ASUS   S1300A   12336.12337) @ 0x0f7e9080
ACPI: BOOT (v001 ASUS   S1300A   12336.12337) @ 0x0f7e9040
ACPI: DSDT (v001   ASUS S1300A   00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist

> - DOES IT ASSIGN INTERRUPTS PROPERLY?
>=20
> Failure to do so either indicates a bug that we need to fix (fast) or a
> system that should go on the blacklist. dmesg now includes the DSDT
> signature to aid blacklisting.

everything seems to work fine. how can i say if an interrupt has been
wrongly assigned? anyway the only problem has always been there but i
don't know if it is about irq:

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
pci_bind-0194 [05] acpi_pci_bind         : Device 00:00:1f.03 not
present in PCI namespace
pci_bind-0194 [05] acpi_pci_bind         : Device 00:00:1f.06 not
present in PCI namespace
ACPI: Power Resource [PFAN] (off)

and later:

acpi_processor-2115 [07] acpi_processor_get_inf: Invalid PBLK length [5]

--=20
Federico Di Gregorio
Debian GNU/Linux Developer & Italian Press Contact        fog-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
INIT.D Developer                                           fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org
  Spesso crescere ed andare a vivere da soli =E8 l'unico modo di restare
   bambini.                                             -- Alice Fontana

--=-OJfDBnngoK4o7Z05qKsj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9iZ1IvcCgrgZGjesRArwPAJsFkUQL1S6wv8nOZo7PwHQOJFsx+gCgkl8c
HybWEmxEsBMopnQs0YPbMuw=
=A8I7
-----END PGP SIGNATURE-----

--=-OJfDBnngoK4o7Z05qKsj--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
