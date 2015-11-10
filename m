From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH v2 5/7] ACPI / x86: introduce acpi_os_readable() support
Date: Tue, 10 Nov 2015 10:46:45 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE640286726FA@shsmsx102.ccr.corp.intel.com>
References: <cover.1446790780.git.lv.zheng@intel.com>
 <cover.1447143067.git.lv.zheng@intel.com>
 <c54877289d7742727b2395147167590ed2f24d8a.1447143067.git.lv.zheng@intel.com>
 <36DF59CE26D8EE47B0655C516E9CE6402867258C@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8880 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbbKJKrX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2015 05:47:23 -0500
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402867258C@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: 'Lv Zheng' <zetalog@gmail.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>


> -----Original Message-----
> From: Chen, Yu C
> Sent: Tuesday, November 10, 2015 5:43 PM
> To: Zheng, Lv
> Cc: Lv Zheng; linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org;
> Wysocki, Rafael J; Brown, Len
> Subject: RE: [PATCH v2 5/7] ACPI / x86: introduce acpi_os_readable() support
> 
> Hi, Lv
> Sorry for my late feedback on the patch, one minor nit below:
> 
> > -----Original Message-----
> > From: Zheng, Lv
> > Sent: Tuesday, November 10, 2015 4:22 PM
> > To: Wysocki, Rafael J; Brown, Len
> > Cc: Zheng, Lv; Lv Zheng; linux-kernel@vger.kernel.org; linux-
> > acpi@vger.kernel.org; Chen, Yu C
> > Subject: [PATCH v2 5/7] ACPI / x86: introduce acpi_os_readable()
> > support
> >
> > From: Chen Yu <yu.c.chen@intel.com>
> >
> > This patch implements acpi_os_readable(). The function is used by ACPI
> > AML debugger to validate user specified pointers for the dumpable AML
> > operand objects.
> >
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > ---
> > +bool __acpi_memory_readable(void *pointer, size_t length) {
> > +	unsigned long start_pfn, end_pfn;
> > +
> We should only check the low memory, otherwise the highmem address
> might bring unexpected behavior in this function, I think we should add:
> 	if (pointer  >= PAGE_OFFSET)
> 		return false;
Should be :
	If (pointer < PAGE_OFFSET && pointer >= high_memory)
		return false;
> > +	start_pfn = page_to_pfn(virt_to_page(pointer));
> > +	end_pfn = page_to_pfn(virt_to_page(pointer + length));
> Convert pointer to char* first?
> end_pfn = page_to_pfn(virt_to_page((char*)pointer + length));
> 
> > +	/*
> > +	 * Since the acpi address is allocated by kmalloc, we only
> > +	 * need to consider the direct-mapping virtual address,
> > +	 * rather than the kmap/vmalloc/ioremap address.
> > +	 */
> > +	return pfn_range_is_mapped(start_pfn, end_pfn) ? true : false; }
> > +
> Thanks!
> 
> Best Regards,
> Yu
