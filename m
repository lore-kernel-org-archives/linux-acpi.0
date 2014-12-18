From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: [PATCH v3 1/2] acpi: Add "acpi_osi=" for ASUS X200MA to enable, brightness
 keys
Date: Thu, 18 Dec 2014 15:16:35 +0300
Message-ID: <5492C5A3.8090700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:45038 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbaLRMQi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Dec 2014 07:16:38 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, aaron.lu@intel.com

Add "acpi_osi=" quirk for ASUS X200MA
More information can be found in UX302LA bugreport
https://bugzilla.kernel.org/show_bug.cgi?id=70241

X200MA is affected by th e same bug and the solution has been tested

I reported it to launchpad too
https://bugs.launchpad.net/ubuntu/bug/1400068

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>

---
  drivers/acpi/blacklist.c | 20 ++++++++++++++++++++
  1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 7556e7c..f78ed08 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -162,6 +162,17 @@ static int __init dmi_disable_osi_win8(const struct dmi_system_id *d)
  	acpi_osi_setup("!Windows 2012");
  	return 0;
  }
+/*
+ * Some ASUS models firmware declares 16 devices instead of 8
+ * 'acpi_osi=' kernel parameter fixes it
+ * Without this parameters brightness keys Fn+F5 and F6 do not work
+ */
+static int __init dmi_disable_osi_all(const struct dmi_system_id *d)
+{
+	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
+	acpi_osi_setup("");
+	return 0;
+}
  
  static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
  	{
@@ -371,6 +382,15 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
  		     DMI_MATCH(DMI_PRODUCT_NAME, "1015PX"),
  		},
  	},
+	/* Without this brightness keys do not work */	
+	{
+	.callback = dmi_disable_osi_all,
+	.ident = "ASUSTeK COMPUTER INC. X200MA",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "X200MA"),
+		},
+	},
  	{}
  };
  
-- 
1.9.1
