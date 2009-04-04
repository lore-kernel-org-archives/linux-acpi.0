From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 1/3] acer-wmi: Blacklist Acer Aspire One
Date: Sat, 04 Apr 2009 09:12:49 +0100
Message-ID: <20090404081248.9812.74409.stgit@localhost>
References: <20090404081243.9812.3769.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:37592 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1754562AbZDDIUp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 4 Apr 2009 04:20:45 -0400
In-Reply-To: <20090404081243.9812.3769.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

The Aspire One's ACPI-WMI interface is a placeholder that does nothing,
and the invalid results that we get from it are now causing userspace
problems as acer-wmi always returns that the rfkill is enabled (i.e. the
radio is off, when it isn't). As it's hardware controlled, acer-wmi
isn't needed on the Aspire One either.

Thanks to Andy Whitcroft at Canonical for tracking down Ubuntu's userspace
issues to this.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Reported-by: Andy Whitcroft <apw@canonical.com>
Cc: stable@kernel.org
---

 drivers/platform/x86/acer-wmi.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)


diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index a6a42e8..61d02f9 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -225,6 +225,27 @@ static struct quirk_entry quirk_fujitsu_amilo_li_1718 = {
 	.wireless = 2,
 };
 
+/* The Aspire One has a dummy ACPI-WMI interface - disable it */
+static struct dmi_system_id __devinitdata acer_blacklist[] = {
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Aspire One (SSD)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AOA110"),
+		},
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Aspire One (HDD)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
+		},
+	},
+	{}
+};
+
 static struct dmi_system_id acer_quirks[] = {
 	{
 		.callback = dmi_matched,
@@ -1254,6 +1275,12 @@ static int __init acer_wmi_init(void)
 
 	printk(ACER_INFO "Acer Laptop ACPI-WMI Extras\n");
 
+	if (dmi_check_system(acer_blacklist)) {
+		printk(ACER_INFO "Blacklisted hardware detected - "
+				"not loading\n");
+		return -ENODEV;
+	}
+
 	find_quirks();
 
 	/*

