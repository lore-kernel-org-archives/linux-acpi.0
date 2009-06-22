From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4/5] disable Vista compatibility on some sony laptops
Date: Mon, 22 Jun 2009 11:31:17 +0800
Message-ID: <1245641478-31805-4-git-send-email-rui.zhang@intel.com>
References: <n>
 <1245641478-31805-1-git-send-email-rui.zhang@intel.com>
 <1245641478-31805-2-git-send-email-rui.zhang@intel.com>
 <1245641478-31805-3-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56781 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbZFVDaf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Jun 2009 23:30:35 -0400
In-Reply-To: <1245641478-31805-3-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

Linux claims Vista compatibility to the BIOS for a number of
reasons, but this brings hard lockup on some Sony laptops.

Disable Vista compatibility via DMI for these laptops unless
we can figure out what Vista is doing for this platform.
http://bugzilla.kernel.org/show_bug.cgi?id=12904

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/blacklist.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 09c6980..f6baa77 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -192,6 +192,22 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
 		},
 	},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Sony VGN-NS10J_S",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-NS10J_S"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Sony VGN-SR290J",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Sony VGN-SR290J"),
+		},
+	},
 
 	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
-- 
1.5.4.4

