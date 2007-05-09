From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH] ACPI: bay: unsuppress uevents
Date: Wed, 9 May 2007 15:55:53 -0700
Message-ID: <20070509155553.17674722.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32196 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757055AbXEIW6v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 18:58:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

ACPI: bay: unsuppress uevents

Since platform devices seem to get uevents suppressed by default,
manually unsuppress for the bay device since we want to be able
to send uevents.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Index: 2.6-git/drivers/acpi/bay.c
===================================================================
--- 2.6-git.orig/drivers/acpi/bay.c
+++ 2.6-git/drivers/acpi/bay.c
@@ -287,6 +287,11 @@ static int bay_add(acpi_handle handle, i
 	}
 	new_bay->pdev = pdev;
 	platform_set_drvdata(pdev, new_bay);
+
+	/*
+	 * we want the bay driver to be able to send uevents
+	 */
+	pdev->dev.uevent_suppress = 0;
 
 	if (acpi_bay_add_fs(new_bay)) {
 		platform_device_unregister(new_bay->pdev);
