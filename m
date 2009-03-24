From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 02/10] ACPI: call acpi_scan_init() explicitly rather than as
	initcall
Date: Tue, 24 Mar 2009 16:49:43 -0600
Message-ID: <20090324224943.1262.55850.stgit@bob.kio>
References: <20090324224834.1262.65260.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:35609 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbZCXWtp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 18:49:45 -0400
In-Reply-To: <20090324224834.1262.65260.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>Li Shaohua <shaohua.li@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

This patch makes acpi_init() call acpi_scan_init() directly.

Previously, both acpi_init() and acpi_scan_init() were subsys_initcalls,
and acpi_init() was called first based on the link order from the
makefile (bus.o before scan.o).

acpi_scan_init() registers the ACPI bus type, creates the root device,
and enumerates fixed-feature and namespace devices.  All of this must
be done after acpi_init(), and it's better to call acpi_scan_init()
explicitly rather than rely on the link ordering.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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
index 467e9d0..b7308ef 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1514,16 +1514,11 @@ static int acpi_bus_scan_fixed(struct acpi_device *root)
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
@@ -1556,5 +1551,3 @@ static int __init acpi_scan_init(void)
       Done:
 	return result;
 }
-
-subsys_initcall(acpi_scan_init);

