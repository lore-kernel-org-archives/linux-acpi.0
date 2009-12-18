From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] x86 platform drivers, hp-wmi: Fix two memleaks
Date: Fri, 18 Dec 2009 15:29:23 +0100
Message-ID: <1261146563-2228-2-git-send-email-trenn@suse.de>
References: <1261146563-2228-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57465 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753873AbZLROaB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Dec 2009 09:30:01 -0500
In-Reply-To: <1261146563-2228-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

CC: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
CC: linux-acpi@vger.kernel.org
CC: Len Brown <lenb@kernel.org>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/platform/x86/hp-wmi.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 63c3e65..01a0913 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -134,10 +134,15 @@ static int hp_wmi_perform_query(int query, int write, int value)
 
 	obj = output.pointer;
 
-	if (!obj || obj->type != ACPI_TYPE_BUFFER)
+	if (!obj)
 		return -EINVAL;
+	else if (obj->type != ACPI_TYPE_BUFFER) {
+		kfree(obj);
+		return -EINVAL;
+	}
 
 	bios_return = *((struct bios_return *)obj->buffer.pointer);
+	kfree(obj);
 	if (bios_return.return_code > 0)
 		return bios_return.return_code * -1;
 	else
@@ -340,10 +345,13 @@ static void hp_wmi_notify(u32 value, void *context)
 
 	if (!obj || obj->type != ACPI_TYPE_BUFFER || obj->buffer.length != 8) {
 		printk(KERN_INFO "HP WMI: Unknown response received\n");
+		if (obj)
+			kfree(obj);
 		return;
 	}
 
 	eventcode = *((u8 *) obj->buffer.pointer);
+	kfree(obj);
 	if (eventcode == 0x4)
 		eventcode = hp_wmi_perform_query(HPWMI_HOTKEY_QUERY, 0,
 						0);
-- 
1.6.3

