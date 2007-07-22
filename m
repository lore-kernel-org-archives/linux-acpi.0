From: Len Brown <len.brown@intel.com>
Subject: [PATCH 12/77] ACPI: bay: unsuppress uevents
Date: Sun, 22 Jul 2007 05:13:57 -0400
Message-ID: <1185095714699-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38395 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762426AbXGVJPS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:18 -0400
In-Reply-To: <11850957131802-git-send-email-len.brown@intel.com>
Message-Id: <1f9767df1346c9ce09d6e51b9f34b851e3d94fad.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <len.brown@intel.com>

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Since platform devices seem to get uevents suppressed by default,
manually unsuppress for the bay device since we want to be able
to send uevents.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bay.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index fb3f31b..00d3f3f 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -288,6 +288,11 @@ static int bay_add(acpi_handle handle, int id)
 	new_bay->pdev = pdev;
 	platform_set_drvdata(pdev, new_bay);
 
+	/*
+	 * we want the bay driver to be able to send uevents
+	 */
+	pdev->dev.uevent_suppress = 0;
+
 	if (acpi_bay_add_fs(new_bay)) {
 		platform_device_unregister(new_bay->pdev);
 		goto bay_add_err;
-- 
1.5.3.rc2.22.g69a9b
