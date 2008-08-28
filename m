From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH]  ACPI:  Ignore AE_NOT_FOUND error of EC _REG method and
	continue to initialize EC
Date: Thu, 28 Aug 2008 09:29:04 +0800
Message-ID: <1219886944.4116.64.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59545 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758AbYH1BNu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Aug 2008 21:13:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: AndiKleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, joshuacov@googlemail.com

Subject:ACPI: Ignore AE_NOT_FOUND error of EC _REG method and continue to initialize EC 
From: Zhao Yakui <yakui.zhao@intel.com>

On some broken BIOS the ACPI object in EC _REG method can't be found in
ACPI namespace, which causes that the status code of AE_NOT_FOUND is returned by
the EC _REG object. In such case the EC device can't be initialized correctly, 
which causes that battery/AC adapter can't work normally. As the EC address
space handler is not removed and the memory pointed by its input argument is
already free, sometimes the kernel will also be panic when EC internal register
is still accessed. But the windows can work well on such broken BIOS.

Maybe it will be reasonable that OS ignores the AE_NOT_FOUND error 
returned by the EC _REG object and continues to initialize EC device 
on some broken BIOS. 
For example: the ACPI object in EC _REG method can't be found and status error
code is AE_NOT_FOUND. 

http://bugzilla.kernel.org/show_bug.cgi?id=8953
http://bugzilla.kernel.org/show_bug.cgi?id=10237

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>

---
 drivers/acpi/ec.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -862,8 +862,19 @@ static int ec_install_handlers(struct ac
 						    &acpi_ec_space_handler,
 						    NULL, ec);
 	if (ACPI_FAILURE(status)) {
-		acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
-		return -ENODEV;
+		if (status == AE_NOT_FOUND) {
+			/*
+			 * Maybe OS fails in evaluating the _REG object.
+			 * The AE_NOT_FOUND error will be ignored and OS
+			 * continue to initialize EC.
+			 */
+			printk(KERN_ERR "Fail in evaluating the _REG object"
+				" of EC device. Broken bios is suspected.\n");
+		} else {
+			acpi_remove_gpe_handler(NULL, ec->gpe,
+				&acpi_ec_gpe_handler);
+			return -ENODEV;
+		}
 	}
 
 	ec->handlers_installed = 1;


