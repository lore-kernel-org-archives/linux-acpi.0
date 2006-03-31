From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: acpi_os_wait_semaphore(): don't complain about timeout
Date: Fri, 31 Mar 2006 15:33:25 -0700
Message-ID: <200603311533.26023.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:46545 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751459AbWCaWdc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Mar 2006 17:33:32 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Thomas Renniger <trenn@suse.de>

The ASL Acquire operator (17.5.1 in ACPI 3.0 spec) is allowed to
time out and return True without acquiring the semaphore.  There's
no indication in the spec that this is an actual error, so this
message should be debug-only, as the message for successful acquisition
is.

This used to be an ACPI_DEBUG_PRINT, but it was mis-classified as
ACPI_DB_ERROR rather than ACPI_DB_MUTEX, so it got swept up in
Thomas' recent patch to enable ACPI error messages even without
CONFIG_ACPI_DEBUG.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm5/drivers/acpi/osl.c
===================================================================
--- work-mm5.orig/drivers/acpi/osl.c	2006-03-23 10:22:40.000000000 -0700
+++ work-mm5/drivers/acpi/osl.c	2006-03-31 14:40:44.000000000 -0700
@@ -816,7 +816,7 @@
 	}
 
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status,
+		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
 				  "Failed to acquire semaphore[%p|%d|%d], %s",
 				  handle, units, timeout,
 				  acpi_format_exception(status)));
