From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH] Force acpi_new_pts_ordering for ASUS A6VC laptop
Date: Tue, 25 Mar 2008 16:47:37 +0800
Message-ID: <1206434857.23794.8.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6813 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947AbYCYIvF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Mar 2008 04:51:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Asus A6VC laptop, PCI config space read of slot 01:01.* after ACPI
_PTS is exectued always returns 0xFFFFFFFF.  Force _PTS is executed
after suspending devices

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index d2f71a5..ebc20a5 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -272,12 +272,32 @@ static int __init init_ints_after_s1(const struct dmi_system_id *d)
 	return 0;
 }
 
+/*
+ * On Asus A6VC laptop, PCI config space read of slot 01:01.* after ACPI _PTS
+ * is exectued always returns 0xFFFFFFFF.  Force _PTS is executed after
+ * suspending devices
+ */
+static int __init asus_suspend_order(const struct dmi_system_id *d)
+{
+	printk(KERN_WARNING PREFIX "%s detected, "
+		"acpi_new_pts_ordering is force enabled\n", d->ident);
+	new_pts_ordering = true;
+	return 0;
+}
+
 static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 	{
 	 .callback = init_ints_after_s1,
 	 .ident = "Toshiba Satellite 4030cdt",
 	 .matches = {DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),},
 	 },
+	{
+	 .callback = asus_suspend_order,
+	 .ident = "Asus A6VC",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "A6VC"),},
+	 },
 	{},
 };
 #endif /* CONFIG_SUSPEND */


