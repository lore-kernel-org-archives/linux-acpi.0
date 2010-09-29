From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: invoke DSDT corruption workaround on all Toshiba
 Satellite
Date: Wed, 29 Sep 2010 14:32:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009291429090.21034@localhost.localdomain>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
 <b4b8edbdb198b3dfe633de9c93a014b22e3ec014.1285731809.git.len.brown@intel.com>
 <20100929115108.1c596067@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:59522 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261Ab0I2Scw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Sep 2010 14:32:52 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9I0050AU69LA60@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 29 Sep 2010 13:32:35 -0500 (CDT)
In-reply-to: <20100929115108.1c596067@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>, Frank <frank@61924.nl>, joe@neoturbine.net
Cc: linux-acpi@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Our list of Toshiba Satellite models that require this workaround
is growing -- so invoke the workaround for the entire product line.

https://bugzilla.kernel.org/show_bug.cgi?id=14679

Signed-off-by: Len Brown <len.brown@intel.com>
---

Please test this patch.
thanks,
-Len

 drivers/acpi/bus.c |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 5c221ab..a70ca8e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -80,23 +80,15 @@ static int set_copy_dsdt(const struct dmi_system_id *id)
 
 static struct dmi_system_id dsdt_dmi_table[] __initdata = {
 	/*
-	 * Insyde BIOS on some TOSHIBA machines corrupt the DSDT.
+	 * Invoke DSDT corruption work-around on all Toshiba Satellite.
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=14679
 	 */
 	{
 	 .callback = set_copy_dsdt,
-	 .ident = "TOSHIBA Satellite A505",
+	 .ident = "TOSHIBA Satellite",
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite A505"),
-		},
-	},
-	{
-	 .callback = set_copy_dsdt,
-	 .ident = "TOSHIBA Satellite L505D",
-	 .matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L505D"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite"),
 		},
 	},
 	{}
-- 
1.7.3.15.g442cb

