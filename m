From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH] ACPI: dock: unsuppress uevents
Date: Wed, 9 May 2007 15:09:12 -0700
Message-ID: <20070509150912.d87e6a2d.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50837 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754059AbXEIWMK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 18:12:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

ACPI: dock: unsuppress uevents

Platform devices may not send uevents by default - override the setting
so that we can send uevents on dock/undock.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Index: 2.6-git/drivers/acpi/dock.c
===================================================================
--- 2.6-git.orig/drivers/acpi/dock.c
+++ 2.6-git/drivers/acpi/dock.c
@@ -751,6 +751,9 @@ static int dock_add(acpi_handle handle)
 		return PTR_ERR(dock_device);
 	}
 
+	/* we want the dock device to send uevents */
+	dock_device->dev.uevent_suppress = 0;
+
 	ret = device_create_file(&dock_device->dev, &dev_attr_docked);
 	if (ret) {
 		printk("Error %d adding sysfs file\n", ret);
