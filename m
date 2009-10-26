From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/3] hp-wmi: Fix memleaks by freeing acpi buffers delcared as ACPI_ALLOCATE_BUFFER
Date: Mon, 26 Oct 2009 17:44:17 +0100
Message-ID: <1256575458-19269-3-git-send-email-trenn@suse.de>
References: <1256575458-19269-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58338 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752511AbZJZQo0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Oct 2009 12:44:26 -0400
In-Reply-To: <1256575458-19269-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux-acpi@vger.kernel.org

C: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
CC: linux-acpi@vger.kernel.org
CC: Len Brown <lenb@kernel.org>
CC: Linux-acpi@vger.kernel.org

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/platform/x86/hp-wmi.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index c284217..8cea7ff 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -128,10 +128,15 @@ static int hp_wmi_perform_query(int query, int write, int value)
 
 	obj = output.pointer;
 
-	if (!obj || obj->type != ACPI_TYPE_BUFFER)
+	if (!obj)
 		return -EINVAL;
+	else if (obj->type != ACPI_TYPE_BUFFER) {
+		kfree(output.pointer);
+		return -EINVAL;
+	}
 
 	bios_return = *((struct bios_return *)obj->buffer.pointer);
+	kfree(output.pointer);
 	if (bios_return.return_code > 0)
 		return bios_return.return_code * -1;
 	else
@@ -377,6 +382,9 @@ static void hp_wmi_notify(u32 value, void *context)
 			       eventcode);
 	} else
 		printk(KERN_INFO "HP WMI: Unknown response received\n");
+
+	if(obj)
+		kfree(obj.pointer);
 }
 
 static int __init hp_wmi_input_setup(void)
-- 
1.6.3

