From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 6/9] ACPI fan: Debug interface used for error message cleanup
Date: Wed, 30 Jul 2008 22:22:19 +0200
Message-ID: <1217449342-20312-7-git-send-email-trenn@suse.de>
References: <1217449342-20312-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49436 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756406AbYG3UWY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 16:22:24 -0400
In-Reply-To: <1217449342-20312-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/fan.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 55c17af..e3fa9a5 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -327,8 +327,7 @@ static int acpi_fan_resume(struct acpi_device *device)
 
 	result = acpi_bus_get_power(device->handle, &power_state);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error reading fan power state\n"));
+		printk("Error reading fan power state [%d]\n", result);
 		return result;
 	}
 
-- 
1.5.4.5

