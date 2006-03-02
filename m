From: "Brown, Len" <len.brown@intel.com>
Subject: acpi_os_map_memory()/acpi_os_unmap_memory()
Date: Wed, 1 Mar 2006 22:10:53 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB23@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:34481 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750870AbWCBDK5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2006 22:10:57 -0500
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr004.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k223AuCw003552
	for <linux-acpi@vger.kernel.org>; Thu, 2 Mar 2006 03:10:56 GMT
Received: from fmsmsxvs042.fm.intel.com (fmsmsxvs042.fm.intel.com [132.233.42.128])
	by orsfmr100.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k223AupL027818
	for <linux-acpi@vger.kernel.org>; Thu, 2 Mar 2006 03:10:56 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs042.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006030119105623126
 for <linux-acpi@vger.kernel.org>; Wed, 01 Mar 2006 19:10:56 -0800
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-acpi@vger.kernel.org

Andy,
Do you recall the history of how this pair of routines got this way?

First problem is something mapped with efi_enabled may not use ioremap,
but the then un-map on the same region uses iounmap().

Second issue is that it isn't clear that ioremap() is the right way
to go for a general purpose memory mapper.  acpi_os_map_memory()
is used by the core to map the tables and also to support
AML operation region reads and writes which can be memory
or memory mapped registers.

thanks,
-Len



2002/03/14 agrover            | acpi_status
2005/08/05 len.brown          | acpi_os_map_memory(acpi_physical_address
phys, acpi_size size,
2005/08/05 len.brown          | 		   void __iomem ** virt)
2002/03/14 agrover            | {
2003/12/29 akpm               | 	if (efi_enabled) {
2003/12/29 akpm               | 		if (EFI_MEMORY_WB &
efi_mem_attributes(phys)) {
2005/08/05 len.brown          | 			*virt = (void
__iomem *)phys_to_virt(phys);
2003/12/29 akpm               | 		} else {
2003/12/29 akpm               | 			*virt =
ioremap(phys, size);
2003/12/29 akpm               | 		}
2002/10/01 agrover            | 	} else {
2003/12/29 akpm               | 		if (phys > ULONG_MAX) {
2003/12/29 akpm               | 			printk(KERN_ERR
PREFIX "Cannot map memory that high\n");
2003/12/29 akpm               | 			return
AE_BAD_PARAMETER;
2003/12/29 akpm               | 		}
2003/12/29 akpm               | 		/*
2005/08/05 len.brown          | 		 * ioremap checks to
ensure this is in reserved space
2005/08/05 len.brown          | 		 */
2005/08/05 len.brown          | 		*virt =
ioremap((unsigned long)phys, size);
2002/03/14 agrover            | 	}
2002/05/29 agrover            | 
2002/03/14 agrover            | 	if (!*virt)
2002/03/14 agrover            | 		return AE_NO_MEMORY;
2002/03/14 agrover            | 
2002/03/14 agrover            | 	return AE_OK;
2002/03/14 agrover            | }
2006/01/08 kjhall             | EXPORT_SYMBOL_GPL(acpi_os_map_memory);
2002/03/14 agrover            | 
2005/08/05 len.brown          | void acpi_os_unmap_memory(void __iomem *
virt, acpi_size size)
2002/03/14 agrover            | {
2002/03/14 agrover            | 	iounmap(virt);
