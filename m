From: yakui_zhao <yakui.zhao@intel.com>
Subject: [patch]: ACPI: Add the Pansonic CF51 box to the dmi check table
Date: Wed, 18 Mar 2009 16:36:25 +0800
Message-ID: <1237365385.3640.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56412 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbZCRIfZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Mar 2009 04:35:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI: Add the Pansonic CF51 box to the dmi check table
From: Zhao Yakui <yakui.zhao@intel.com>

The Pansonic CF51-2L box can't be resumed if the boot option of
"acpi_sleep=old_ordering" is not added.

Add the Pansonic CF51-2L to the dmi check table so that the old suspend
order is used.

http://bugzilla.kernel.org/show_bug.cgi?id=12561

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/sleep.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c	2009-03-10 10:54:41.000000000 +0800
+++ linux-2.6/drivers/acpi/sleep.c	2009-03-10 11:39:42.000000000 +0800
@@ -378,6 +378,15 @@
 		DMI_MATCH(DMI_PRODUCT_NAME, "Macmini1,1"),
 		},
 	},
+	{
+	.callback = init_old_suspend_ordering,
+	.ident = "Pansonic CF51-2L",
+	.matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR,
+				"Matsushita Electric Industrial Co.,Ltd."),
+		DMI_MATCH(DMI_BOARD_NAME, "CF51-2L"),
+		},
+	},
 	{},
 };
 #endif /* CONFIG_SUSPEND */


