From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ACPI / platform: Add ACPI IDs for Intel SST audio device
Date: Mon,  7 Oct 2013 17:12:21 +0300
Message-ID: <1381155141-703-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24161 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031Ab3JGONI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Oct 2013 10:13:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

This adds ACPI IDs for Intel Smart Sound Technology (SST) device found in
Intel Haswell and BayTrail platforms.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/acpi/acpi_platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index c20b02b..aa56cb0 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -31,6 +31,9 @@ static const struct acpi_device_id acpi_platform_device_ids[] = {
 	{ "PNP0D40" },
 	{ "ACPI0003" },
 	{ "VPC2004" },
+	/* Intel Smart Sound Technology */
+	{ "INT33C8" },
+	{ "80860F28" },
 	{ }
 };
 
-- 
1.8.4.rc3

