From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/14] ACPI 2.0 / ECDT: Enable correct ECDT initialization order
Date: Sat,  6 Feb 2016 11:53:58 +0800
Message-ID: <2dfd3ba26230a3e9e084e8e2503736c12640b3f1.1454730660.git.lv.zheng@intel.com>
References: <cover.1454730659.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454730659.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

With wrong ECDT fixes reversed, it is able to put ECDT probing before
acpi_enable_subsystem().

But the ultimate purpose of ECDT re-enabling is to put the ECDT probing
before the namespace initialization (acpi_load_tables()). This patch
achieves this with protections so that we can enable it later when all
necessary corrections are upstreamed.

Signed-off-by: Lv Zheng  <lv.zheng@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/bus.c |   39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 891c42d..8752860 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -911,11 +911,13 @@ void __init acpi_early_init(void)
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
@@ -981,17 +983,10 @@ static int __init acpi_bus_init(void)
 
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
@@ -999,6 +994,22 @@ static int __init acpi_bus_init(void)
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
