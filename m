From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/3] Also autoload the bay driver, was forgotten
Date: Fri, 07 Dec 2007 13:20:43 +0100
Message-ID: <1197030043.28990.131.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34691 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbXLGMUo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Dec 2007 07:20:44 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: fseidel <fseidel@suse.de>, Holger Macht <hmacht@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, linux-acpi <linux-acpi@vger.kernel.org>, akpm <akpm@linux-foundation.org>

Also autoload the bay driver, was forgotten...

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/bay.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6.22-SL103_BRANCH/drivers/acpi/bay.c
===================================================================
--- linux-2.6.22-SL103_BRANCH.orig/drivers/acpi/bay.c
+++ linux-2.6.22-SL103_BRANCH/drivers/acpi/bay.c
@@ -46,6 +46,12 @@ MODULE_LICENSE("GPL");
 	printk(KERN_DEBUG PREFIX "%s: %s\n", prefix, s); }
 static void bay_notify(acpi_handle handle, u32 event, void *data);
 
+static const struct acpi_device_id bay_device_ids[] = {
+	{"LNXIOBAY", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, bay_device_ids);
+
 struct bay {
 	acpi_handle handle;
 	char *name;


