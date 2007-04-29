From: Len Brown <len.brown@intel.com>
Subject: [PATCH 016/105] asus-laptop: add wapf param
Date: Sun, 29 Apr 2007 00:50:16 -0400
Message-ID: <11778223192706-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58359 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754600AbXD2EwA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:00 -0400
In-Reply-To: <11778223183783-git-send-email-len.brown@intel.com>
Message-Id: <185e5af98b1e09b1e0f859332243223776b2ad57.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Add the "wapf" param. This param allows to define the behavior
of  the Fn F2 key (wlan switch).

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 475709b..d75e447 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -95,6 +95,19 @@ MODULE_AUTHOR("Julien Lerouge, Karol Kozimor, Corentin Chary");
 MODULE_DESCRIPTION(ASUS_HOTK_NAME);
 MODULE_LICENSE("GPL");
 
+/* WAPF defines the behavior of the Fn+Fx wlan key
+ * The significance of values is yet to be found, but
+ * most of the time:
+ * 0x0 will do nothing
+ * 0x1 will allow to control the device with Fn+Fx key.
+ * 0x4 will send an ACPI event (0x88) while pressing the Fn+Fx key
+ * 0x5 like 0x1 or 0x4
+ * So, if something doesn't work as you want, just try other values =)
+ */
+static uint wapf = 1;
+module_param(wapf, uint, 0644);
+MODULE_PARM_DESC(wapf, "WAPF value");
+
 #define ASUS_HANDLE(object, paths...)					\
 	static acpi_handle  object##_handle = NULL;			\
 	static char *object##_paths[] = { paths }
@@ -811,6 +824,9 @@ static int asus_hotk_get_info(void)
 		printk(ASUS_NOTICE "BSTS called, 0x%02x returned\n",
 		       (uint) bsts_result);
 
+	/* This too ... */
+	write_acpi_int(hotk->handle, "CWAP", wapf, NULL);
+
 	/*
 	 * Try to match the object returned by INIT to the specific model.
 	 * Handle every possible object (or the lack of thereof) the DSDT
-- 
1.5.2.rc0.34.gda94
