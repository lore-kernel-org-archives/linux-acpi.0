From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] increase ACPI_MAX_REFERENCE_COUNT for larger systems
Date: Thu, 21 Dec 2006 14:59:36 -0500
Message-ID: <200612211459.36486.lenb@kernel.org>
References: <1166721103.13323.12.camel@dchapman.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44950 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423067AbWLUUAL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Dec 2006 15:00:11 -0500
In-Reply-To: <1166721103.13323.12.camel@dchapman.boston.redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Doug Chapman <doug.chapman@hp.com>
Cc: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Thursday 21 December 2006 12:11, Doug Chapman wrote:
> We have some new larger ia64 systems in HP that trip over the
> ACPI_MAX_REFERENCE_COUNT limit which triggers a large number of these
> debug messages:
> 
> ACPI Warning (utdelete-0397): Large Reference Count (XXX) in object e0000a0ff6797ab0  [20060707]
> 
> This was increased once in the past as described in this very brief thread:
> 
> http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg00890.html
> 
> 
> signed-off-by: Doug Chapman <doug.chapman@hp.com>
> 
> --- linux-2.6.20-rc1/include/acpi/acconfig.h.prev	2006-12-21 12:06:56.000000000 -0500
> +++ linux-2.6.20-rc1/include/acpi/acconfig.h	2006-12-21 12:07:49.000000000 -0500
> @@ -105,7 +105,7 @@
>  
>  /* Maximum object reference count (detects object deletion issues) */
>  
> -#define ACPI_MAX_REFERENCE_COUNT        0x800
> +#define ACPI_MAX_REFERENCE_COUNT        0x1000
>  
>  /* Size of cached memory mapping for system memory operation region */
>  
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
