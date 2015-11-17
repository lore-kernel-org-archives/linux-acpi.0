From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 5/7] ACPI / x86: introduce acpi_os_readable() support
Date: Tue, 17 Nov 2015 01:49:35 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BADF027@SHSMSX101.ccr.corp.intel.com>
References: <cover.1446790780.git.lv.zheng@intel.com>
 <cover.1447143067.git.lv.zheng@intel.com>
 <c54877289d7742727b2395147167590ed2f24d8a.1447143067.git.lv.zheng@intel.com>
 <36DF59CE26D8EE47B0655C516E9CE6402867258C@shsmsx102.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BADD796@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BADD796@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: 'Lv Zheng' <zetalog@gmail.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi, Yu

> From: Zheng, Lv
> Sent: Wednesday, November 11, 2015 1:07 PM
> 
> Hi, Yu
> 
> > From: Chen, Yu C
> > Sent: Tuesday, November 10, 2015 5:43 PM
> >
> > Hi, Lv
> > Sorry for my late feedback on the patch, one minor nit below:
> >
> > > From: Zheng, Lv
> > > Sent: Tuesday, November 10, 2015 4:22 PM
> > >
> > > From: Chen Yu <yu.c.chen@intel.com>
> > >
> > > This patch implements acpi_os_readable(). The function is used by ACPI AML
> > > debugger to validate user specified pointers for the dumpable AML operand
> > > objects.
> > >
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > > ---
> > > +bool __acpi_memory_readable(void *pointer, size_t length) {
> > > +	unsigned long start_pfn, end_pfn;
> > > +
> > We should only check the low memory, otherwise the highmem address might
> > bring unexpected behavior in this function, I think we should add:
> > 	if (pointer  >= PAGE_OFFSET)
> > 		return false;
> 
> I think pfn_range_is_mapped() can ensure this.
> If you want to add some sanity checks, IMO, virt_addr_valid() could be better.

I confirmed that pfn_range_is_mapped() doesn't cover this for us.
We need such a check or enhance this in pfn_range_is_mapped().
I'll remove this patch from this patchset and re-send the rest of the patches in this patchset as v3.
For acpi_os_readable() support, I'll create a separate RFC patchset with different approaches included.

Thanks and best regards
-Lv

> 
> > > +	start_pfn = page_to_pfn(virt_to_page(pointer));
> > > +	end_pfn = page_to_pfn(virt_to_page(pointer + length));
> > Convert pointer to char* first?
> > end_pfn = page_to_pfn(virt_to_page((char*)pointer + length));
> 
> Either a compiler supports such a conversion or a compiler ends up fatal error by complaining unknown sizeof(void *).
> So there is no need to do this here as the build test has passed.
> 
> Thanks and best regards
> -Lv
> 
> >
> > > +	/*
> > > +	 * Since the acpi address is allocated by kmalloc, we only
> > > +	 * need to consider the direct-mapping virtual address,
> > > +	 * rather than the kmap/vmalloc/ioremap address.
> > > +	 */
> > > +	return pfn_range_is_mapped(start_pfn, end_pfn) ? true : false; }
> > > +
> > Thanks!
> >
> > Best Regards,
> > Yu
