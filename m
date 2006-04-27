From: akpm@osdl.org
Subject: [patch 10/16] acpi_os_wait_semaphore(): don't complain about timeout
Date: Thu, 27 Apr 2006 02:25:09 -0700
Message-ID: <200604270926.k3R9QbLg025099@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:44749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965010AbWD0J0k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Apr 2006 05:26:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bjorn.helgaas@hp.com


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

The ASL Acquire operator (17.5.1 in ACPI 3.0 spec) is allowed to time out
and return True without acquiring the semaphore.  There's no indication in
the spec that this is an actual error, so this message should be
debug-only, as the message for successful acquisition is.

This used to be an ACPI_DEBUG_PRINT, but it was mis-classified as
ACPI_DB_ERROR rather than ACPI_DB_MUTEX, so it got swept up in Thomas'
recent patch to enable ACPI error messages even without CONFIG_ACPI_DEBUG.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/osl.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/osl.c~acpi_os_wait_semaphore-dont-complain-about-timeout drivers/acpi/osl.c
--- devel/drivers/acpi/osl.c~acpi_os_wait_semaphore-dont-complain-about-timeout	2006-04-10 23:16:23.000000000 -0700
+++ devel-akpm/drivers/acpi/osl.c	2006-04-10 23:16:23.000000000 -0700
@@ -817,7 +817,7 @@ acpi_status acpi_os_wait_semaphore(acpi_
 	}
 
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status,
+		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
 				  "Failed to acquire semaphore[%p|%d|%d], %s",
 				  handle, units, timeout,
 				  acpi_format_exception(status)));
_
