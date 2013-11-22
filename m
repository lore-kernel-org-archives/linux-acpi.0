From: al.stone@linaro.org
Subject: [PATCH v2 0/6] Hardware Reduced Mode cleanup for ACPI
Date: Thu, 21 Nov 2013 17:41:49 -0700
Message-ID: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:39849 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab3KVAmJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2013 19:42:09 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so511749pde.0
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2013 16:42:09 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>

From: Al Stone <al.stone@linaro.org>

This series of patches starts with Hanjun's patch to create a kernel
config item for CONFIG_ACPI_REDUCED_HARDWARE [0].  Building on that, I
then reviewed all of the code that touched any of several fields in the
FADT that the OSPM is supposed to ignore when ACPI is in Hardware Reduced
mode [1].  Any time there was a use of one of the fields to be ignored,
I evaluated whether or not the code was implementing Hardware Reduced
mode correctly.  Similarly, for each the flags in the FADT flags field
that are to be ignored in Hardware Reduced mode, the kernel code was again
scanned for proper usage.  The remainder of the patches are to fix all of
the situations I could find where the kernel would not behave correctly
in this ACPI mode.

These seem to work just fine on the RTSM model for ARMv7, both with and
without ACPI enabled, and with and without ACPI_REDUCED_HARDWARE enabled;
similarly for the FVP model for ARMv8.  The patches for ACPI on ARM
hardware will be coming later but they presume that reduced HW mode is
functioning correctly.  In the meantime, there's no way I can think of
to test all possible scenarios so feedback would be greatly appreciated.


[0] List at https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI/AcpiReducedHw#Section_5:_ACPI_Software_Programming_Model
[1] Please see the ACPI Specification v5.0 for details on Hardware Reduced
    mode.


Changes for v2:
   -- Remove patch that was outside of reduced HW mode changes
   -- Simplify CONFIG_ACPI_REDUCED_HARDWARE in Kconfig
   -- Simplify use of CONFIG_ACPI_REDUCED_HARDWARE in #ifdefs
   -- Ensure changelogs are present
   -- Combine and simplify previous patches 8 & 10


Al Stone (6):
  ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to enable this ACPI mode
  ACPI: bus master reload not supported in reduced HW mode
  ACPI: HW reduced mode does not allow use of the FADT sci_interrupt
    field
  ACPI: ARM: exclude DMI calls
  ACPI: do not reserve memory regions for some FADT entries in HW
    reduced mode
  ACPI: in HW reduced mode, using FADT PM information is not allowed.

 drivers/acpi/Kconfig            |  8 ++++++++
 drivers/acpi/bus.c              |  3 ++-
 drivers/acpi/osl.c              | 24 ++++++++++++------------
 drivers/acpi/pci_link.c         |  2 ++
 drivers/acpi/processor_idle.c   | 16 ++++++++++++++--
 include/acpi/platform/aclinux.h |  4 ++++
 include/linux/dmi.h             |  2 +-
 7 files changed, 43 insertions(+), 16 deletions(-)

-- 
1.8.3.1

