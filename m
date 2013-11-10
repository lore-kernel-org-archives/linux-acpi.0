From: al.stone@linaro.org
Subject: [PATCH 00/12] Hardware Reduced Mode cleanup for ACPI
Date: Sat,  9 Nov 2013 18:36:10 -0700
Message-ID: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35176 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576Ab3KJBgc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Nov 2013 20:36:32 -0500
Received: by mail-ie0-f175.google.com with SMTP id u16so2378812iet.20
        for <linux-acpi@vger.kernel.org>; Sat, 09 Nov 2013 17:36:31 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

From: Al Stone <ahs3@redhat.com>

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


Al Stone (12):
  ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to enable this ACPI mode
  ACPI: bus master reload not supported in reduced HW mode
  ACPI: clean up compiler warning about uninitialized field
  ACPI: HW reduced mode does not allow use of the FADT sci_interrupt
    field
  ACPI: ARM: exclude calls on ARM platforms, not include them on x86
  ACPI: ensure several FADT fields are only used in HW reduced mode
  ACPI: do not reserve memory regions for some FADT entries in HW
    reduced mode
  ACPI: in HW reduced mode, getting power latencies from FADT is not
    allowed
  ACPI: add clarifying comment about processor throttling in HW reduced
    mode
  ACPI: ACPI_FADT_C2_MP_SUPPORTED must be ignored in HW reduced mode
  ACPI: use of ACPI_FADT_32BIT_TIMER is not allowed in HW reduced mode
  ACPI: correct #ifdef so compilation without ACPI_REDUCED_HARDWARE
    works

 drivers/acpi/Kconfig                |  8 ++++++++
 drivers/acpi/acpica/utxface.c       |  3 ++-
 drivers/acpi/bus.c                  |  7 ++++++-
 drivers/acpi/osl.c                  | 28 ++++++++++++++++++++--------
 drivers/acpi/pci_link.c             | 14 ++++++++------
 drivers/acpi/processor_idle.c       | 19 ++++++++++++++-----
 drivers/acpi/processor_throttling.c |  8 ++++++++
 drivers/acpi/sleep.c                |  2 +-
 include/acpi/acpixf.h               |  6 ++++++
 include/acpi/platform/aclinux.h     |  4 ++++
 10 files changed, 77 insertions(+), 22 deletions(-)

-- 
1.8.3.1

