From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI updates
Date: Tue, 12 Aug 2003 14:55:21 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC3A@hdsmsx402.hd.intel.com>
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
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Andy, please do a=20

	bk pull http://linux-acpi.bkbits.net/to-andy-2.6

from http://linux-acpi.bkbits.net/linux-acpi

This updates the 2.6-test3 tree to include the recent changes you pulled
from me into the 2.4 acpi tree -- see cset comments below.

Thanks,
-Len


This will update the following files:

 arch/i386/kernel/acpi/acpitable.c         |  553 ------------------
 arch/i386/kernel/acpi/acpitable.h         |  260 --------
 Documentation/kbuild/kconfig-language.txt |    4=20
 Documentation/kernel-parameters.txt       |   13=20
 arch/i386/Kconfig                         |    7=20
 arch/i386/kernel/Makefile                 |    2=20
 arch/i386/kernel/acpi/Makefile            |    1=20
 arch/i386/kernel/acpi/boot.c              |   53 +
 arch/i386/kernel/cpu/intel.c              |   12=20
 arch/i386/kernel/dmi_scan.c               |  268 ++++++++
 arch/i386/kernel/mpparse.c                |   10=20
 arch/i386/kernel/setup.c                  |   39 -
 arch/i386/kernel/smpboot.c                |    2=20
 arch/i386/pci/acpi.c                      |   10=20
 drivers/Makefile                          |    2=20
 drivers/acpi/Kconfig                      |  110 ++-
 drivers/acpi/Makefile                     |    5=20
 drivers/acpi/bus.c                        |    2=20
 drivers/acpi/tables.c                     |   21=20
 include/asm-i386/acpi.h                   |   26=20
 include/linux/acpi.h                      |    6=20
 init/do_mounts.c                          |   10=20
 22 files changed, 477 insertions(+), 939 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/12 1.1127)
   ACPI: merge andy-2.6 into lenb-2.6

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/10 1.1046.1.429)
   ACPI -- CONFIG_ACPI_HT -- this delta should have been in previous
cset

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/10 1.1046.1.428)
   ACPI -- CONFIG_ACPI_HT

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/10 1.1046.1.427)
   ACPI: this delta should have been included in previous cset

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/09 1.1046.1.426)
   ACPI from 2.4:
   build: add ACPI_HT, delete ACPI_HT_ONLY
   boot: add acpi=3D{force, off, ht}; delete "noht", "acpismp=3D"
   add DMI blacklist from UnitedLinux


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
