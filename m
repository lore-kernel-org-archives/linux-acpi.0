From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/4] ACPI 2.0 / ECDT: Enable correct ECDT initialization order
Date: Thu, 24 Mar 2016 10:43:00 +0800
Message-ID: <26c9b1a901dc3f6a458b4404be92b096421c4575.1458786874.git.lv.zheng@intel.com>
References: <c87e72bebfbfbb35c4f14100c0a0a5e19a6ec5ed> <cover.1458786874.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458786874.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

With wrong ECDT fixes reverted, it is possible to put ECDT probing before
acpi_enable_subsystem().

But the ultimate purpose of ECDT re-enabling is to put the ECDT probing
before the namespace initialization (acpi_load_tables()). This patch
achieves this with protections so that we can enable it later when all
necessary corrections are upstreamed.

Link 4: https://bugzilla.kernel.org/show_bug.cgi?id=112911
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
---
 drivers/acpi/bus.c |   39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 0e85678..2e3ffb1 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -925,11 +925,13 @@ void __init acpi_early_init(void)
 		goto error0;
 	}
 
-	status = acpi_load_tables();
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX
-		       "Unable to load the System Description Tables\n");
-		goto error0;
+	if (acpi_gbl_group_module_level_code) {
+		status = acpi_load_tables();
+		if (ACPI_FAILURE(status)) {
+			printk(KERN_ERR PREFIX
+			       "Unable to load the System Description Tables\n");
+			goto error0;
+		}
 	}
 
 #ifdef CONFIG_X86
@@ -995,17 +997,10 @@ static int __init acpi_bus_init(void)
 
 	acpi_os_initialize1();
 
-	status = acpi_enable_subsystem(ACPI_NO_ACPI_ENABLE);
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX
-		       "Unable to start the ACPI Interpreter\n");
-		goto error1;
-	}
-
 	/*
 	 * ACPI 2.0 requires the EC driver to be loaded and work before
-	 * the EC device is found in the namespace (i.e. before acpi_initialize_objects()
-	 * is called).
+	 * the EC device is found in the namespace (i.e. before
+	 * acpi_load_tables() is called).
 	 *
 	 * This is accomplished by looking for the ECDT table, and getting
 	 * the EC parameters out of that.
@@ -1013,6 +1008,22 @@ static int __init acpi_bus_init(void)
 	status = acpi_ec_ecdt_probe();
 	/* Ignore result. Not having an ECDT is not fatal. */
 
+	if (!acpi_gbl_group_module_level_code) {
+		status = acpi_load_tables();
+		if (ACPI_FAILURE(status)) {
+			printk(KERN_ERR PREFIX
+			       "Unable to load the System Description Tables\n");
+			goto error1;
+		}
+	}
+
+	status = acpi_enable_subsystem(ACPI_NO_ACPI_ENABLE);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR PREFIX
+		       "Unable to start the ACPI Interpreter\n");
+		goto error1;
+	}
+
 	status = acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Unable to initialize ACPI objects\n");
-- 
1.7.10
