From: akpm@osdl.org
Subject: [patch 06/13] make drivers/acpi/ec.c:ec_ecdt static
Date: Mon, 04 Dec 2006 14:49:40 -0800
Message-ID: <200612042250.kB4Mondx007369@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:51092 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967729AbWLDWyo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Dec 2006 17:54:44 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bunk@stusta.de

From: Adrian Bunk <bunk@stusta.de>

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/ec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/ec.c~make-drivers-acpi-eccec_ecdt-static drivers/acpi/ec.c
--- a/drivers/acpi/ec.c~make-drivers-acpi-eccec_ecdt-static
+++ a/drivers/acpi/ec.c
@@ -93,7 +93,7 @@ static struct acpi_driver acpi_ec_driver
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
-struct acpi_ec {
+static struct acpi_ec {
 	acpi_handle handle;
 	unsigned long uid;
 	unsigned long gpe_bit;
_
