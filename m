From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 2/2] ACPI / platform: add IDs for Broadcom Bluetooth chip
Date: Wed, 19 Feb 2014 11:10:33 +0200
Message-ID: <1392801033-17251-3-git-send-email-heikki.krogerus@linux.intel.com>
References: <1392801033-17251-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32678 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148AbaBSJKj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Feb 2014 04:10:39 -0500
In-Reply-To: <1392801033-17251-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

These IDs are used on Baytrail boards such as Lenovo Miix 2
and Asus Transformer Book T100TA. The actual chip should be
BCM43241 with all these IDs.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/acpi_platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 9d0c0fa..c0a3941 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -33,6 +33,9 @@ static const struct acpi_device_id acpi_platform_device_ids[] = {
 	{ "VPC2004" },
 	{ "BCM4752" },
 	{ "LNV4752" },
+	{ "BCM2E1A" },
+	{ "BCM2E39" },
+	{ "BCM2E3D" },
 
 	/* Intel Smart Sound Technology */
 	{ "INT33C8" },
-- 
1.9.0.rc3

