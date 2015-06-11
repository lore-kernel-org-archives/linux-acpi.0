From: al.stone@linaro.org
Subject: [PATCH 0/3] Correct for ACPI 5.1->6.0 spec changes in MADT GICC entries
Date: Thu, 11 Jun 2015 13:45:08 -0600
Message-ID: <1434051911-14665-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36880 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbbFKTpZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2015 15:45:25 -0400
Received: by igbsb11 with SMTP id sb11so11639217igb.0
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2015 12:45:24 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org

From: Al Stone <al.stone@linaro.org>

In the ACPI 5.1 version of the spec, the struct for the GICC subtable (struct
acpi_madt_generic_interrupt) of the MADT is 76 bytes long; in ACPI 6.0, the
struct is 80 bytes long.  But, there is only one definition in ACPICA for
this struct -- and that is the 6.0 version.  Hence, when BAD_MADT_ENTRY()
compares the struct size to the length in the GICC subtable, it fails if 5.1
structs are in use, and there are systems in the wild that have them.

Note that this was found in linux-next and these patches apply against that
tree and the arm64 kernel tree; 4.1-rc7 does not appear to have this problem
since it has the 5.1 struct definition.

This patch set first adds macros for easily using the ACPI spec version, and
then adds the BAD_MADT_GICC_ENTRY() macro that uses them to check the GICC
subtable only, accounting for the difference in specification versions that
are possible.  The final patch adds in usage of the BAD_MADT_GICC_ENTRY
macro.  The BAD_MADT_ENTRY() will continue to work as is for all other
MADT subtables.

If these patches are acceptable, a cleanup effort will follow to simplify
the use of ACPI spec version numbers elsewhere.

These were tested and known to work on an APM Mustang system, where the
problem was originally uncovered.


Al Stone (3):
  ACPI: introduce macros for using the ACPI specification version
  ACPI: add BAD_MADT_GICC_ENTRY() macro
  ACPI / ARM64: use the new BAD_MADT_GICC_ENTRY macro

 arch/arm64/kernel/smp.c   |  2 +-
 drivers/irqchip/irq-gic.c |  2 +-
 include/linux/acpi.h      | 12 ++++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.1.0

