From: Len Brown <lenb@kernel.org>
Subject: [PATCH 71/98] ACPI: call acpi_ec_init() explicitly rather than as
 initcall
Date: Sat, 28 Mar 2009 00:31:46 -0400
Message-ID: <a5f820feb54a59fcdaf4a67a6381ea1ddb36cc6e.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:46330 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673AbZC1Edf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:35 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH70025L8NWDPY1@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:33 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch makes acpi_init() call acpi_ec_init() directly.
Previously, both were subsys_initcalls.  acpi_ec_init()
must happen after acpi_init(), and it's better to call it
explicitly rather than rely on link ordering.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |    1 +
 drivers/acpi/ec.c       |    7 +------
 drivers/acpi/internal.h |    1 +
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index cdd11fd..9ca6837 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -880,6 +880,7 @@ static int __init acpi_init(void)
 	dmi_check_system(power_nocheck_dmi_table);
 
 	acpi_scan_init();
+	acpi_ec_init();
 	return result;
 }
 
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 2fe1506..bf88f18 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1069,13 +1069,10 @@ static struct acpi_driver acpi_ec_driver = {
 		},
 };
 
-static int __init acpi_ec_init(void)
+int __init acpi_ec_init(void)
 {
 	int result = 0;
 
-	if (acpi_disabled)
-		return 0;
-
 	acpi_ec_dir = proc_mkdir(ACPI_EC_CLASS, acpi_root_dir);
 	if (!acpi_ec_dir)
 		return -ENODEV;
@@ -1090,8 +1087,6 @@ static int __init acpi_ec_init(void)
 	return result;
 }
 
-subsys_initcall(acpi_ec_init);
-
 /* EC driver currently not unloadable */
 #if 0
 static void __exit acpi_ec_exit(void)
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 28042c0..fad8e38 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -17,6 +17,7 @@ extern int acpi_power_nocheck;
 /* --------------------------------------------------------------------------
                                   Embedded Controller
    -------------------------------------------------------------------------- */
+int acpi_ec_init(void);
 int acpi_ec_ecdt_probe(void);
 int acpi_boot_ec_enable(void);
 
-- 
1.6.0.6

