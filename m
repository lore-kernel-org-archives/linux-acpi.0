From: Len Brown <lenb@kernel.org>
Subject: [PATCH 77/98] ACPI: call acpi_wakeup_device_init() explicitly rather
 than as initcall
Date: Sat, 28 Mar 2009 00:31:52 -0400
Message-ID: <201b8c655f7a48563f6a0b66f9e388460a1ea611.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:65009 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755267AbZC1Edi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:38 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700HGG8O02O21@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:37 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Li Shaohua <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch makes acpi_init() call acpi_wakeup_device_init() directly.
Previously, acpi_wakeup_device_init() was a late_initcall (sequence 7).

acpi_wakeup_device_init() depends on acpi_wakeup_device_list, which
is populated when ACPI devices are enumerated by acpi_init() ->
acpi_scan_init().  Using late_initcall is certainly enough to make
sure acpi_wakeup_device_list is populated, but it is more than
necessary.  We can just as easily call acpi_wakeup_device_init()
directly from acpi_init(), which avoids the initcall magic.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |    1 +
 drivers/acpi/internal.h |    2 ++
 drivers/acpi/wakeup.c   |    7 +------
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a812e84..7fe0945 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -886,6 +886,7 @@ static int __init acpi_init(void)
 	acpi_system_init();
 	acpi_debug_init();
 	acpi_sleep_proc_init();
+	acpi_wakeup_device_init();
 	return result;
 }
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 8870e5f..11a69b5 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -22,6 +22,8 @@ int acpi_power_get_inferred_state(struct acpi_device *device);
 int acpi_power_transition(struct acpi_device *device, int state);
 extern int acpi_power_nocheck;
 
+int acpi_wakeup_device_init(void);
+
 /* --------------------------------------------------------------------------
                                   Embedded Controller
    -------------------------------------------------------------------------- */
diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index 3f29fd5..5aee8c2 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -138,13 +138,10 @@ void acpi_disable_wakeup_device(u8 sleep_state)
 	spin_unlock(&acpi_device_lock);
 }
 
-static int __init acpi_wakeup_device_init(void)
+int __init acpi_wakeup_device_init(void)
 {
 	struct list_head *node, *next;
 
-	if (acpi_disabled)
-		return 0;
-
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev = container_of(node,
@@ -165,5 +162,3 @@ static int __init acpi_wakeup_device_init(void)
 	spin_unlock(&acpi_device_lock);
 	return 0;
 }
-
-late_initcall(acpi_wakeup_device_init);
-- 
1.6.0.6

