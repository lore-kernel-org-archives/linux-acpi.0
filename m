From: Len Brown <lenb@kernel.org>
Subject: [PATCH 009/112] ACPI: Add autoload info to dock driver
Date: Thu,  7 Feb 2008 04:33:31 -0500
Message-ID: <a340af14b4c08a53c5f7d821d8bd910e17403384.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:32156 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755078AbYBGJf1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:27 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Frank Seidel <fseidel@suse.de>, Thomas Renninger <trenn@novell.com>, Kay Sievers <kasievers@novell.com>, Len Brown <len.brown@intel.com>

From: Frank Seidel <fseidel@suse.de>

References: https://bugzilla.novell.com/show_bug.cgi?id=302482

Signed-off-by: Thomas Renninger <trenn@novell.com>
Signed-off-by: Kay Sievers <kasievers@novell.com>
Signed-off-by: Frank Seidel <fseidel@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c         |    6 ++++++
 include/acpi/acpi_drivers.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 1dabdf4..b3dec21 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -51,6 +51,12 @@ static struct atomic_notifier_head dock_notifier_list;
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
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index f85f77a..581daa4 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -48,6 +48,7 @@
 #define ACPI_BUTTON_HID_SLEEPF		"LNXSLPBN"
 #define ACPI_VIDEO_HID			"LNXVIDEO"
 #define ACPI_BAY_HID			"LNXIOBAY"
+#define ACPI_DOCK_HID			"LNXDOCK"
 
 /* --------------------------------------------------------------------------
                                        PCI
-- 
1.5.4.23.gef5b9

