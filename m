From: akpm@linux-foundation.org
Subject: [patch 3/7] acpi: remove superfluous NULL pointer check from acpi_processor_get_throttling_info()
Date: Tue, 02 Feb 2010 14:37:55 -0800
Message-ID: <201002022237.o12MbuTg018687@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60387 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932103Ab0BBWjO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2010 17:39:14 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, bzolnier@gmail.com, corbet@lwn.net, error27@gmail.com, eteo@redhat.com, ming.m.lin@intel.com, robert.moore@intel.com

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Dan's list contains:

drivers/acpi/processor_throttling.c +1139 acpi_processor_get_throttling_info(11) warning: variable derefenced before check 'pr'

acpi_processor_get_throttling_info() is never called with pr == NULL.

[ bart: the potential NULL pointer dereference was finally fixed in
  (much later than mine) commit 5cfa245 but my patch is still valid ]

Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Eugene Teo <eteo@redhat.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Lin Ming <ming.m.lin@intel.com>
Cc: Bob Moore <robert.moore@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/processor_throttling.c |    3 ---
 1 file changed, 3 deletions(-)

diff -puN drivers/acpi/processor_throttling.c~acpi-remove-superfluous-null-pointer-check-from-acpi_processor_get_throttling_info drivers/acpi/processor_throttling.c
--- a/drivers/acpi/processor_throttling.c~acpi-remove-superfluous-null-pointer-check-from-acpi_processor_get_throttling_info
+++ a/drivers/acpi/processor_throttling.c
@@ -1133,9 +1133,6 @@ int acpi_processor_get_throttling_info(s
 	int result = 0;
 	struct acpi_processor_throttling *pthrottling;
 
-	if (!pr)
-		return -EINVAL;
-
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
 			  pr->throttling.address,
_
