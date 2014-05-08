From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] ACPI / platform: add IDs for Broadcom Bluetooth and GPS chips
Date: Thu,  8 May 2014 14:59:04 +0300
Message-ID: <1399550344-26952-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49734 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753585AbaEHL7G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 May 2014 07:59:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org

These IDs are used on Baytrail boards such as Lenovo Miix 2
and Asus Transformer Book T100TA. On lenovo Miix 2 8",
BCM4752 is called LNV4752. All the rest of the IDs are for
Broadcom BCM43241 module with the ID referring to different
revision number.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/acpi_platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 1d49503..34a64c5 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -31,6 +31,10 @@ static const struct acpi_device_id acpi_platform_device_ids[] = {
 	{ "PNP0D40" },
 	{ "VPC2004" },
 	{ "BCM4752" },
+	{ "LNV4752" },
+	{ "BCM2E1A" },
+	{ "BCM2E39" },
+	{ "BCM2E3D" },
 
 	/* Intel Smart Sound Technology */
 	{ "INT33C8" },
-- 
2.0.0.rc2

