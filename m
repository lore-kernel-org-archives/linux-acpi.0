From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI update
Date: Thu, 19 Jun 2003 18:29:24 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2FC@orsmsx401.jf.intel.com>
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
To: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-acpi.bkbits.net/linux-acpi

Notable improvements are the addition of a special-features driver for
ASUS laptops, as well as the re-introduction of acpitable.c. I must
admit this certainly cuts down on a lot of #ifdefs to have the HT_ONLY
option in its own file. A horde of other small fixes, too.

This will update the following files:

 arch/i386/kernel/acpi/Makefile     |    1=20
 arch/i386/kernel/acpi/acpitable.c  |  553 ++++++++++++++
 arch/i386/kernel/acpi/acpitable.h  |  260 ++++++
 arch/i386/kernel/setup.c           |   13=20
 drivers/acpi/Kconfig               |   31=20
 drivers/acpi/Makefile              |    1=20
 drivers/acpi/asus_acpi.c           |  951 +++++++++++++++++++++++++
 drivers/acpi/dispatcher/dsmthdat.c |   25=20
 drivers/acpi/events/evgpe.c        |    8=20
 drivers/acpi/events/evgpeblk.c     |   29=20
 drivers/acpi/executer/exoparg1.c   |   77 +-
 drivers/acpi/executer/exstore.c    |    4=20
 drivers/acpi/executer/exsystem.c   |    4=20
 drivers/acpi/executer/exutils.c    |    5=20
 drivers/acpi/hardware/hwregs.c     |   47 -
 drivers/acpi/hardware/hwsleep.c    |    4=20
 drivers/acpi/tables/tbconvrt.c     |   26=20
 drivers/acpi/utilities/utmisc.c    |    2=20
 drivers/pci/hotplug/acpiphp.h      |   16=20
 drivers/pci/hotplug/acpiphp_core.c |   15=20
 drivers/pci/hotplug/acpiphp_glue.c |   50 -
 drivers/pci/hotplug/acpiphp_pci.c  |    4=20
 drivers/pci/hotplug/acpiphp_res.c  |    4=20
 include/acpi/acconfig.h            |    2=20
 include/acpi/acglobal.h            |    1=20
 include/acpi/achware.h             |    2=20
 include/acpi/acpiosxf.h            |    8=20
 include/acpi/actypes.h             |   21=20
 include/asm-i386/acpi.h            |    5=20
 include/linux/acpi.h               |    4=20
 30 files changed, 1999 insertions(+), 174 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/19 1.1332.2.2)
   ACPI: Interpreter update to 20030619
   - Fix To/FromBCD, eliminating the need for an arch-specific #define
   - Do not acquire a semaphore in the S5 shutdown path
   - Fix ex_digits_needed for 0 (Takayoshi Kochi)
   - Fix sleep/stall code reversal (Andi Kleen)
   - Revert a change having to do with control method calling semantics

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/17 1.1305.5.6)
   ACPI: acpiphp update (Takayoshi Kochi)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/13 1.1305.5.5)
   ACPI: Export acpi_disabled for sonypi (Stelian Pop)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/13 1.1305.5.4)
   ACPI: Mention acpismp=3Dforce in config help

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/13 1.1305.5.3)
   ACPI: Re-add acpitable.c and acpismp=3Dforce. This improves backwards
compatibility
   and also cleans up the code to a significant degree.

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/13 1.1305.5.2)
   ACPI: Add ASUS Value-add driver (Karol Kozimor and Julien Lerouge)


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
