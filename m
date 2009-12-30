From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/14] dell-wmi, hp-wmi,
 msi-wmi: check wmi_get_event_data() return value
Date: Wed, 30 Dec 2009 02:36:31 -0500
Message-ID: <5caa3ab36da77d59017cff9b9d1e910862b489e7.1262158495.git.len.brown@intel.com>
References: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:46041 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbZL3Hgp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 02:36:45 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVG00IUYFT76UCA@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 01:36:44 -0600 (CST)
In-reply-to: <1262158597-9597-1-git-send-email-lenb@kernel.org>
In-reply-to: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
References: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

When acpi_evaluate_object() is passed ACPI_ALLOCATE_BUFFER,
the caller must kfree the returned buffer if AE_OK is returned.

The callers of wmi_get_event_data() pass ACPI_ALLOCATE_BUFFER,
and thus must check its return value before accessing
or kfree() on the buffer.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/dell-wmi.c |    7 ++++++-
 drivers/platform/x86/hp-wmi.c   |    7 ++++++-
 drivers/platform/x86/msi-wmi.c  |    7 ++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 4c7e702..500af8c 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -202,8 +202,13 @@ static void dell_wmi_notify(u32 value, void *context)
 	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
 	static struct key_entry *key;
 	union acpi_object *obj;
+	acpi_status status;
 
-	wmi_get_event_data(value, &response);
+	status = wmi_get_event_data(value, &response);
+	if (status != AE_OK) {
+		printk(KERN_INFO "dell-wmi: bad event status 0x%x\n", status);
+		return;
+	}
 
 	obj = (union acpi_object *)response.pointer;
 
diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 18bf741..5b648f0 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -338,8 +338,13 @@ static void hp_wmi_notify(u32 value, void *context)
 	static struct key_entry *key;
 	union acpi_object *obj;
 	int eventcode;
+	acpi_status status;
 
-	wmi_get_event_data(value, &response);
+	status = wmi_get_event_data(value, &response);
+	if (status != AE_OK) {
+		printk(KERN_INFO "hp-wmi: bad event status 0x%x\n", status);
+		return;
+	}
 
 	obj = (union acpi_object *)response.pointer;
 
diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wmi.c
index f746c67..f5f70d4 100644
--- a/drivers/platform/x86/msi-wmi.c
+++ b/drivers/platform/x86/msi-wmi.c
@@ -149,8 +149,13 @@ static void msi_wmi_notify(u32 value, void *context)
 	static struct key_entry *key;
 	union acpi_object *obj;
 	ktime_t cur;
+	acpi_status status;
 
-	wmi_get_event_data(value, &response);
+	status = wmi_get_event_data(value, &response);
+	if (status != AE_OK) {
+		printk(KERN_INFO DRV_PFX "bad event status 0x%x\n", status);
+		return;
+	}
 
 	obj = (union acpi_object *)response.pointer;
 
-- 
1.6.0.6

