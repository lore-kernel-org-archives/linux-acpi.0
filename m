From: akpm@linux-foundation.org
Subject: [patch 17/26] asus-laptop: return proper error for store_ledd if write_acpi_int fail
Date: Tue, 20 Jul 2010 15:19:48 -0700
Message-ID: <201007202219.o6KMJmJg021061@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38260 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932953Ab0GTWkb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:40:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, alan-jenkins@tuffmail.co.uk, corentincj@iksaif.net, mjg@redhat.com

From: Axel Lin <axel.lin@gmail.com>

In current implementation, store_ledd() does not return error if
write_acpi_int fail.  This patch fixes it by return -ENODEV if
write_acpi_int fail.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Corentin Chary <corentincj@iksaif.net>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/asus-laptop.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/platform/x86/asus-laptop.c~asus-laptop-return-proper-error-for-store_ledd-if-write_acpi_int-fail drivers/platform/x86/asus-laptop.c
--- a/drivers/platform/x86/asus-laptop.c~asus-laptop-return-proper-error-for-store_ledd-if-write_acpi_int-fail
+++ a/drivers/platform/x86/asus-laptop.c
@@ -796,10 +796,11 @@ static ssize_t store_ledd(struct device 
 
 	rv = parse_arg(buf, count, &value);
 	if (rv > 0) {
-		if (write_acpi_int(asus->handle, METHOD_LEDD, value))
+		if (write_acpi_int(asus->handle, METHOD_LEDD, value)) {
 			pr_warning("LED display write failed\n");
-		else
-			asus->ledd_status = (u32) value;
+			return -ENODEV;
+		}
+		asus->ledd_status = (u32) value;
 	}
 	return rv;
 }
_
