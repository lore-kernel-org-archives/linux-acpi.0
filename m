From: akpm@linux-foundation.org
Subject: [patch 1/3] acpi: fix ACPI_FADT_S4_RTC_WAKE comment
Date: Mon, 01 Dec 2008 14:12:49 -0800
Message-ID: <200812012212.mB1MCoWC008285@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58573 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751352AbYLAWNE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 17:13:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, dbrownell@users.sourceforge.net

From: David Brownell <dbrownell@users.sourceforge.net>

Make the comment for ACPI_FADT_S4_RTC_WAKE match the ACPI spec;
that bit has nothing to do with status bits.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/acpi/actbl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN include/acpi/actbl.h~acpi-fix-acpi_fadt_s4_rtc_wake-comment include/acpi/actbl.h
--- a/include/acpi/actbl.h~acpi-fix-acpi_fadt_s4_rtc_wake-comment
+++ a/include/acpi/actbl.h
@@ -245,7 +245,7 @@ struct acpi_table_fadt {
 #define ACPI_FADT_POWER_BUTTON      (1<<4)	/* 04: Power button is handled as a generic feature */
 #define ACPI_FADT_SLEEP_BUTTON      (1<<5)	/* 05: Sleep button is handled as a generic feature, or  not present */
 #define ACPI_FADT_FIXED_RTC         (1<<6)	/* 06: RTC wakeup stat not in fixed register space */
-#define ACPI_FADT_S4_RTC_WAKE       (1<<7)	/* 07: RTC wakeup stat not possible from S4 */
+#define ACPI_FADT_S4_RTC_WAKE       (1<<7)	/* 07: RTC wakeup possible from S4 */
 #define ACPI_FADT_32BIT_TIMER       (1<<8)	/* 08: tmr_val is 32 bits 0=24-bits */
 #define ACPI_FADT_DOCKING_SUPPORTED (1<<9)	/* 09: Docking supported */
 #define ACPI_FADT_RESET_REGISTER    (1<<10)	/* 10: System reset via the FADT RESET_REG supported */
_
