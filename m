From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [patch] 2.4.x ACPI updates
Date: Thu, 21 Aug 2003 22:49:05 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCB1@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
Cc: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "J.A. Magallon" <jamagallon-cer70A47DaU@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Marcelo,

Here's an update to the ACPI back port to the 2.4.22 tree.

The BK tree and the patch have been replaced with the new version:
http://linux-acpi.bkbits.net/linux-acpi-2.4.22
https://sourceforge.net/project/showfiles.php?group_id=36832
This incorporates feedback from Andy Grover and Patrick Mochel.
It fixed some config dependencies, and followed Patrick's lead
on #ifdef hygiene to address the build issue.

Thanks,
-Len

This will update the following files:

 Documentation/Configure.help        |   25 +-
 Documentation/kernel-parameters.txt |    8 
 Makefile                            |    2 
 arch/i386/kernel/acpi.c             |   66 +++++--
 arch/i386/kernel/acpitable.c        |   10 -
 arch/i386/kernel/acpitable.h        |    4 
 arch/i386/kernel/dmi_scan.c         |  213 +++++++++++++++++++++++-
 arch/i386/kernel/io_apic.c          |   14 +
 arch/i386/kernel/mpparse.c          |   23 +-
 arch/i386/kernel/setup.c            |   61 ++++--
 arch/i386/kernel/smpboot.c          |    2 
 drivers/Makefile                    |    2 
 drivers/acpi/Config.in              |    2 
 drivers/acpi/Makefile               |    7 
 drivers/acpi/bus.c                  |    2 
 drivers/acpi/executer/exutils.c     |    2 
 drivers/acpi/hardware/hwregs.c      |   21 +-
 drivers/acpi/osl.c                  |   27 ++-
 drivers/acpi/pci_irq.c              |   15 +
 drivers/acpi/pci_link.c             |  100 +++++++----
 drivers/acpi/processor.c            |    1 
 drivers/acpi/tables.c               |  120 +++++++------
 drivers/acpi/tables/tbconvrt.c      |    6 
 drivers/acpi/tables/tbget.c         |    4 
 drivers/acpi/tables/tbinstal.c      |   42 +++-
 drivers/acpi/tables/tbrsdt.c        |    2 
 drivers/acpi/tables/tbxfroot.c      |    6 
 drivers/acpi/toshiba_acpi.c         |    3 
 drivers/acpi/utilities/utglobal.c   |    6 
 drivers/hotplug/Config.in           |    2 
 include/acpi/acconfig.h             |    2 
 include/acpi/acpi_drivers.h         |    2 
 include/acpi/platform/acenv.h       |    6 
 include/asm-i386/acpi.h             |   44 ++--
 include/asm-i386/io_apic.h          |    2 
 include/asm-i386/mpspec.h           |    4 
 include/linux/acpi.h                |   21 +-
 37 files changed, 625 insertions(+), 254 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/21 1.1100)
   acpi-build.patch

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/21 1.1099)
   acpi-20030813-2.4.22-rc2.diff

> -----Original Message-----
> From: Brown, Len 
> Sent: Tuesday, August 19, 2003 8:01 PM
> To: Jeff Garzik; Grover, Andrew; 'Marcelo Tosatti'
> Cc: J.A. Magallon; Linux Kernel Mailing List; Alan Cox; 
> acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
> Subject: RE: [patch] 2.4.x ACPI updates
> 
> 
> Andy/Jeff/Marcelo,
> 
> At Jeff's request, I've back ported ACPICA 20030813 from 
> http://linux-acpi.bkbits.net/linux-acpi-2.4 into a new tree 
> for 2.4.22:
> http://linux-acpi.bkbits.net/linux-acpi-2.4.22
> 
> I've restored acpitable.[ch], which was deleted too late for 
> this release cycle; and will live on until 2.4.23 -- as well 
> as restored CONFIG_ACPI_HT_ONLY under CONFIG_ACPI; restored 
> the 8-bit characters that got expanded to 16-bits in a 
> previous merge; and deleted some dmesg verbiage that Jeff 
> didn't think was appropriate for the baseline kernel.
> 
> I exported this a patch and then imported onto a clone of 
> Marcelo's tree, so it appears as a single cset where the 
> changes that got un-done never happened.  I've done some 
> sanity tests on it, and will test it some more tomorrow.  
> Take a look at it and let me know if I missed anything.  When 
> Andy is happy with it I'll leave it to him to re-issue a pull 
> request from Marcelo.
> 
> > This includes a rework of the ACPI config and cmdline 
> options. It now
> > supports DMI-based blacklisting, and cmdline options have been
> > simplified to "acpi=off", "acpi=ht" (use ACPI for CPU enum only) and
> > "acpi=force" (to override the blacklist.)
> 
> > It also includes some PCI IRQ routing changes, that seem to 
> help some
> > people's systems work better.
> 
> In addition, the "noapic" flag now works properly when full 
> ACPI is enabled.
> 
> Thanks,
> -Len
> 
> Ps. The plain patch on top of Marcelo's current tree is 
> available here:
> https://sourceforge.net/project/showfiles.php?group_id=36832
> 
> ----------
> This will update the following files:
> 
>  Documentation/kernel-parameters.txt |    8 
>  Makefile                            |    2 
>  arch/i386/kernel/acpi.c             |   53 ++++-
>  arch/i386/kernel/acpitable.c        |   10 
>  arch/i386/kernel/acpitable.h        |    4 
>  arch/i386/kernel/dmi_scan.c         |  251 +++++++++++++++++++++++-
>  arch/i386/kernel/io_apic.c          |   14 -
>  arch/i386/kernel/mpparse.c          |   34 ++-
>  arch/i386/kernel/setup.c            |   54 ++---
>  arch/i386/kernel/smpboot.c          |    2 
>  drivers/Makefile                    |    2 
>  drivers/acpi/Config.in              |    2 
>  drivers/acpi/Makefile               |    7 
>  drivers/acpi/bus.c                  |    2 
>  drivers/acpi/executer/exutils.c     |    2 
>  drivers/acpi/hardware/hwregs.c      |   21 +-
>  drivers/acpi/osl.c                  |   27 +-
>  drivers/acpi/pci_irq.c              |   15 +
>  drivers/acpi/pci_link.c             |  100 ++++++---
>  drivers/acpi/processor.c            |    1 
>  drivers/acpi/tables.c               |  120 ++++++-----
>  drivers/acpi/tables/tbconvrt.c      |    6 
>  drivers/acpi/tables/tbget.c         |    4 
>  drivers/acpi/tables/tbinstal.c      |   42 ++--
>  drivers/acpi/tables/tbrsdt.c        |    2 
>  drivers/acpi/tables/tbxfroot.c      |    6 
>  drivers/acpi/toshiba_acpi.c         |    3 
>  drivers/acpi/utilities/utglobal.c   |    6 
>  include/acpi/acconfig.h             |    2 
>  include/acpi/acpi_drivers.h         |    2 
>  include/acpi/platform/acenv.h       |    6 
>  include/asm-i386/io_apic.h          |    2 
>  32 files changed, 598 insertions(+), 214 deletions(-)
> 
> through these ChangeSets:
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/19 1.1097)
>    patch_2.4.22-rc2_to_acpi-2.4-20030813
> 
> 
> 
