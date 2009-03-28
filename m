From: Len Brown <lenb@kernel.org>
Subject: [PATCH 72/98] ACPI: call acpi_power_init() explicitly rather than as
 initcall
Date: Sat, 28 Mar 2009 00:31:47 -0400
Message-ID: <44515374cba9e46d5622256b43eb06b9c349cee1.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:8461 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbZC1Edk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:40 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700BF18NWHWBK@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:33 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch makes acpi_init() call acpi_power_init() directly.
Previously, both were subsys_initcalls.  acpi_power_init()
must happen after acpi_init(), and it's better to call it
explicitly rather than rely on link ordering.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |    1 +
 drivers/acpi/internal.h |    2 +-
 drivers/acpi/power.c    |    8 +-------
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9ca6837..946610f 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -881,6 +881,7 @@ static int __init acpi_init(void)
 
 	acpi_scan_init();
 	acpi_ec_init();
+	acpi_power_init();
 	return result;
 }
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index fad8e38..a8178ad 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -5,7 +5,7 @@ int acpi_scan_init(void);
 /* --------------------------------------------------------------------------
                                   Power Resource
    -------------------------------------------------------------------------- */
-
+int acpi_power_init(void);
 int acpi_device_sleep_wake(struct acpi_device *dev,
                            int enable, int sleep_state, int dev_state);
 int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state);
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index c926e7d..11968ba 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -773,14 +773,10 @@ static int acpi_power_resume(struct acpi_device *device)
 	return 0;
 }
 
-static int __init acpi_power_init(void)
+int __init acpi_power_init(void)
 {
 	int result = 0;
 
-
-	if (acpi_disabled)
-		return 0;
-
 	INIT_LIST_HEAD(&acpi_power_resource_list);
 
 	acpi_power_dir = proc_mkdir(ACPI_POWER_CLASS, acpi_root_dir);
@@ -795,5 +791,3 @@ static int __init acpi_power_init(void)
 
 	return 0;
 }
-
-subsys_initcall(acpi_power_init);
-- 
1.6.0.6

