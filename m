From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 4/5] ACPI processor: Fix error path, also remove sysdev link
Date: Thu, 17 Nov 2011 23:37:00 +0100
Message-ID: <1321569421-46220-5-git-send-email-trenn@suse.de>
References: <1321569421-46220-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34580 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726Ab1KQWhN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Nov 2011 17:37:13 -0500
In-Reply-To: <1321569421-46220-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: trenn@suse.de, linux-acpi@vger.kernel.org

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
---
 drivers/acpi/processor_driver.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 790623f..3e5763f 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -545,6 +545,7 @@ err_thermal_unregister:
 	thermal_cooling_device_unregister(pr->cdev);
 err_power_exit:
 	acpi_processor_power_exit(pr, device);
+	sysfs_remove_link(&device->dev.kobj, "sysdev");
 err_free_cpumask:
 	free_cpumask_var(pr->throttling.shared_cpu_map);
 
-- 
1.7.6.1

