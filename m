From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] X86: DMI match for the Sony VGN-Z540N as it needs BIOS
	reboot
Date: Fri, 22 May 2009 11:35:50 +0800
Message-ID: <1242963350.32574.53.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29108 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbZEVDfQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 May 2009 23:35:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Not sure where I should send the patch to.

x86: DMI match for the Sony VGN-Z540N as it needs BIOS reboot
http://bugzilla.kernel.org/show_bug.cgi?id=12901

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/reboot.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6/arch/x86/kernel/reboot.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/reboot.c
+++ linux-2.6/arch/x86/kernel/reboot.c
@@ -232,6 +232,14 @@ static struct dmi_system_id __initdata r
 			DMI_MATCH(DMI_PRODUCT_NAME, "Dell DXP061"),
 		},
 	},
+	{	/* Handle problems with rebooting on Sony VGN-Z540N */
+		.callback = set_bios_reboot,
+		.ident = "Sony VGN-Z540N",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-Z540N"),
+		},
+	},
 	{ }
 };
 


