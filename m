From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 09/10] ACPI: call acpi_wakeup_device_init() explicitly rather
	than as initcall
Date: Tue, 24 Mar 2009 16:50:19 -0600
Message-ID: <20090324225019.1262.8899.stgit@bob.kio>
References: <20090324224834.1262.65260.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:39198 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481AbZCXWuV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 18:50:21 -0400
In-Reply-To: <20090324224834.1262.65260.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>Li Shaohua <shaohua.li@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

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

