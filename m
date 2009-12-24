From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/34] wmi: Free the allocated acpi objects through
 wmi_get_event_data
Date: Thu, 24 Dec 2009 01:24:01 -0500
Message-ID: <3e9b988e4edf065d39c1343937f717319b1c1065.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205AbZLXTbK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:10 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:30:59 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Anisse Astier <anisse@astier.eu>, Len Brown <len.brown@intel.com>

From: Anisse Astier <anisse@astier.eu>

These function allocate an acpi object by calling wmi_get_event_data, which
then calls acpi_evaluate_object, and it is not freed afterwards.

And kernel doc is fixed for parameters of wmi_get_event_data.

Signed-off-by: Anisse Astier <anisse@astier.eu>
Acked-by: Randy Dunlap <randy.dunlap@oracle.com>
Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/dell-wmi.c |    1 +
 drivers/platform/x86/hp-wmi.c   |    2 ++
 drivers/platform/x86/wmi.c      |    4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 67f3fe7..6561dfc 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -238,6 +238,7 @@ static void dell_wmi_notify(u32 value, void *context)
 			input_sync(dell_wmi_input_dev);
 		}
 	}
+	kfree(obj);
 }
 
 
diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 63c3e65..db10c5d 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -381,6 +381,8 @@ static void hp_wmi_notify(u32 value, void *context)
 	} else
 		printk(KERN_INFO "HP WMI: Unknown key pressed - %x\n",
 			eventcode);
+
+	kfree(obj);
 }
 
 static int __init hp_wmi_input_setup(void)
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index e425a86..9f93d6c 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -540,8 +540,8 @@ EXPORT_SYMBOL_GPL(wmi_remove_notify_handler);
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
1.6.0.6

