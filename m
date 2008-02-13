From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] make acpi_find_dsdt_initrd() static
Date: Wed, 13 Feb 2008 23:29:58 +0200
Message-ID: <20080213212958.GR3383@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:47485 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754174AbYBMVaO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Feb 2008 16:30:14 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Markus Gaugusch <dsdt@gaugusch.at>, Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

acpi_find_dsdt_initrd() can become static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
98cd5a55aff78aaacc3f8615164e2247f3bbed70 diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 34b3386..0c37c65 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -325,7 +325,7 @@ acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
 }
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
-struct acpi_table_header *acpi_find_dsdt_initrd(void)
+static struct acpi_table_header *acpi_find_dsdt_initrd(void)
 {
 	struct file *firmware_file;
 	mm_segment_t oldfs;

