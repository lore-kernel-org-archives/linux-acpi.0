From: al.stone@linaro.org
Subject: [PATCH 07/12] ACPI: do not reserve memory regions for some FADT entries in HW reduced mode
Date: Sat,  9 Nov 2013 18:36:17 -0700
Message-ID: <1384047382-20623-8-git-send-email-al.stone@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:39200 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576Ab3KJBgi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Nov 2013 20:36:38 -0500
Received: by mail-ie0-f170.google.com with SMTP id to1so464879ieb.15
        for <linux-acpi@vger.kernel.org>; Sat, 09 Nov 2013 17:36:38 -0800 (PST)
In-Reply-To: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Al Stone <al.stone@linaro.org>

From: Al Stone <ahs3@redhat.com>

Since some of the FADT fields reserved are not to be used by the OSPM,
do not map in the memory areas that the FADT fields reference.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/osl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 075545e..2750cb5 100644
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
@@ -209,6 +212,7 @@ static int __init acpi_reserve_resources(void)
 
 	return 0;
 }
+#endif
 device_initcall(acpi_reserve_resources);
 
 void acpi_os_printf(const char *fmt, ...)
@@ -1782,6 +1786,9 @@ static int __init acpi_no_auto_ssdt_setup(char *s)
 
 __setup("acpi_no_auto_ssdt", acpi_no_auto_ssdt_setup);
 
+#ifdef CONFIG_ACPI_REDUCED_HARDWARE
+acpi_status __init acpi_os_initialize(void) { return AE_OK; }
+#else
 acpi_status __init acpi_os_initialize(void)
 {
 	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
@@ -1791,6 +1798,7 @@ acpi_status __init acpi_os_initialize(void)
 
 	return AE_OK;
 }
+#endif
 
 acpi_status __init acpi_os_initialize1(void)
 {
-- 
1.8.3.1

