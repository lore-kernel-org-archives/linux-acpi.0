From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/3] Add autoload info to dock driver
Date: Fri, 07 Dec 2007 13:20:42 +0100
Message-ID: <1197030042.28990.130.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:47529 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbXLGMUn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Dec 2007 07:20:43 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm <akpm@linux-foundation.org>, Holger Macht <hmacht@suse.de>, fseidel <fseidel@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, linux-acpi <linux-acpi@vger.kernel.org>

From: Frank Seidel <fseidel@suse.de>

Add autoload info to dock driver

References: https://bugzilla.novell.com/show_bug.cgi?id=302482

Signed-off-by: Thomas Renninger <trenn@novell.com>
Signed-off-by: Kay Sievers <kasievers@novell.com>
Signed-off-by: Frank Seidel <fseidel@suse.de>

---
 drivers/acpi/dock.c         |    6 ++++++
 include/acpi/acpi_drivers.h |    1 +
 2 files changed, 7 insertions(+)

Index: linux-2.6/drivers/acpi/dock.c
===================================================================
--- linux-2.6.orig/drivers/acpi/dock.c
+++ linux-2.6/drivers/acpi/dock.c
@@ -51,6 +51,12 @@ static struct atomic_notifier_head dock_
 static struct platform_device *dock_device;
 static char dock_device_name[] = "dock";
 
+static const struct acpi_device_id dock_device_ids[] = {
+	{"LNXDOCK", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, dock_device_ids);
+
 struct dock_station {
 	acpi_handle handle;
 	unsigned long last_dock_time;
Index: linux-2.6/include/acpi/acpi_drivers.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_drivers.h
+++ linux-2.6/include/acpi/acpi_drivers.h
@@ -48,6 +48,7 @@
 #define ACPI_BUTTON_HID_SLEEPF		"LNXSLPBN"
 #define ACPI_VIDEO_HID			"LNXVIDEO"
 #define ACPI_BAY_HID			"LNXIOBAY"
+#define ACPI_DOCK_HID			"LNXDOCK"
 
 /* --------------------------------------------------------------------------
                                        PCI


