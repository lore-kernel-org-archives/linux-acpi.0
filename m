From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 11/16] acpi: memory leak in acpi_evaluate_integer()
Date: Sat, 13 May 2006 23:39:05 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F33B@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:9560 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932203AbWENDjI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 May 2006 23:39:08 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, vvs@sw.ru

applied.

thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Thursday, April 27, 2006 5:25 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; vvs@sw.ru
>Subject: [patch 11/16] acpi: memory leak in acpi_evaluate_integer()
>
>
>From: Vasily Averin <vvs@sw.ru>
>
>acpi_evaluate_integer() does not release allocated memory on 
>the error path.
>
>(akpm: this is what happens when one uses multiple `return' 
>statements...)
>
>Signed-off-by: Vasily Averin <vvs@sw.ru>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/utils.c |    2 ++
> 1 files changed, 2 insertions(+)
>
>diff -puN 
>drivers/acpi/utils.c~memory-leak-in-acpi_evaluate_integer 
>drivers/acpi/utils.c
>--- 
>devel/drivers/acpi/utils.c~memory-leak-in-acpi_evaluate_
>integer	2006-04-10 23:16:23.000000000 -0700
>+++ devel-akpm/drivers/acpi/utils.c	2006-04-10 
>23:16:23.000000000 -0700
>@@ -274,11 +274,13 @@ acpi_evaluate_integer(acpi_handle handle
> 	status = acpi_evaluate_object(handle, pathname, 
>arguments, &buffer);
> 	if (ACPI_FAILURE(status)) {
> 		acpi_util_eval_error(handle, pathname, status);
>+		kfree(element);
> 		return_ACPI_STATUS(status);
> 	}
> 
> 	if (element->type != ACPI_TYPE_INTEGER) {
> 		acpi_util_eval_error(handle, pathname, AE_BAD_DATA);
>+		kfree(element);
> 		return_ACPI_STATUS(AE_BAD_DATA);
> 	}
> 
>_
>
