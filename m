From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ACPI: implement acpi_os_get_timer() according the spec
Date: Mon, 13 May 2013 13:27:51 +0300
Message-ID: <1368440871-27552-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27301 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234Ab3EMKZb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 May 2013 06:25:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org

ACPI Timer() opcode should return monotonically increasing clock with 100ns
granularity. Implement this with the help of ktime_get().

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/osl.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 586e7e9..2a22170 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -835,19 +835,7 @@ void acpi_os_stall(u32 us)
  */
 u64 acpi_os_get_timer(void)
 {
-	static u64 t;
-
-#ifdef	CONFIG_HPET
-	/* TBD: use HPET if available */
-#endif
-
-#ifdef	CONFIG_X86_PM_TIMER
-	/* TBD: default to PM timer if HPET was not available */
-#endif
-	if (!t)
-		printk(KERN_ERR PREFIX "acpi_os_get_timer() TBD\n");
-
-	return ++t;
+	return ktime_to_ns(ktime_get()) / 100;
 }
 
 acpi_status acpi_os_read_port(acpi_io_address port, u32 * value, u32 width)
-- 
1.7.10.4

