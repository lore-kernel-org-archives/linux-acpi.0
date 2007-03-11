From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 4/5] asus-laptop add wapf param
Date: Sun, 11 Mar 2007 10:27:33 +0100
Message-ID: <200703111027.33707.corentincj@iksaif.net>
References: <200703111023.04437.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:48282 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbXCKJ1f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Mar 2007 05:27:35 -0400
In-Reply-To: <200703111023.04437.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

From: Corentin Chary <corentincj@iksaif.net>

Add the "wapf" param. This param allows to define the behavior
of  the Fn F2 key (wlan switch).

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus-laptop.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/misc/asus-laptop.c	2007-03-10 16:31:07.000000000 +0100
+++ b/drivers/misc/asus-laptop.c	2007-03-10 16:34:24.000000000 +0100
@@ -95,6 +95,19 @@
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
@@ -811,6 +824,9 @@
 		printk(ASUS_NOTICE "BSTS called, 0x%02x returned\n",
 		       (uint) bsts_result);
 
+	/* This too ... */
+	write_acpi_int(hotk->handle, "CWAP", wapf, NULL);
+
 	/*
 	 * Try to match the object returned by INIT to the specific model.
 	 * Handle every possible object (or the lack of thereof) the DSDT
