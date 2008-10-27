From: David Brownell <david-b@pacbell.net>
Subject: [patch/RESEND 2.6.28-rc2 1/2] ACPI:  fix ACPI_FADT_S4_RTC_WAKE comment
Date: Mon, 27 Oct 2008 13:57:23 -0700
Message-ID: <200810271357.23861.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752087AbYJ0Vii@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Make the comment for ACPI_FADT_S4_RTC_WAKE match the ACPI spec;
that bit has nothing to do with status bits.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 include/acpi/actbl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/acpi/actbl.h	2008-08-19 20:25:36.000000000 -0700
+++ b/include/acpi/actbl.h	2008-08-19 20:26:14.000000000 -0700
@@ -245,7 +245,7 @@ struct acpi_table_fadt {
 #define ACPI_FADT_POWER_BUTTON      (1<<4)	/* 04: Power button is handled as a generic feature */
 #define ACPI_FADT_SLEEP_BUTTON      (1<<5)	/* 05: Sleep button is handled as a generic feature, or  not present */
 #define ACPI_FADT_FIXED_RTC         (1<<6)	/* 06: RTC wakeup stat not in fixed register space */
-#define ACPI_FADT_S4_RTC_WAKE       (1<<7)	/* 07: RTC wakeup stat not possible from S4 */
+#define ACPI_FADT_S4_RTC_WAKE       (1<<7)	/* 07: RTC wakeup possible from S4 */
 #define ACPI_FADT_32BIT_TIMER       (1<<8)	/* 08: tmr_val is 32 bits 0=24-bits */
 #define ACPI_FADT_DOCKING_SUPPORTED (1<<9)	/* 09: Docking supported */
 #define ACPI_FADT_RESET_REGISTER    (1<<10)	/* 10: System reset via the FADT RESET_REG supported */
