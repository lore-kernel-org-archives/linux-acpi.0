From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Please Remove ASUS A7V from blacklist in dmi-scan.c
Date: Sun, 24 Aug 2003 15:37:11 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCD3@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: eric.valette-GANU6spQydw@public.gmane.org
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks for testing the A7V Eric,

Can you describe further "halted your machine without any form of sync"?
halt and sync should still work with acpi=3Dht, but the soft power off
will not work
Unless an non-acpi mechanism is enabled.  Was it that the change
In poweroff behaviour tricked you and you pulled power manually?

In any case, sounds like your box shouldn't be blacklisted by default.

Please send the output from dmidecide, available in /usr/sbin/, or here:

http://www.nongnu.org/dmidecode/ and I'll take care of it.

Thanks,
-Len


> -----Original Message-----
> From: Eric Valette [mailto:eric.valette-GANU6spQydw@public.gmane.org]=20
> Sent: Sunday, August 24, 2003 6:54 AM
> To: Brown, Len
> Cc: Grover, Andrew; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Please Remove ASUS A7V from blacklist in dmi-scan.c
>=20
>=20
>   I own a A7V that has been blacklisted by last patch while I=20
> have been
> using ACPI (mainly for software power off via power button on this
> machine :-)). Using ht only, I lost silently this feature and=20
> halted my
> machine without any form of sync which is rather bad... Seeing the
> message concerning blacklisted machine, I tried with=20
> acpi=3Dforce at boot
> time and of course booted sucessfully. Here is the dmesg=20
> attached. May I
> have a few words about the reason why this machine has been=20
> blacklisted?
>=20
> NB : when you have young childs or a wife that does not want to hear=20
> about linux, power off button software controlled is indeed a great=20
> faeture :-)
>=20
> --=20
>      __
>     /  `                   	Eric Valette
>    /--   __  o _.          	6 rue Paul Le Flem
> (___, / (_(_(__         	35740 Pace
>=20
> Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
> E-mail: eric.valette-GANU6spQydw@public.gmane.org
>=20
>=20


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
