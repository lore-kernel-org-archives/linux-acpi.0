From: Marc-Christian Petersen <m.c.p-hi6Y0CQ0nG0@public.gmane.org>
Subject: ACPI patch 2002-01-23
Date: Fri, 24 Jan 2003 09:49:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301240949.16462.m.c.p@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

Hi all,

how should this ever compile? :)

acpi_ksyms.c:86: `acpi_enter_sleep_state_s4bios' undeclared here (not in =
a=20
function)
acpi_ksyms.c:86: initializer element is not constant
acpi_ksyms.c:86: (near initialization for=20
`__ksymtab_acpi_enter_sleep_state_s4bios.value')
make[3]: *** [acpi_ksyms.o] Error 1


root@codeman:[/usr/src/ACPI] # grep "sleep_state_s4bios" *
acpi-20030123-2.4.21-pre3.diff:+               =20
acpi_enter_sleep_state_s4bios();
acpi-20030123-2.4.21-pre3.diff:+EXPORT_SYMBOL(acpi_enter_sleep_state_s4bi=
os);

ciao, Marc


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
