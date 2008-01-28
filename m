From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] ACPI: make struct osi_linux static
Date: Tue, 29 Jan 2008 00:10:15 +0200
Message-ID: <20080128221015.GM8767@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:52195 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757419AbYA1WJs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jan 2008 17:09:48 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

struct osi_linux can become static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
7cdce626bdef64e64e954839553f226ce9dd5b89 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index db074f5..55dccac 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -120,7 +120,7 @@ static char osi_additional_string[OSI_STRING_LENGTH_MAX];
  */
 #define OSI_LINUX_ENABLE 0
 
-struct osi_linux {
+static struct osi_linux {
 	unsigned int	enable:1;
 	unsigned int	dmi:1;
 	unsigned int	cmdline:1;

