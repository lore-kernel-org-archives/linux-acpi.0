From: Al Stone <al.stone@linaro.org>
Subject: [PATCH v3 2/3] ACPI / ARM64: add BAD_MADT_GICC_ENTRY() macro
Date: Thu,  2 Jul 2015 17:48:35 -0600
Message-ID: <1435880916-2153-3-git-send-email-al.stone@linaro.org>
References: <1435880916-2153-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34861 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbbGBXsw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2015 19:48:52 -0400
Received: by iecuq6 with SMTP id uq6so67055064iec.2
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jul 2015 16:48:51 -0700 (PDT)
In-Reply-To: <1435880916-2153-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org

The BAD_MADT_ENTRY() macro is designed to work for all of the subtables
of the MADT.  In the ACPI 5.1 version of the spec, the struct for the
GICC subtable (struct acpi_madt_generic_interrupt) is 76 bytes long; in
ACPI 6.0, the struct is 80 bytes long.  But, there is only one definition
in ACPICA for this struct -- and that is the 6.0 version.  Hence, when
BAD_MADT_ENTRY() compares the struct size to the length in the GICC
subtable, it fails if 5.1 structs are in use, and there are systems in
the wild that have them.

This patch adds the BAD_MADT_GICC_ENTRY() that checks the GICC subtable
only, accounting for the difference in specification versions that are
possible.  The BAD_MADT_ENTRY() will continue to work as is for all other
MADT subtables.

This code is being added to an arm64 header file since that is currently
the only architecture using the GICC subtable of the MADT.  As a GIC is
specific to ARM, it is also unlikely the subtable will be used elsewhere.

Fixes: aeb823bbacc2 (ACPICA: ACPI 6.0: Add changes for FADT table.)
Signed-off-by: Al Stone <al.stone@linaro.org>
---
 arch/arm64/include/asm/acpi.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 39248d3..a3c26a4 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -19,6 +19,17 @@
 #include <asm/psci.h>
 #include <asm/smp_plat.h>
 
+/* Macros for consistency checks of the GICC subtable of MADT */
+#define ACPI_MADT_GICC_51_LENGTH       76
+#define ACPI_MADT_GICC_60_LENGTH       80
+
+#define BAD_MADT_GICC_ENTRY(entry, end) (                                   \
+		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
+		((ACPI_FADT_SPEC_VERSION == ACPI_FADT_SPEC_VERSION_51) &&   \
+		 (entry->header.length != ACPI_MADT_GICC_51_LENGTH))    ||  \
+		((ACPI_FADT_SPEC_VERSION == ACPI_FADT_SPEC_VERSION_60) &&   \
+		 (entry->header.length != ACPI_MADT_GICC_60_LENGTH)))
+
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
 /* ACPI table mapping after acpi_gbl_permanent_mmap is set */
-- 
2.4.3

