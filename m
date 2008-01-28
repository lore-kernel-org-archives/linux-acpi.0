From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] make acpi_dmi_dump() static
Date: Tue, 29 Jan 2008 00:10:12 +0200
Message-ID: <20080128221012.GL8767@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:47952 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759596AbYA1WJp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jan 2008 17:09:45 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

acpi_dmi_dump() can become static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
34e88971f02980a37695e73ed121fca32edc8519 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index e53fb51..db074f5 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1213,7 +1213,7 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
  *
  *	Returns 0 on success
  */
-int acpi_dmi_dump(void)
+static int acpi_dmi_dump(void)
 {
 
 	if (!dmi_available)

