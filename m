From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/23] ACPI: fix ACPI_FADT_S4_RTC_WAKE comment
Date: Fri, 16 Jan 2009 15:25:08 -0500
Message-ID: <c3407710b76610962a5ebb244172631ef9eeb51a.1232137453.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:43575 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759711AbZAPUZd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:33 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KDK00FT0ZEAQLS7@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:25:23 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Make the comment for ACPI_FADT_S4_RTC_WAKE match the ACPI spec;
that bit has nothing to do with status bits.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/actbl.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 813e4b6..bf8d4cf 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -245,7 +245,7 @@ struct acpi_table_fadt {
 #define ACPI_FADT_POWER_BUTTON      (1<<4)	/* 04: Power button is handled as a generic feature */
 #define ACPI_FADT_SLEEP_BUTTON      (1<<5)	/* 05: Sleep button is handled as a generic feature, or  not present */
 #define ACPI_FADT_FIXED_RTC         (1<<6)	/* 06: RTC wakeup stat not in fixed register space */
-#define ACPI_FADT_S4_RTC_WAKE       (1<<7)	/* 07: RTC wakeup stat not possible from S4 */
+#define ACPI_FADT_S4_RTC_WAKE       (1<<7)	/* 07: RTC wakeup possible from S4 */
 #define ACPI_FADT_32BIT_TIMER       (1<<8)	/* 08: tmr_val is 32 bits 0=24-bits */
 #define ACPI_FADT_DOCKING_SUPPORTED (1<<9)	/* 09: Docking supported */
 #define ACPI_FADT_RESET_REGISTER    (1<<10)	/* 10: System reset via the FADT RESET_REG supported */
-- 
1.5.6.6

