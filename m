From: Len Brown <lenb@kernel.org>
Subject: [PATCH 70/98] ACPI: call acpi_scan_init() explicitly rather than as
 initcall
Date: Sat, 28 Mar 2009 00:31:45 -0400
Message-ID: <e747f274951507b5a0850155c3d709e26d20de5b.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:34985 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbZC1Edf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:35 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700KK28NUYMU6@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:31 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch makes acpi_init() call acpi_scan_init() directly.

Previously, both acpi_init() and acpi_scan_init() were subsys_initcalls,
and acpi_init() was called first based on the link order from the
makefile (bus.o before scan.o).

acpi_scan_init() registers the ACPI bus type, creates the root device,
and enumerates fixed-feature and namespace devices.  All of this must
be done after acpi_init(), and it's better to call acpi_scan_init()
explicitly rather than rely on the link ordering.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |    2 ++
 drivers/acpi/internal.h |    2 ++
 drivers/acpi/scan.c     |    9 +--------
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index bdeed39..cdd11fd 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -878,6 +878,8 @@ static int __init acpi_init(void)
 	 * will be disabled in the course of device power transistion.
 	 */
 	dmi_check_system(power_nocheck_dmi_table);
+
+	acpi_scan_init();
 	return result;
 }
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 4aee4a2..28042c0 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -1,5 +1,7 @@
 /* For use by Linux/ACPI infrastructure, not drivers */
 
+int acpi_scan_init(void);
+
 /* --------------------------------------------------------------------------
                                   Power Resource
    -------------------------------------------------------------------------- */
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2f04cd1..c548231 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1526,16 +1526,11 @@ static int acpi_bus_scan_fixed(struct acpi_device *root)
 	return result;
 }
 
-
-static int __init acpi_scan_init(void)
+int __init acpi_scan_init(void)
 {
 	int result;
 	struct acpi_bus_ops ops;
 
-
-	if (acpi_disabled)
-		return 0;
-
 	memset(&ops, 0, sizeof(ops));
 	ops.acpi_op_add = 1;
 	ops.acpi_op_start = 1;
@@ -1568,5 +1563,3 @@ static int __init acpi_scan_init(void)
       Done:
 	return result;
 }
-
-subsys_initcall(acpi_scan_init);
-- 
1.6.0.6

