From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/9] ACPI memhotplug: Debug interface used for error message cleanup
Date: Wed, 30 Jul 2008 22:22:15 +0200
Message-ID: <1217449342-20312-3-git-send-email-trenn@suse.de>
References: <1217449342-20312-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:48268 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756232AbYG3UWY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 16:22:24 -0400
In-Reply-To: <1217449342-20312-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/acpi_memhotplug.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 5f1127a..36e51ff 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -454,8 +454,8 @@ static int acpi_memory_device_start (struct acpi_device *device)
 		/* call add_memory func */
 		result = acpi_memory_enable_device(mem_device);
 		if (result)
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				"Error in acpi_memory_enable_device\n"));
+			printk(KERN_ERR "Error in "
+			       "acpi_memory_enable_device\n");
 	}
 	return result;
 }
-- 
1.5.4.5

