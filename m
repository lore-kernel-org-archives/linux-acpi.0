From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] ACPI / platform: add ACPI ID for a Broadcom GPS chip
Date: Wed, 16 Oct 2013 13:15:14 +0300
Message-ID: <1381918514-6947-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7903 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760247Ab3JPKPR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Oct 2013 06:15:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org

This adds ACPI ID for Broadcom GPS receiver BCM4752.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/acpi_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 98e7b9c..11be296 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -31,6 +31,7 @@ static const struct acpi_device_id acpi_platform_device_ids[] = {
 	{ "PNP0D40" },
 	{ "ACPI0003" },
 	{ "VPC2004" },
+	{ "BCM4752" },
 
 	/* Intel Smart Sound Technology */
 	{ "INT33C8" },
-- 
1.8.4.rc3

