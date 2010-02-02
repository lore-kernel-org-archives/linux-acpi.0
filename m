From: akpm@linux-foundation.org
Subject: [patch 2/7] acpi: fix &&/|| confusion in acpi_evaluate_string() (in comment)
Date: Tue, 02 Feb 2010 14:37:55 -0800
Message-ID: <201002022237.o12Mbtwp018684@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49524 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932106Ab0BBWjA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2010 17:39:00 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, roel.kluin@gmail.com

From: Roel Kluin <roel.kluin@gmail.com>

This always evaluates to true.

It's between an #if 0 ... #endif.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/utils.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/utils.c~acpi-fix-confusion-in-acpi_evaluate_string-in-comment drivers/acpi/utils.c
--- a/drivers/acpi/utils.c~acpi-fix-confusion-in-acpi_evaluate_string-in-comment
+++ a/drivers/acpi/utils.c
@@ -312,7 +312,7 @@ acpi_evaluate_string(acpi_handle handle,
 	element = (acpi_object *) buffer.pointer;
 
 	if ((element->type != ACPI_TYPE_STRING)
-	    || (element->type != ACPI_TYPE_BUFFER)
+	    && (element->type != ACPI_TYPE_BUFFER)
 	    || !element->string.length) {
 		acpi_util_eval_error(handle, pathname, AE_BAD_DATA);
 		return AE_BAD_DATA;
_
