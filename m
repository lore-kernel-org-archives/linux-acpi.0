From: Len Brown <lenb@kernel.org>
Subject: [PATCH 37/49] ACPI: run _OSC after ACPI_FULL_INITIALIZATION
Date: Sat,  6 Oct 2012 16:09:58 -0400
Message-ID: <fc54ab72959edbf229b65ac74b2f122d799ca002.1349554106.git.len.brown@intel.com>
References: <1349554210-29978-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:59199 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab2JFUVH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Oct 2012 16:21:07 -0400
In-Reply-To: <1349554210-29978-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
References: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>, stable@vger.kernel.org

From: Lin Ming <ming.m.lin@intel.com>

The _OSC method may exist in module level code,
so it must be called after ACPI_FULL_INITIALIZATION

On some new platforms with Zero-Power-Optical-Disk-Drive (ZPODD)
support, this fix is necessary to save power.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Tested-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/acpi/bus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index e059695..d59175e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -994,8 +994,6 @@ static int __init acpi_bus_init(void)
 	status = acpi_ec_ecdt_probe();
 	/* Ignore result. Not having an ECDT is not fatal. */
 
-	acpi_bus_osc_support();
-
 	status = acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Unable to initialize ACPI objects\n");
@@ -1003,6 +1001,12 @@ static int __init acpi_bus_init(void)
 	}
 
 	/*
+	 * _OSC method may exist in module level code,
+	 * so it must be run after ACPI_FULL_INITIALIZATION
+	 */
+	acpi_bus_osc_support();
+
+	/*
 	 * _PDC control method may load dynamic SSDT tables,
 	 * and we need to install the table handler before that.
 	 */
-- 
1.8.0.rc0.18.gf84667d

