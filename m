From: Len Brown <len.brown@intel.com>
Subject: [PATCH 5/8] ACPI: add __init to acpi_initialize_subsystem()
Date: Sat,  2 Jun 2007 01:15:41 -0400
Message-ID: <11807613483187-git-send-email-len.brown@intel.com>
References: <1180761344795-git-send-email-len.brown@intel.com>
 <11807613453368-git-send-email-len.brown@intel.com>
 <11807613463371-git-send-email-len.brown@intel.com>
 <1180761346136-git-send-email-len.brown@intel.com>
 <11807613471928-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48596 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754406AbXFBFPs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Jun 2007 01:15:48 -0400
In-Reply-To: <11807613471928-git-send-email-len.brown@intel.com>
Message-Id: <dd272b5716a54afa33a69f2241284d8ec60b7892.1180761191.git.len.brown@intel.com>
In-Reply-To: <0efabac9b7c8535eeb199d2f16d3eb44dc4761b2.1180761191.git.len.brown@intel.com>
References: <0efabac9b7c8535eeb199d2f16d3eb44dc4761b2.1180761191.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

Add __init to:
acpi_initialize_subsystem() (and un-export it)
acpi_os_initialize()

Add __initdata to:
acpi_osl_dmi_table[]

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c               |    6 +++---
 drivers/acpi/utilities/utxface.c |    4 +---
 include/acpi/acpiosxf.h          |    2 +-
 include/acpi/acpixf.h            |    2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index e349879..58ceb18 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -86,7 +86,7 @@ int osi_linux;		/* disable _OSI(Linux) by default */
 
 
 #ifdef CONFIG_DMI
-static struct dmi_system_id acpi_osl_dmi_table[];
+static struct __initdata dmi_system_id acpi_osl_dmi_table[];
 #endif
 
 static void __init acpi_request_region (struct acpi_generic_address *addr,
@@ -137,7 +137,7 @@ static int __init acpi_reserve_resources(void)
 }
 device_initcall(acpi_reserve_resources);
 
-acpi_status acpi_os_initialize(void)
+acpi_status __init acpi_os_initialize(void)
 {
 	dmi_check_system(acpi_osl_dmi_table);
 	return AE_OK;
@@ -1243,7 +1243,7 @@ static int dmi_osi_linux(struct dmi_system_id *d)
 }
 #endif
 
-static struct dmi_system_id acpi_osl_dmi_table[] = {
+static struct dmi_system_id acpi_osl_dmi_table[] __initdata = {
 #ifdef	OSI_LINUX_ENABLED
 	/*
 	 * Boxes that need NOT _OSI(Linux)
diff --git a/drivers/acpi/utilities/utxface.c b/drivers/acpi/utilities/utxface.c
index e9a5780..2d49691 100644
--- a/drivers/acpi/utilities/utxface.c
+++ b/drivers/acpi/utilities/utxface.c
@@ -61,7 +61,7 @@ ACPI_MODULE_NAME("utxface")
  *              called, so any early initialization belongs here.
  *
  ******************************************************************************/
-acpi_status acpi_initialize_subsystem(void)
+acpi_status __init acpi_initialize_subsystem(void)
 {
 	acpi_status status;
 
@@ -108,8 +108,6 @@ acpi_status acpi_initialize_subsystem(void)
 	return_ACPI_STATUS(status);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_initialize_subsystem)
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_enable_subsystem
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index de26ee1..ca882b8 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -78,7 +78,7 @@ struct acpi_signal_fatal_info {
 /*
  * OSL Initialization and shutdown primitives
  */
-acpi_status acpi_os_initialize(void);
+acpi_status __initdata acpi_os_initialize(void);
 
 acpi_status acpi_os_terminate(void);
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index e08f7df..b5cca5d 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -55,7 +55,7 @@ acpi_status
 acpi_initialize_tables(struct acpi_table_desc *initial_storage,
 		       u32 initial_table_count, u8 allow_resize);
 
-acpi_status acpi_initialize_subsystem(void);
+acpi_status __init acpi_initialize_subsystem(void);
 
 acpi_status acpi_enable_subsystem(u32 flags);
 
-- 
1.5.2.146.gb75c6
