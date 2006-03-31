From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: acpi_os_wait_semaphore(): don't complain about timeout
Date: Fri, 31 Mar 2006 14:37:57 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E04DBA7A5@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16506 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751461AbWCaWh7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Mar 2006 17:37:59 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Thomas Renniger <trenn@suse.de>

This is correct.

Unfortunately, it is one of the problems with performing a global
replace of the ACPI_DEBUG_PRINT (WARNING/ERROR) with the non-debug
ACPI_ERROR and ACPI_WARNING, and it will take some time to shake out
these kinds of issues.



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> Sent: Friday, March 31, 2006 2:33 PM
> To: Brown, Len
> Cc: linux-acpi@vger.kernel.org; Andrew Morton; Thomas Renniger
> Subject: [ACPI] acpi_os_wait_semaphore(): don't complain about timeout
> 
> The ASL Acquire operator (17.5.1 in ACPI 3.0 spec) is allowed to
> time out and return True without acquiring the semaphore.  There's
> no indication in the spec that this is an actual error, so this
> message should be debug-only, as the message for successful
acquisition
> is.
> 
> This used to be an ACPI_DEBUG_PRINT, but it was mis-classified as
> ACPI_DB_ERROR rather than ACPI_DB_MUTEX, so it got swept up in
> Thomas' recent patch to enable ACPI error messages even without
> CONFIG_ACPI_DEBUG.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Index: work-mm5/drivers/acpi/osl.c
> ===================================================================
> --- work-mm5.orig/drivers/acpi/osl.c	2006-03-23 10:22:40.000000000 -
> 0700
> +++ work-mm5/drivers/acpi/osl.c	2006-03-31 14:40:44.000000000
-0700
> @@ -816,7 +816,7 @@
>  	}
> 
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status,
> +		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
>  				  "Failed to acquire
semaphore[%p|%d|%d], %s",
>  				  handle, units, timeout,
>  				  acpi_format_exception(status)));
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
