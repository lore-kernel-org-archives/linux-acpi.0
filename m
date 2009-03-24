From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 04/10] ACPI: call acpi_power_init() explicitly rather than as
	initcall
Date: Tue, 24 Mar 2009 16:49:53 -0600
Message-ID: <20090324224953.1262.95978.stgit@bob.kio>
References: <20090324224834.1262.65260.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:34316 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532AbZCXWt4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 18:49:56 -0400
In-Reply-To: <20090324224834.1262.65260.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>Li Shaohua <shaohua.li@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

This patch makes acpi_init() call acpi_power_init() directly.
Previously, both were subsys_initcalls.  acpi_power_init()
must happen after acpi_init(), and it's better to call it
explicitly rather than rely on link ordering.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Zhao Yakui <yakui.zhao@intel.com>
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

