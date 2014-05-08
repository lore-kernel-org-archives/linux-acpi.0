From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [RESEND PATCH 1/2] ACPI / platform: add ID for GPS module on Lenovo Miix 2
Date: Thu,  8 May 2014 14:30:24 +0300
Message-ID: <1399548625-9775-2-git-send-email-heikki.krogerus@linux.intel.com>
References: <1399548625-9775-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57476 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753990AbaEHLa3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 May 2014 07:30:29 -0400
In-Reply-To: <1399548625-9775-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org

On Lenovo Miix 2 8", BCM4752 is called LNV4752.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/acpi_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 1d49503..bff9ea5 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -31,6 +31,7 @@ static const struct acpi_device_id acpi_platform_device_ids[] = {
 	{ "PNP0D40" },
 	{ "VPC2004" },
 	{ "BCM4752" },
+	{ "LNV4752" },
 
 	/* Intel Smart Sound Technology */
 	{ "INT33C8" },
-- 
2.0.0.rc2

