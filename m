From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ACPI: Fix &&/|| confusion in acpi_evaluate_string() (in comment)
Date: Thu, 31 Dec 2009 12:56:54 +0100
Message-ID: <4B3C9186.3090904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:50398 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbZLaLxp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Dec 2009 06:53:45 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

This always evaluates to true.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/acpi/utils.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

It's between an #if 0 ... #endif.

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 811fec1..3495b43 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -312,7 +312,7 @@ acpi_evaluate_string(acpi_handle handle,
 	element = (acpi_object *) buffer.pointer;
 
 	if ((element->type != ACPI_TYPE_STRING)
-	    || (element->type != ACPI_TYPE_BUFFER)
+	    && (element->type != ACPI_TYPE_BUFFER)
 	    || !element->string.length) {
 		acpi_util_eval_error(handle, pathname, AE_BAD_DATA);
 		return AE_BAD_DATA;
