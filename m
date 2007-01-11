From: Len Brown <len.brown@intel.com>
Subject: [PATCH 2/7] ACPI: ec: enable printk on cmdline use
Date: Thu, 11 Jan 2007 04:11:43 -0500
Message-ID: <11685067101245-git-send-email-len.brown@intel.com>
References: <11685067081383-git-send-email-len.brown@intel.com> <11685067091916-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13149 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030246AbXAKJLx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jan 2007 04:11:53 -0500
In-Reply-To: <11685067091916-git-send-email-len.brown@intel.com>
Message-Id: <723fe2ca82d1ffc80c9d53035babf011f84c65d4.1168506584.git.len.brown@intel.com>
In-Reply-To: <3948ec9406f9a60a43d63f23f6f5284db6529b9c.1168506584.git.len.brown@intel.com>
References: <3948ec9406f9a60a43d63f23f6f5284db6529b9c.1168506584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

if somebody uses "ec_intr=", lets be sure to
capture that in the dmesg even in the non-debug case.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 4144d5d..cbdf031 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1016,8 +1016,8 @@ static int __init acpi_ec_set_intr_mode(char *str)
 		acpi_ec_mode = EC_POLL;
 	}
 	acpi_ec_driver.ops.add = acpi_ec_add;
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "EC %s mode.\n",
-			  intr ? "interrupt" : "polling"));
+	printk(KERN_NOTICE PREFIX "%s mode.\n",
+			  intr ? "interrupt" : "polling");
 
 	return 1;
 }
-- 
1.4.4.4.ge05d
