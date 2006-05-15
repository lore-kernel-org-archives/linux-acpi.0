From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 13/16] ia64: acpi_memhotplug() fix
Date: Mon, 15 May 2006 02:22:30 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F500@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:11150 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932208AbWEOGWq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 May 2006 02:22:46 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com

applied
thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Thursday, April 27, 2006 5:25 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; 
>kamezawa.hiroyu@jp.fujitsu.com
>Subject: [patch 13/16] ia64: acpi_memhotplug() fix
>
>
>From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
>
>This export was necessary to compile acpi_memhotplug.c as module.
>
>Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> arch/ia64/mm/init.c |    2 ++
> 1 files changed, 2 insertions(+)
>
>diff -puN arch/ia64/mm/init.c~ia64-acpi_memhotplug-fix 
>arch/ia64/mm/init.c
>--- devel/arch/ia64/mm/init.c~ia64-acpi_memhotplug-fix	
>2006-04-10 23:16:26.000000000 -0700
>+++ devel-akpm/arch/ia64/mm/init.c	2006-04-10 
>23:16:26.000000000 -0700
>@@ -671,9 +671,11 @@ int add_memory(u64 start, u64 size)
> 
> 	return ret;
> }
>+EXPORT_SYMBOL_GPL(add_memory);
> 
> int remove_memory(u64 start, u64 size)
> {
> 	return -EINVAL;
> }
>+EXPORT_SYMBOL_GPL(remove_memory);
> #endif
>_
>
