From: "Joshua C." <joshuacov@googlemail.com>
Subject: How can a patch be merged upstream?
Date: Mon, 25 Aug 2008 16:26:57 +0200
Message-ID: <5f6f8c5f0808250726h4649ddferff1be82c7d6203ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:39674 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbYHYO07 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Aug 2008 10:26:59 -0400
Received: by nf-out-0910.google.com with SMTP id d3so746599nfc.21
        for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2008 07:26:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I (and others with acer aspire 5050series laptops) have a broken bios
which resulted in kernel panic. Reported the bug
http://bugzilla.kernel.org/show_bug.cgi?id=10237 and
http://bugzilla.kernel.org/show_bug.cgi?id=8953 and a patch was
written about it. Can/When will this be merged upstream? Any arguments
against this as a hardware/platform solution?

Here is the patch from Zhao Yakui <yakui.zhao@intel.com>

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>

---
 drivers/acpi/ec.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -835,8 +835,19 @@ static int ec_install_handlers(struct ac
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
+			printk(KERN_ERR "Fail in evaluating _REG object."
+				" It is broken BIOS.\n");
+		} else {
+			acpi_remove_gpe_handler(NULL, ec->gpe,
+				&acpi_ec_gpe_handler);
+			return -ENODEV;
+		}
 	}

 	ec->handlers_installed = 1;
