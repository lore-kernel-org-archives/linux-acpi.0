From: =?iso-8859-2?Q?Zden=ECk?= OGAR =?iso-8859-2?Q?Skal=E1k?=
	<skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>
Subject: Re: acpi=off & /proc entries
Date: Fri, 16 May 2003 11:19:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EC4AD1D.F560C85@monetplus.cz>
References: <3ACA40606221794F80A5670F0AF15F8427230B@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------FD2A4F69B342105CDC83862D"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: Grover Andrew <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------FD2A4F69B342105CDC83862D
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable


Hi,

	here is small simple patch :-) It's against acpi-20030512-2.4.21-rc2.

	It prevents ACPI modules (button, ...) to register itself & create /proc=

entries, when acpi is disabled through acpi=3Doff. =


	Because bus.c uses acpi_disabled variable set by acpi=3Doff, it doesn't =
register
/proc/acpi directory & module later registers (in his __init) it's /proc =
entry
just in /proc (/proc/button, ...).

	This simply returns -ENODEV if acpi_disabled & when module tries to regi=
ster
via acpi_bus_register_driver (in bus.c) & as a consequence, module remove=
s his
/proc entry :-)

	Bye
		Zdenek OGAR Skalak
-- =

Ing. Zden=ECk OGAR Skal=E1k
Monet+ a.s.
Z=E1meck=E1 365
763 14 Zl=EDn - =A9t=EDpa, CZ
Tel: +420 / 577 110 411,  Fax: +420 / 577 914 557
--------------FD2A4F69B342105CDC83862D
Content-Type: text/plain; charset=iso-8859-2;
 name="acpi_off.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi_off.diff"

diff -r -c old/drivers/acpi/bus.c new/drivers/acpi/bus.c
*** old/drivers/acpi/bus.c	Fri May 16 09:55:19 2003
--- new/drivers/acpi/bus.c	Fri May 16 09:58:01 2003
***************
*** 1249,1254 ****
--- 1249,1257 ----
  	if (!driver)
  		return_VALUE(-EINVAL);
  
+ 	if (acpi_disabled)
+ 		return_VALUE(-ENODEV);
+ 
  	down(&acpi_bus_drivers_lock);
  	list_add_tail(&driver->node, &acpi_bus_drivers);
  	up(&acpi_bus_drivers_lock);

--------------FD2A4F69B342105CDC83862D--



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
