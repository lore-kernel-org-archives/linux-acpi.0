From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] ACPI EC: enable MSI workaround for Quanta laptops
Date: Tue, 26 Apr 2011 16:30:02 +0800
Message-ID: <1303806602.28018.11.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56939 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab1DZIdV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Apr 2011 04:33:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, jan_braun@gmx.net, "Zhang, Rui" <rui.zhang@intel.com>


Enable MSI workaround for Quanta laptops.
https://bugzilla.kernel.org/show_bug.cgi?id=20242

Tested-by: Jan-Matthias Braun <jan_braun@gmx.net>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/ec.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -936,6 +936,14 @@ static struct dmi_system_id __initdata e
 	ec_flag_msi, "MSI hardware", {
 	DMI_MATCH(DMI_CHASSIS_VENDOR, "MICRO-STAR")}, NULL},
 	{
+	ec_flag_msi, "Quanta hardware", {
+	DMI_MATCH(DMI_SYS_VENDOR, "Quanta"),
+	DMI_MATCH(DMI_PRODUCT_NAME, "TW8/SW8/DW8"),}, NULL},
+	{
+	ec_flag_msi, "Quanta hardware", {
+	DMI_MATCH(DMI_SYS_VENDOR, "Quanta"),
+	DMI_MATCH(DMI_PRODUCT_NAME, "TW9/SW9"),}, NULL},
+	{
 	ec_validate_ecdt, "ASUS hardware", {
 	DMI_MATCH(DMI_BIOS_VENDOR, "ASUS") }, NULL},
 	{},


