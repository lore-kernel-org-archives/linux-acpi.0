From: akpm@osdl.org
Subject: [patch 05/19] make drivers/acpi/ec.c:ec_ecdt static
Date: Tue, 19 Dec 2006 12:56:12 -0800
Message-ID: <200612192056.kBJKuCfo010020@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:34688 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932965AbWLSVAH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:00:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bunk@stusta.de

From: Adrian Bunk <bunk@stusta.de>

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/ec.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/ec.c~make-drivers-acpi-eccec_ecdt-static drivers/acpi/ec.c
--- a/drivers/acpi/ec.c~make-drivers-acpi-eccec_ecdt-static
+++ a/drivers/acpi/ec.c
@@ -92,7 +92,7 @@ static struct acpi_driver acpi_ec_driver
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
-struct acpi_ec {
+static struct acpi_ec {
 	acpi_handle handle;
 	unsigned long uid;
 	unsigned long gpe;
_
