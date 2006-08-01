From: keith mannthey <kmannth@us.ibm.com>
Subject: Re: [Lhms-devel] [PATCH](memory hotplug) Fix acpi_get_node() when
	_PXM is not defined.
Date: Tue, 01 Aug 2006 11:22:52 -0700
Message-ID: <1154456573.6249.11.camel@keithlap>
References: <20060801222852.156A.Y-GOTO@jp.fujitsu.com>
Reply-To: kmannth@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:30656 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751768AbWHASW5
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Aug 2006 14:22:57 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k71IMvTQ011926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Tue, 1 Aug 2006 14:22:57 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k71IMumJ117704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Tue, 1 Aug 2006 12:22:56 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k71IMt2P014898
	for <linux-acpi@vger.kernel.org>; Tue, 1 Aug 2006 12:22:55 -0600
In-Reply-To: <20060801222852.156A.Y-GOTO@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, ACPI-ML <linux-acpi@vger.kernel.org>, Andi Kleen <ak@suse.de>, Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>

On Tue, 2006-08-01 at 22:34 +0900, Yasunori Goto wrote: 
> Hello.
> 
> This patch is to avoid returning negative value for node id if _PXM is not
> defined in ACPI's DSDT. There are 2 possible cases.
> 
>   1) The hot-add code is executed with NUMA kernel on NON-NUMA box.
>   2) Firmware expects only SRAT table's information to find pxm,
>      and it doesn't expect DSDT.
> 
> If -1 is returned for node id, kernel will touch no-pgdat address
> when hot-add is executed.
> 
> To fix case 2) exactly, kernel should search memory block information
> which cames from SRAT at boottime. But, it will be arch dependent code
> and it is not written for i386 and ia64 yet. And it will be post later.
> So, at least, kernel panic should be avoided on 2.6.18 by this patch.
> 
> This patch is for 2.6.18-rc3. And I tested this patch on my Tiger4 with
> hot-add emulation.
> 
> Please apply.

I would rather give the arch a chance to sort out what the node is.  

I don't think Linux should require the ACPI add event to contain the
_pxm information. (I don't see it required in the spec).  acpi_get_node
is only going to work with systems that implement the acpi table in this
way.  
 I think something like this might be better...

diff -urN linux-2.6.18-rc3-stock/drivers/acpi/acpi_memhotplug.c linux-2.6.17/drivers/acpi/acpi_memhotplug.c
--- linux-2.6.18-rc3-stock/drivers/acpi/acpi_memhotplug.c	2006-07-31 19:59:05.000000000 -0400
+++ linux-2.6.17/drivers/acpi/acpi_memhotplug.c	2006-08-01 13:56:03.000000000 -0400
@@ -241,6 +241,9 @@
 			continue;
 		}
 
+		if (node < 0)
+			node = memory_add_physaddr_to_nid(info->start_addr);
+
 		result = add_memory(node, info->start_addr, info->length);
 		if (result)
 			continue;



