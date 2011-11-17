From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/5] ACPI processor: Do not export acpi_idle_driver in processor.h
Date: Thu, 17 Nov 2011 23:36:57 +0100
Message-ID: <1321569421-46220-2-git-send-email-trenn@suse.de>
References: <1321569421-46220-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34579 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980Ab1KQWhN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Nov 2011 17:37:13 -0500
In-Reply-To: <1321569421-46220-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: trenn@suse.de, linux-acpi@vger.kernel.org

Instead move its declaration from processor_idle.c to processor_driver.c
and declare it static as it's the only file using this struct.

Cleanup only, no functional change.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
---
 drivers/acpi/processor_driver.c |    5 +++++
 drivers/acpi/processor_idle.c   |    5 -----
 include/acpi/processor.h        |    1 -
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index a4e0f1b..3a4fc0c 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -106,6 +106,11 @@ static struct acpi_driver acpi_processor_driver = {
 		},
 };
 
+static struct cpuidle_driver acpi_idle_driver = {
+	.name =		"acpi_idle",
+	.owner =	THIS_MODULE,
+};
+
 #define INSTALL_NOTIFY_HANDLER		1
 #define UNINSTALL_NOTIFY_HANDLER	2
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 9b88f98..7fed4f3 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -968,11 +968,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	return idle_time;
 }
 
-struct cpuidle_driver acpi_idle_driver = {
-	.name =		"acpi_idle",
-	.owner =	THIS_MODULE,
-};
-
 /**
  * acpi_processor_setup_cpuidle - prepares and configures CPUIDLE
  * @pr: the ACPI processor
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 67055f1..5b27bc3 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -333,7 +333,6 @@ int acpi_processor_power_exit(struct acpi_processor *pr,
 			      struct acpi_device *device);
 int acpi_processor_suspend(struct acpi_device * device, pm_message_t state);
 int acpi_processor_resume(struct acpi_device * device);
-extern struct cpuidle_driver acpi_idle_driver;
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
-- 
1.7.6.1

