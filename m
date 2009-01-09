From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] Blacklist known broken machines (ThinkPad R40e and R50e) to use rsdt instead xsdt
Date: Fri,  9 Jan 2009 11:58:57 +0100
Message-ID: <1231498738-32714-2-git-send-email-trenn@suse.de>
References: <1229504118.3991.63.camel@yakui_zhao.sh.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:59799 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271AbZAIK67 (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 9 Jan 2009 05:58:59 -0500
In-Reply-To: <1229504118.3991.63.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, yakui.zhao@intel.com, Linux-acpi@vger.kernel.org, me@markdoughty.co.uk, ibm-acpi-devel@lists.sourceforge.net
Cc: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/blacklist.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 09c6980..b64bdeb 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -183,6 +183,13 @@ static int __init dmi_disable_osi_vista(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init dmi_use_rsdt(const struct dmi_system_id *d)
+{
+	printk(KERN_NOTICE PREFIX "DMI detected: %s, using rsdt\n", d->ident);
+	acpi_rsdt_forced = 1;
+	return 0;
+}
+
 static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	{
 	.callback = dmi_disable_osi_vista,
@@ -235,6 +242,20 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
 		},
 	},
+	{
+		.callback = dmi_use_rsdt,
+		.ident = "ThinkPad R40e family", /* R40e, broken C-states */
+		.matches = {
+		     DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
+		     DMI_MATCH(DMI_BIOS_VERSION, "1SET")},
+	},
+	{
+		.callback = dmi_use_rsdt,
+		.ident = "ThinkPad R50e family", /* R50e, slow booting */
+		.matches = {
+		     DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
+		     DMI_MATCH(DMI_BIOS_VERSION, "1WET")},
+	},
 	{}
 };
 
-- 
1.6.0.2

