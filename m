From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI 2.5 interim patch released (20030730)
Date: Wed, 30 Jul 2003 11:00:11 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EEB7@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
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

I just posted an interim patch to http://sf.net/projects/acpi, but this
isn't going to kernel maintainers right away. The big thing is Andrew de
Quincey's irq stuff. *This needs a lot of testing*. Please try it on as
many systems as possible, both big and small.

I'm out on vacation until August 7. So in the meantime, give this code a
shot.

Regards -- Andy

-------------------------
This updates the following files:

 Documentation/kernel-parameters.txt |    8 +
 arch/i386/kernel/acpi/boot.c        |    3=20
 arch/i386/kernel/io_apic.c          |   16 ++-
 arch/i386/kernel/mpparse.c          |   16 ++-
 arch/x86_64/kernel/acpi/boot.c      |    3=20
 drivers/acpi/Kconfig                |    2=20
 drivers/acpi/pci_irq.c              |   15 +++
 drivers/acpi/pci_link.c             |  102 ++++++++++++++----------
 drivers/acpi/processor.c            |    1=20
 drivers/acpi/toshiba_acpi.c         |    3=20
 include/acpi/acpi_drivers.h         |    2=20
 include/asm-i386/io_apic.h          |    2=20
 12 files changed, 112 insertions(+), 61 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/29 1.1471)
   ACPI: If notify handler fails to be removed properly, don't just
return, but
   clean up other resources too (Daniele Bellucci)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/29 1.1470)
   ACPI: Allow irqs > 15 to use interrupt semantics other than PCI's
standard
   active-low, level trigger. Make other changes as required for this.
(Andrew de Quincey)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/28 1.1469)
   ACPI: toshiba_acpi update (John Belmonte)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/28 1.1468)
   ACPI: Fix Kconfig for ia64 and SN2 (Jesse Barnes)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/28 1.1467)
   ACPI: Better blacklist messages (Jasper Spaans)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/17 1.1463.2.1)
   ACPI: Fix intr on IA64 (davidm)

<lenb@dhcppc6.> (03/06/26 1.1310.64.2)
   update acpi=3D and acpismp=3D in kernel-parameters.txt




-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
