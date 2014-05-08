From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [RESEND PATCH 2/2] ACPI / platform: add IDs for Broadcom Bluetooth chip
Date: Thu,  8 May 2014 14:30:25 +0300
Message-ID: <1399548625-9775-3-git-send-email-heikki.krogerus@linux.intel.com>
References: <1399548625-9775-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57476 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261AbaEHLaa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 May 2014 07:30:30 -0400
In-Reply-To: <1399548625-9775-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org

These IDs are used on Baytrail boards such as Lenovo Miix 2
and Asus Transformer Book T100TA. The actual chip should be
BCM43241 with all these IDs.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/acpi_platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index bff9ea5..34a64c5 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -32,6 +32,9 @@ static const struct acpi_device_id acpi_platform_device_ids[] = {
 	{ "VPC2004" },
 	{ "BCM4752" },
 	{ "LNV4752" },
+	{ "BCM2E1A" },
+	{ "BCM2E39" },
+	{ "BCM2E3D" },
 
 	/* Intel Smart Sound Technology */
 	{ "INT33C8" },
-- 
2.0.0.rc2

