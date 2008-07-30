From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 8/9] ACPI thermal: Debug interface used for error message cleanup
Date: Wed, 30 Jul 2008 22:22:21 +0200
Message-ID: <1217449342-20312-9-git-send-email-trenn@suse.de>
References: <1217449342-20312-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49435 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756453AbYG3UWZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 16:22:25 -0400
In-Reply-To: <1217449342-20312-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/thermal.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index db6c2a5..c40b041 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1214,8 +1214,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 				  acpi_bus_private_data_handler,
 				  tz->thermal_zone);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				"Error attaching device data\n"));
+		ACPI_ERROR((DB_INFO, status, "Error attaching device data\n"));
 		return -ENODEV;
 	}
 
-- 
1.5.4.5

