From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/8] ACPI: DMI: add Panasonic CF-52 and Thinpad X61
Date: Fri,  8 Feb 2008 01:29:22 -0500
Message-ID: <446b1dfc4cd1c2bbc7eb22d5fec38e23a577492c.1202452053.git.len.brown@intel.com>
References: <1202452164-32320-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:37463 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760499AbYBHG3g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2008 01:29:36 -0500
In-Reply-To: <1202452164-32320-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b0b23e0ade6aa265d7278e06d50bc10ec81dd174.1202452053.git.len.brown@intel.com>
References: <b0b23e0ade6aa265d7278e06d50bc10ec81dd174.1202452053.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Add Lenovo X61
Add Panasonic Toughbook CF-52

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 6dbaa2d..9ce983e 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -445,6 +445,8 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
 	 * _OSI(Linux) is a NOP:
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "3000 N100"),
+	 * _OSI(Linux) effect unknown
+	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
 	 */
 	{
 	.callback = dmi_enable_osi_linux,
@@ -464,6 +466,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	},
 	{
 	.callback = dmi_unknown_osi_linux,
+	.ident = "Lenovo ThinkPad X61",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
+		},
+	},
+	{
+	.callback = dmi_unknown_osi_linux,
 	.ident = "Lenovo 3000 V100",
 	.matches = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
@@ -505,6 +515,16 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "NEC VERSA M360"),
 		},
 	},
+	/* Panasonic */
+	{
+	.callback = dmi_unknown_osi_linux,
+	.ident = "Panasonic",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Matsushita"),
+			/* Toughbook CF-52 */
+		     DMI_MATCH(DMI_PRODUCT_NAME, "CF-52CCABVBG"),
+		},
+	},
 	/*
 	 * Disable OSI(Linux) warnings on all "Samsung Electronics"
 	 *
-- 
1.5.4.34.g053d9

