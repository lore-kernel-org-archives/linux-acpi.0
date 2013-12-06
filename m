From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] ACPI / blacklist: disable Win8 mode for ThinkPad X201 and
 Latitude E6230
Date: Fri, 06 Dec 2013 13:24:02 +0800
Message-ID: <52A15F72.1050408@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25124 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752Ab3LFFYA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Dec 2013 00:24:00 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Jeffery To <jeffery.to@gmail.com>, Wouter Depypere <wouter.depypere@ugent.be>

Both ThinkPad X201 and Latitude E6230 have problems under Win8 mode,
so blacklist Win8 mode for them.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=60697
Reported-and-tested-by: Jeffery To <jeffery.to@gmail.com>
Reported-and-tested-by: Wouter Depypere <wouter.depypere@ugent.be>
Cc: 3.8 and above <stable@vger.kernel.org>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/blacklist.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 05ee8f61bfb5..97a8e395f72e 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -324,6 +324,32 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 
 	/*
+	 * The bluetooth functionality is unconditionally enabled
+	 * after a S3 cycle on Thinkpad X201 under Win8 mode.
+	 */
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "ThinkPad X201",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201"),
+		},
+	},
+
+	/*
+	 * The hardware switch for enable/disable wifi on
+	 * Dell Latitude E6230 is broken under Win8 mode.
+	 */
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Dell Latitude E6230",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Latitude E6230"),
+		},
+	},
+
+	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
 	 * Linux ignores it, except for the machines enumerated below.
 	 */
-- 
1.8.3.1

