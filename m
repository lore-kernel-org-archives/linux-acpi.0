From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/5] ACPI processor: Fix error path, also remove sysdev link
Date: Mon, 12 Sep 2011 01:42:29 +0200
Message-ID: <1315784551-39118-4-git-send-email-trenn@suse.de>
References: <1315784551-39118-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48664 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925Ab1IKXmn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Sep 2011 19:42:43 -0400
In-Reply-To: <1315784551-39118-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
---
 drivers/acpi/processor_driver.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 9247e67..7bc141a 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -540,6 +540,7 @@ err_thermal_unregister:
 	thermal_cooling_device_unregister(pr->cdev);
 err_power_exit:
 	acpi_processor_power_exit(pr, device);
+	sysfs_remove_link(&device->dev.kobj, "sysdev");
 err_free_cpumask:
 	free_cpumask_var(pr->throttling.shared_cpu_map);
 
-- 
1.7.6.1

