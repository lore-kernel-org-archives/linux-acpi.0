From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 05/10] ACPI: call acpi_system_init() explicitly rather than as
	initcall
Date: Tue, 24 Mar 2009 16:49:58 -0600
Message-ID: <20090324224958.1262.35073.stgit@bob.kio>
References: <20090324224834.1262.65260.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:20140 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbZCXWuA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 18:50:00 -0400
In-Reply-To: <20090324224834.1262.65260.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>Li Shaohua <shaohua.li@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

This patch makes acpi_init() call acpi_system_init() directly.
Previously, both were subsys_initcalls.  acpi_system_init()
must happen after acpi_init(), and it's better to call it
explicitly rather than rely on link ordering.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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

