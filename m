From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 10/16] acpi_os_wait_semaphore(): don't complain about timeout
Date: Sat, 13 May 2006 23:33:30 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F338@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3925 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932203AbWENDde convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 May 2006 23:33:34 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com, Thomas Renninger <trenn@suse.de>

applied.

thanks,
-Len

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Thursday, April 27, 2006 5:25 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; bjorn.helgaas@hp.com
>Subject: [patch 10/16] acpi_os_wait_semaphore(): don't 
>complain about timeout
>
>
>From: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
>The ASL Acquire operator (17.5.1 in ACPI 3.0 spec) is allowed 
>to time out
>and return True without acquiring the semaphore.  There's no 
>indication in
>the spec that this is an actual error, so this message should be
>debug-only, as the message for successful acquisition is.
>
>This used to be an ACPI_DEBUG_PRINT, but it was mis-classified as
>ACPI_DB_ERROR rather than ACPI_DB_MUTEX, so it got swept up in Thomas'
>recent patch to enable ACPI error messages even without 
>CONFIG_ACPI_DEBUG.
>
>Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/osl.c |    2 +-
> 1 files changed, 1 insertion(+), 1 deletion(-)
>
>diff -puN 
>drivers/acpi/osl.c~acpi_os_wait_semaphore-dont-complain-about-t
>imeout drivers/acpi/osl.c
>--- 
>devel/drivers/acpi/osl.c~acpi_os_wait_semaphore-dont-complain-a
>bout-timeout	2006-04-10 23:16:23.000000000 -0700
>+++ devel-akpm/drivers/acpi/osl.c	2006-04-10 
>23:16:23.000000000 -0700
>@@ -817,7 +817,7 @@ acpi_status acpi_os_wait_semaphore(acpi_
> 	}
> 
> 	if (ACPI_FAILURE(status)) {
>-		ACPI_EXCEPTION((AE_INFO, status,
>+		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
> 				  "Failed to acquire 
>semaphore[%p|%d|%d], %s",
> 				  handle, units, timeout,
> 				  acpi_format_exception(status)));
>_
>
