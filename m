From: Levente Kurusa <levex@linux.com>
Subject: [PATCH] acpi: Add Toshiba NB100 to Vista _OSI blacklist
Date: Tue, 22 Oct 2013 16:53:35 +0200
Message-ID: <5266916F.5020507@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:59645 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab3JVOxj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Oct 2013 10:53:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Hancock <hancockrwd@gmail.com>
Cc: Aaron Lu <aaron.lu@intel.com>, ACPI List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

This patch adds Toshiba NB100 to the Vista _OSI blacklist.

The _OSI(Windows 2006) method is bugged on the netbook resulting in messed up
PCI IRQ Routing information. This was observed on a netbook,
whose SATA controller mode was set to Compatibility mode.
The controller would then issue IRQs to IRQ#16 instead of
IRQ#20, where it should have been.
No side-effects were found during testing, everything is
working as it did before.

See thread:
http://marc.info/?t=137862230200001&r=1&w=2
http://www.spinics.net/lists/linux-ide/msg46173.html


Signed-off-by: Levente Kurusa <levex@linux.com>
Reviewed-by: Robert Hancock <hancockrwd@gmail.com>
---
diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index cb96296..34d4d1a 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -267,6 +267,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P305D"),
 		},
 	},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Toshiba NB100",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "NB100"),
+		},
+	},

 	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
