From: Len Brown <len.brown@intel.com>
Subject: [BKPATCH] ACPI for 2.4
Date: 20 Nov 2003 06:16:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1069326962.16410.49.camel@dhcppc4>
References: <1069189083.2970.540.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1069189083.2970.540.camel@dhcppc4>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.4.23

	A panic fix from Matt Wilcox via 2.6, and a build fix from me.
	(List of kernels built below.)
	Same caveat as before, I've not booted on x86_64 hardware.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.23-rc2/acpi-20031002-2.4.23-rc2.diff.gz

This will update the following files:

 arch/i386/kernel/acpi.c     |    7 +++----
 arch/i386/kernel/dmi_scan.c |    5 ++---
 arch/i386/kernel/pci-pc.c   |   12 ++----------
 arch/i386/kernel/setup.c    |    9 +++------
 arch/x86_64/kernel/acpi.c   |   19 ++-----------------
 arch/x86_64/kernel/e820.c   |    9 +++++----
 arch/x86_64/kernel/pci-pc.c |   10 +---------
 arch/x86_64/kernel/setup.c  |    2 +-
 drivers/acpi/pci_root.c     |    4 +---
 include/asm-i386/acpi.h     |    6 ++++--
 include/asm-x86_64/acpi.h   |    9 ++++-----
 11 files changed, 28 insertions(+), 64 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (03/11/20 1.1208)
   [ACPI] "pci=noacpi" -- 2.4.23 specific part of previous 2.4.22 fix

<len.brown@intel.com> (03/11/20 1.1063.44.53)
   [ACPI] "pci=noacpi" -- replace two sets of flags with one: acpi_noirq

<willy@debian.org> (03/11/19 1.1063.44.52)
   [PATCH] Fix panic-at-boot
   
   This fixes a panic-at-boot when ACPI Hotplug PCI is compiled in, but
   ACPI is disabled.  It just makes sure that the list is properly
   initialized statically instead of depending on runtime initialization
   that may or may not happen.


x86_64:
1. errs.ACPI.PCI.SMP.X86_LOCAL_APIC.X86_IO_APIC
2. errs.ACPI.PCI.X86_LOCAL_APIC.X86_IO_APIC
3. errs.ACPI.SMP.X86_LOCAL_APIC.X86_IO_APIC
4. errs.ACPI.X86_LOCAL_APIC.X86_IO_APIC
5. errs.DEBUG_KERNEL.ACPI.PCI.SMP.X86_LOCAL_APIC.X86_IO_APIC
6. errs.DEBUG_KERNEL.ACPI.PCI.X86_LOCAL_APIC.X86_IO_APIC
7. errs.DEBUG_KERNEL.ACPI.SMP.X86_LOCAL_APIC.X86_IO_APIC
8. errs.DEBUG_KERNEL.ACPI.X86_LOCAL_APIC.X86_IO_APIC
9. errs.DEBUG_KERNEL.PCI.SMP.X86_LOCAL_APIC.X86_IO_APIC
10. errs.DEBUG_KERNEL.PCI.X86_LOCAL_APIC.X86_IO_APIC
11. errs.DEBUG_KERNEL.SMP.X86_LOCAL_APIC.X86_IO_APIC
12. errs.DEBUG_KERNEL.X86_LOCAL_APIC.X86_IO_APIC
13. errs.PCI.SMP.X86_LOCAL_APIC.X86_IO_APIC
14. errs.PCI.X86_LOCAL_APIC.X86_IO_APIC
15. errs.SMP.X86_LOCAL_APIC.X86_IO_APIC
16. errs.X86_LOCAL_APIC.X86_IO_APIC
16 SUCCESS in 16 ATTEMPTS

i386:
1. errs.
2. errs.ACPI
3. errs.ACPI.PCI
4. errs.ACPI.PCI.SMP.X86_LOCAL_APIC.X86_IO_APIC
5. errs.ACPI.PCI.X86_LOCAL_APIC
6. errs.ACPI.PCI.X86_LOCAL_APIC.X86_IO_APIC
7. errs.ACPI.SMP.X86_LOCAL_APIC.X86_IO_APIC
8. errs.ACPI.X86_LOCAL_APIC
9. errs.ACPI.X86_LOCAL_APIC.X86_IO_APIC
10. errs.DEBUG_KERNEL
11. errs.DEBUG_KERNEL.ACPI
12. errs.DEBUG_KERNEL.ACPI.PCI
13. errs.DEBUG_KERNEL.ACPI.PCI.SMP.X86_LOCAL_APIC.X86_IO_APIC
14. errs.DEBUG_KERNEL.ACPI.PCI.X86_LOCAL_APIC
15. errs.DEBUG_KERNEL.ACPI.PCI.X86_LOCAL_APIC.X86_IO_APIC
16. errs.DEBUG_KERNEL.ACPI.SMP.X86_LOCAL_APIC.X86_IO_APIC
17. errs.DEBUG_KERNEL.ACPI.X86_LOCAL_APIC
18. errs.DEBUG_KERNEL.ACPI.X86_LOCAL_APIC.X86_IO_APIC
19. errs.DEBUG_KERNEL.PCI
20. errs.DEBUG_KERNEL.PCI.SMP.X86_LOCAL_APIC.X86_IO_APIC
21. errs.DEBUG_KERNEL.PCI.X86_LOCAL_APIC
22. errs.DEBUG_KERNEL.PCI.X86_LOCAL_APIC.X86_IO_APIC
23. errs.DEBUG_KERNEL.SMP.X86_LOCAL_APIC.X86_IO_APIC
24. errs.DEBUG_KERNEL.X86_LOCAL_APIC
25. errs.DEBUG_KERNEL.X86_LOCAL_APIC.X86_IO_APIC
26. errs.PCI
27. errs.PCI.SMP.X86_LOCAL_APIC.X86_IO_APIC
28. errs.PCI.X86_LOCAL_APIC
29. errs.PCI.X86_LOCAL_APIC.X86_IO_APIC
30. errs.SMP.X86_LOCAL_APIC.X86_IO_APIC
31. errs.X86_LOCAL_APIC
32. errs.X86_LOCAL_APIC.X86_IO_APIC
32 SUCCESS in 32 ATTEMPTS
