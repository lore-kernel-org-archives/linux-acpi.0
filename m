From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI: Add HP nc6000 into DMI power check table to disable
	power state check in power transition
Date: Mon, 11 May 2009 09:28:03 +0800
Message-ID: <1242005283.3773.136.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17654 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631AbZEKBZy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 May 2009 21:25:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhao Yakui <yakui.zhao@intel.com>

On the HP nc6000 there exists the bogus _OFF object for the power resource,
which causes that the power resource can't be turned off and then the device
can't be switched to D3 state correctly. 

Add the HP nc6000 into DMI power check table to disable the power state check
in power transistion.

http://bugzilla.kernel.org/show_bug.cgi?id=13243

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/bus.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c	2009-05-04 08:42:43.000000000 +0800
+++ linux-2.6/drivers/acpi/bus.c	2009-05-11 08:57:49.000000000 +0800
@@ -63,6 +63,15 @@
 	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 	DMI_MATCH(DMI_SYS_VENDOR, "HP Pavilion 05"),
 	DMI_MATCH(DMI_PRODUCT_VERSION, "2001211RE101GLEND") }, NULL},
+	{
+	.callback = set_power_nocheck,
+	.ident = "HP nc6000",
+	.matches = {
+		DMI_MATCH(DMI_BIOS_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "F.15"),
+		DMI_MATCH(DMI_BOARD_NAME, "0890"),
+		},
+	},
 	{},
 };
 


