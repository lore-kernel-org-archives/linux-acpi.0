From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [RFC][PATCH] Subject: Add constraints on usage of ACPI Sleep
	function
Date: Wed, 28 Apr 2010 01:10:27 +0400
Message-ID: <20100427211027.18890.78034.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:51682 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756941Ab0D0VK2 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 27 Apr 2010 17:10:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Panasonic Toughbook CF-52 may use uninitialized variable as argument
to Sleep(), thus stopping init sequence for about 45 days (0xf0000def ms).
Add constraints to not sleep that long, and also to not sleep during init.

References: http://bugzilla.novell.com/show_bug.cgi?id=557710
	    http://bugzilla.kernel.org/show_bug.cgi?id=13195
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/osl.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 7594f65..7a58dc5 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -438,7 +438,14 @@ acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
 
 void acpi_os_sleep(u64 ms)
 {
-	schedule_timeout_interruptible(msecs_to_jiffies(ms));
+	if (ms > 1000) {
+		printk(KERN_WARNING "ACPI: Limit long sleep to 1 second\n");
+		ms = 1000;
+	}
+	if (system_state == SYSTEM_RUNNING)
+		schedule_timeout_interruptible(msecs_to_jiffies(ms));
+	else
+		acpi_os_stall(ms * 1000);
 }
 
 void acpi_os_stall(u32 us)

