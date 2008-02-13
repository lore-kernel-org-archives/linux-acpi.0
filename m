From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] make acpi_no_initrd_override_setup() static
Date: Wed, 13 Feb 2008 23:30:00 +0200
Message-ID: <20080213213000.GS3383@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:50788 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763468AbYBMVaQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Feb 2008 16:30:16 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?B?w4lyaWM=?= Piel <Eric.Piel@tremplin-utc.net>, Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

acpi_no_initrd_override_setup() can become static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
1778953a9751288a9bee1d4f6a8b4f3d22e37f52 diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 0c37c65..b72a7f1 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -419,7 +419,7 @@ acpi_os_table_override(struct acpi_table_header * existing_table,
 }
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
-int __init acpi_no_initrd_override_setup(char *s)
+static int __init acpi_no_initrd_override_setup(char *s)
 {
 	acpi_no_initrd_override = 1;
 	return 1;

