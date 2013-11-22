From: al.stone@linaro.org
Subject: [PATCH v2 5/6] ACPI: do not reserve memory regions for some FADT entries in HW reduced mode
Date: Thu, 21 Nov 2013 17:41:54 -0700
Message-ID: <1385080915-23430-6-git-send-email-al.stone@linaro.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:64175 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab3KVAmO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2013 19:42:14 -0500
Received: by mail-pb0-f42.google.com with SMTP id uo5so531459pbc.15
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2013 16:42:14 -0800 (PST)
In-Reply-To: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>

From: Al Stone <al.stone@linaro.org>

Since some of the FADT fields reserved are not to be used by the OSPM
in the HW reduced mode, do not map in the memory areas that the FADT
fields reference.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/osl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 34cd2c5..3ac5076 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -160,6 +160,9 @@ static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 	return supported;
 }
 
+#ifdef CONFIG_ACPI_REDUCED_HARDWARE
+static int __init acpi_reserve_resources(void) { return 0; }
+#else
 static void __init acpi_request_region (struct acpi_generic_address *gas,
 	unsigned int length, char *desc)
 {
@@ -210,6 +213,7 @@ static int __init acpi_reserve_resources(void)
 	return 0;
 }
 device_initcall(acpi_reserve_resources);
+#endif
 
 void acpi_os_printf(const char *fmt, ...)
 {
@@ -1772,6 +1776,9 @@ static int __init acpi_no_auto_ssdt_setup(char *s)
 
 __setup("acpi_no_auto_ssdt", acpi_no_auto_ssdt_setup);
 
+#ifdef CONFIG_ACPI_REDUCED_HARDWARE
+acpi_status __init acpi_os_initialize(void) { return AE_OK; }
+#else
 acpi_status __init acpi_os_initialize(void)
 {
 	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
@@ -1781,6 +1788,7 @@ acpi_status __init acpi_os_initialize(void)
 
 	return AE_OK;
 }
+#endif
 
 acpi_status __init acpi_os_initialize1(void)
 {
-- 
1.8.3.1

