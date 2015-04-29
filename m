From: Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: [PATCH] ACPI/sbshc: Add 5us delay to fix SBS hang on MacBook
Date: Wed, 29 Apr 2015 21:21:40 +0100
Message-ID: <20150429202140.GB25904@localhost>
References: <20150424012530.GA16763@localhost>
 <4435249.leKkNHm9IZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36497 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbD2UVp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Apr 2015 16:21:45 -0400
Received: by wizk4 with SMTP id k4so194355188wiz.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2015 13:21:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4435249.leKkNHm9IZ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

Regression in commit 7bc5a2bad0b8d9d1ac9f7b8b33150e4ddf197334
Author: Matthew Garrett <matthew.garrett@nebula.com>
Date:   Sat Sep 20 13:19:47 2014 +0200

    ACPI: Support _OSI("Darwin") correctly

Supporting _OSI("Darwin") caused the MacBook firmware to expose the SBS,
resulting in intermittent hangs of several minutes on boot, and failure
to detect or report the battery. Fix this by adding a 5us delay to the
start of each SMBUS transaction. This timing is the result of
experimentation - hangs were observed with 3us but never with 5us.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=94651
Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
---
 drivers/acpi/sbshc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 26e5b50..bf034f8 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/dmi.h>
 #include "sbshc.h"
 
 #define PREFIX "ACPI: "
@@ -87,6 +88,8 @@ enum acpi_smb_offset {
 	ACPI_SMB_ALARM_DATA = 0x26,	/* 2 bytes alarm data */
 };
 
+static bool macbook;
+
 static inline int smb_hc_read(struct acpi_smb_hc *hc, u8 address, u8 *data)
 {
 	return ec_read(hc->offset + address, data);
@@ -132,6 +135,8 @@ static int acpi_smbus_transaction(struct acpi_smb_hc *hc, u8 protocol,
 	}
 
 	mutex_lock(&hc->lock);
+	if (macbook)
+		udelay(5);
 	if (smb_hc_read(hc, ACPI_SMB_PROTOCOL, &temp))
 		goto end;
 	if (temp) {
@@ -257,12 +262,29 @@ extern int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
 			      void *data);
 
+static int macbook_dmi_match(const struct dmi_system_id *d)
+{
+	pr_debug("Detected MacBook, enabling workaround\n");
+	macbook = true;
+	return 0;
+}
+
+static struct dmi_system_id acpi_smbus_dmi_table[] = {
+	{ macbook_dmi_match, "Apple MacBook", {
+	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
+	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBook") },
+	},
+	{ },
+};
+
 static int acpi_smbus_hc_add(struct acpi_device *device)
 {
 	int status;
 	unsigned long long val;
 	struct acpi_smb_hc *hc;
 
+	dmi_check_system(acpi_smbus_dmi_table);
+
 	if (!device)
 		return -EINVAL;
 
-- 
2.1.4

