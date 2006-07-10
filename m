From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 3/5] acpi: do not abort method execution if asked to release not acquired mutex
Date: Sun, 9 Jul 2006 22:33:23 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECFA1C@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41481 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161303AbWGJCd1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 22:33:27 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>, bcollins@ubuntu.com, zulcss@gmail.com

NAK,
this patch hides, rather than fixes the issue.

-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Friday, July 07, 2006 2:53 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; Starikovskiy, 
>Alexey Y; bcollins@ubuntu.com; zulcss@gmail.com
>Subject: [patch 3/5] acpi: do not abort method execution if 
>asked to release not acquired mutex
>
>From:  Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
>
>See http://bugme.osdl.org/show_bug.cgi?id=6687
>Closes: #50088
>
>patch location:
>http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-d
>apper.git;a=commitdiff;h=202ddb5b6498af53e110f78edd41a217587c1ffb
>
>Signed-off-by: Chuck Short <zulcss@gmail.com>
>Signed-off-by: Ben Collins <bcollins@ubuntu.com>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/executer/exmutex.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff -puN 
>drivers/acpi/executer/exmutex.c~acpi-do-not-abort-method-execut
>ion-if-asked-to-release drivers/acpi/executer/exmutex.c
>--- 
>a/drivers/acpi/executer/exmutex.c~acpi-do-not-abort-method-exec
>ution-if-asked-to-release
>+++ a/drivers/acpi/executer/exmutex.c
>@@ -246,7 +246,7 @@ acpi_ex_release_mutex(union acpi_operand
> 		ACPI_ERROR((AE_INFO,
> 			    "Cannot release Mutex [%4.4s], not 
>acquired",
> 			    
>acpi_ut_get_node_name(obj_desc->mutex.node)));
>-		return_ACPI_STATUS(AE_AML_MUTEX_NOT_ACQUIRED);
>+		return_ACPI_STATUS(AE_OK);
> 	}
> 
> 	/* Sanity check -- we must have a valid thread ID */
>_
>
