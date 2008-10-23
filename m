From: Len Brown <lenb@kernel.org>
Subject: [PATCH 059/122] ACPI: Ignore AE_NOT_FOUND error of EC _REG method and
 continue to initialize EC
Date: Thu, 23 Oct 2008 02:38:33 -0400
Message-ID: <20edd74fcf9ad02c19efba0c13670a7b6b045099.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:51267 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295AbYJWGkU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:20 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K96006XUIIS3BU1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:05 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

On some broken BIOS the ACPI object in EC _REG method can't be found in
ACPI namespace, which causes that the status code of AE_NOT_FOUND is returned by
the EC _REG object. In such case the EC device can't be initialized correctly,
which causes that battery/AC adapter can't work normally. As the EC address
space handler is not removed and the memory pointed by its input argument is
already free, sometimes the kernel will also be panic when EC internal register
is still accessed. But the windows can work well on such broken BIOS.

Maybe it will be reasonable that OS ignores the AE_NOT_FOUND error
returned by the EC _REG object and continues to initialize EC device
on some broken BIOS.
For example: the ACPI object in EC _REG method can't be found and status error
code is AE_NOT_FOUND.

http://bugzilla.kernel.org/show_bug.cgi?id=8953
http://bugzilla.kernel.org/show_bug.cgi?id=10237

lenb: we may find a more general solution to this in the future.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 13593f9..4c00428 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -862,8 +862,19 @@ static int ec_install_handlers(struct acpi_ec *ec)
 						    &acpi_ec_space_handler,
 						    NULL, ec);
 	if (ACPI_FAILURE(status)) {
-		acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
-		return -ENODEV;
+		if (status == AE_NOT_FOUND) {
+			/*
+			 * Maybe OS fails in evaluating the _REG object.
+			 * The AE_NOT_FOUND error will be ignored and OS
+			 * continue to initialize EC.
+			 */
+			printk(KERN_ERR "Fail in evaluating the _REG object"
+				" of EC device. Broken bios is suspected.\n");
+		} else {
+			acpi_remove_gpe_handler(NULL, ec->gpe,
+				&acpi_ec_gpe_handler);
+			return -ENODEV;
+		}
 	}
 
 	ec->handlers_installed = 1;
-- 
1.5.5.1

