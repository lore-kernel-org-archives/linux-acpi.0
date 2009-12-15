From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH resend] wmi: Free the allocated acpi objects through
 wmi_get_event_data
Date: Tue, 15 Dec 2009 10:50:24 +0100
Message-ID: <20091215105024.3acad900@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:36834 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbZLOJxi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Dec 2009 04:53:38 -0500
Received: by fxm21 with SMTP id 21so4177983fxm.21
        for <linux-acpi@vger.kernel.org>; Tue, 15 Dec 2009 01:53:37 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg@redhat.com>, Randy Dunlap <randy.dunlap@oracle.com>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Frans Pop <elendil@planet.nl>


These function allocate an acpi object by calling wmi_get_event_data, which
then calls acpi_evaluate_object, and it is not freed afterwards.

And kernel doc is fixed for parameters of wmi_get_event_data.

Signed-off-by: Anisse Astier <anisse@astier.eu>
Acked-by: Matthew Garrett <mjg@redhat.com>
Acked-by: Randy Dunlap <randy.dunlap@oracle.com>
---
Hi,
I didn't see this patch merged in any tree yet, so I'm resending it with the
added acked-bys.

Regards,

Anisse

 drivers/platform/x86/dell-wmi.c |    1 +
 drivers/platform/x86/hp-wmi.c   |    2 ++
 drivers/platform/x86/wmi.c      |    4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 0f900cc..f235a98 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -180,6 +180,7 @@ static void dell_wmi_notify(u32 value, void *context)
 			printk(KERN_INFO "dell-wmi: Unknown key %x pressed\n",
 			       buffer[1] & 0xFFFF);
 	}
+	kfree(obj);
 }
 
 static int __init dell_wmi_input_setup(void)
diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index c284217..36109e1 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -377,6 +377,8 @@ static void hp_wmi_notify(u32 value, void *context)
 			       eventcode);
 	} else
 		printk(KERN_INFO "HP WMI: Unknown response received\n");
+
+	kfree(obj);
 }
 
 static int __init hp_wmi_input_setup(void)
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 177f8d7..87f4c97 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -510,8 +510,8 @@ EXPORT_SYMBOL_GPL(wmi_remove_notify_handler);
 /**
  * wmi_get_event_data - Get WMI data associated with an event
  *
- * @event - Event to find
- * &out - Buffer to hold event data
+ * @event: Event to find
+ * @out: Buffer to hold event data. out->pointer should be freed with kfree()
  *
  * Returns extra data associated with an event in WMI.
  */
-- 
1.6.5.3

