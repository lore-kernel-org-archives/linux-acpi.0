From: Mailhebuau Christophe <CMailhebuau-GyotsYYSwH0@public.gmane.org>
Subject: dell inspiron 2650
Date: 03 Feb 2003 19:04:31 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1044295471.2646.38.camel@justlinux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EUnLCkxyhAhMif3/t54+"
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


--=-EUnLCkxyhAhMif3/t54+
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

hi,

They are 3 week ago, i compiled a new kernel 2.4.20 with a patch and
acpi, run exelent. Battery an Ac_adapter run correctly.

But i've reinstalled my laptop, install 2.4.20 and patch but i d'ont
arrive configured correctly..

i've a battery, but not ac_adapter. when i install 2.4.19 i've
ac_adapter but not battery in /proc/acpi/battery

Can you help me  ? I dont understand the probl=E8me. I try with same patch
and kernel but is no good.......

Message error is :


Feb  3 18:41:51 justlinux kernel:  exfldio-0122 [30]
Ex_setup_region       : Field [ACPW] Base+Offset+Width 38+0+4 is beyond
end of region [GPIO] (length 3B)
Feb  3 18:41:51 justlinux kernel:  psparse-1103: *** Error: Method
execution failed [\_SB_.PCI0.LPCB.ACAD._PSR] (Node c12ec3c8),
AE_AML_REGION_LIMIT
Feb  3 18:41:51 justlinux kernel:  acpi_ac-0083 [14]
acpi_ac_get_state     : Error reading AC Adapter state
Feb  3 18:41:51 justlinux kernel: ACPI: Battery Slot [BAT1] (battery
present)
Feb  3 18:41:51 justlinux kernel: ACPI: Power Button (FF) [PWRF]
Feb  3 18:41:51 justlinux kernel: ACPI: Lid Switch [LID]
Feb  3 18:41:51 justlinux kernel: ACPI: Sleep Button (CM) [SLPB]
Feb  3 18:41:51 justlinux kernel: ACPI: Processor [CPU0] (supports C1
C2, 2 performance states, 8 throttling states)

--=20
Cordialement,
Christophe Mailhebuau    http://www.justlinux.org
                           http://www.abul.org
GPG: 1024D/75B07F8D: BD18 2D01 D954 A339 E35B 9EA1 4240 0410 75B0 7F8D

--=-EUnLCkxyhAhMif3/t54+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+Pq8vQkAEEHWwf40RAvdwAJ9+qtGxHqkDlF7W4AMQBTK+ObON6wCfTB8y
c7cLa67p/ocoFtuiaA57FiM=
=/fUm
-----END PGP SIGNATURE-----

--=-EUnLCkxyhAhMif3/t54+--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
