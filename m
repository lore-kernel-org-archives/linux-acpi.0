From: Len Brown <lenb@kernel.org>
Subject: [PATCH 73/98] ACPI: call acpi_system_init() explicitly rather than as
 initcall
Date: Sat, 28 Mar 2009 00:31:48 -0400
Message-ID: <141a0af3cab7de690816b17aad1682050219f774.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50052 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101AbZC1Edf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:35 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700EL98NXA271@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:34 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch makes acpi_init() call acpi_system_init() directly.
Previously, both were subsys_initcalls.  acpi_system_init()
must happen after acpi_init(), and it's better to call it
explicitly rather than rely on link ordering.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |    1 +
 drivers/acpi/internal.h |    1 +
 drivers/acpi/system.c   |    9 ++-------
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 946610f..c133072 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -882,6 +882,7 @@ static int __init acpi_init(void)
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_power_init();
+	acpi_system_init();
 	return result;
 }
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index a8178ad..4a35f6e 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -1,6 +1,7 @@
 /* For use by Linux/ACPI infrastructure, not drivers */
 
 int acpi_scan_init(void);
+int acpi_system_init(void);
 
 /* --------------------------------------------------------------------------
                                   Power Resource
diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index 391d035..3b88981 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -571,12 +571,9 @@ static int acpi_system_procfs_init(void)
 }
 #endif
 
-static int __init acpi_system_init(void)
+int __init acpi_system_init(void)
 {
-	int result = 0;
-
-	if (acpi_disabled)
-		return 0;
+	int result;
 
 	result = acpi_system_procfs_init();
 	if (result)
@@ -586,5 +583,3 @@ static int __init acpi_system_init(void)
 
 	return result;
 }
-
-subsys_initcall(acpi_system_init);
-- 
1.6.0.6

