From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ACPI: index off by one?
Date: Sun, 22 Feb 2009 02:54:29 +0100
Message-ID: <49A0B055.5060600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:44303 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbZBVBya (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Feb 2009 20:54:30 -0500
Received: by nf-out-0910.google.com with SMTP id d21so217497nfb.21
        for <linux-acpi@vger.kernel.org>; Sat, 21 Feb 2009 17:54:27 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Should maybe this be applied? please review.
--------------------------->8-------------8<------------------------------
When index equals ACPI_NAME_SIZE, that is still one too large.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index ae3dc10..232c80c 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -87,7 +87,7 @@ acpi_ns_build_external_path(struct acpi_namespace_node *node,
 	parent_node = node;
 	name_buffer[index] = 0;
 
-	while ((index > ACPI_NAME_SIZE) && (parent_node != acpi_gbl_root_node)) {
+	while ((index >= ACPI_NAME_SIZE) && (parent_node != acpi_gbl_root_node)) {
 		index -= ACPI_NAME_SIZE;
 
 		/* Put the name into the buffer */
