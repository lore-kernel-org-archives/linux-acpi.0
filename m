From: akpm@osdl.org
Subject: [patch 04/13] make drivers/acpi/bay.c:drive_bays static
Date: Mon, 04 Dec 2006 14:49:39 -0800
Message-ID: <200612042250.kB4Momco007361@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:51196 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967737AbWLDWy6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Dec 2006 17:54:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bunk@stusta.de

From: Adrian Bunk <bunk@stusta.de>

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/bay.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/bay.c~make-drivers-acpi-baycdrive_bays-static drivers/acpi/bay.c
--- a/drivers/acpi/bay.c~make-drivers-acpi-baycdrive_bays-static
+++ a/drivers/acpi/bay.c
@@ -70,7 +70,7 @@ struct bay {
 	struct proc_dir_entry *proc;
 };
 
-LIST_HEAD(drive_bays);
+static LIST_HEAD(drive_bays);
 
 static struct proc_dir_entry *acpi_bay_dir;
 
_
