From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 03/10] ACPI: call acpi_ec_init() explicitly rather than as
	initcall
Date: Tue, 24 Mar 2009 16:49:48 -0600
Message-ID: <20090324224948.1262.17270.stgit@bob.kio>
References: <20090324224834.1262.65260.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:41611 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbZCXWtv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 18:49:51 -0400
In-Reply-To: <20090324224834.1262.65260.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>Li Shaohua <shaohua.li@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

This patch makes acpi_init() call acpi_ec_init() directly.
Previously, both were subsys_initcalls.  acpi_ec_init()
must happen after acpi_init(), and it's better to call it
explicitly rather than rely on link ordering.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Alexey Starikovskiy <astarikovskiy@suse.de>
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
 

