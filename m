From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH resend] acpi: remove superfluous NULL pointer check from acpi_processor_get_throttling_info()
Date: Tue, 5 Jan 2010 20:17:08 +0100
Message-ID: <201001052017.08647.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:44615 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab0AETSs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2010 14:18:48 -0500
Received: by fxm25 with SMTP id 25so10105411fxm.21
        for <linux-acpi@vger.kernel.org>; Tue, 05 Jan 2010 11:18:47 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Dan Carpenter <error27@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Eugene Teo <eteo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

>From Dan's list:

drivers/acpi/processor_throttling.c +1139 acpi_processor_get_throttling_info(11) warning: variable derefenced before check 'pr'

acpi_processor_get_throttling_info() is never called with pr == NULL.

[ bart: the potential NULL pointer dereference was finally fixed in
  (much later than mine) commit 5cfa245 but my patch is still valid ]

Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Eugene Teo <eteo@redhat.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/acpi/processor_throttling.c |    3 ---
 1 file changed, 3 deletions(-)

Index: b/drivers/acpi/processor_throttling.c
===================================================================
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -1133,9 +1133,6 @@ int acpi_processor_get_throttling_info(s
 	int result = 0;
 	struct acpi_processor_throttling *pthrottling;
 
-	if (!pr)
-		return -EINVAL;
-
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
 			  pr->throttling.address,
