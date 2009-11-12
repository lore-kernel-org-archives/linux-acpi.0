From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] x86: make sure wakeup code is below 1M -v2
Date: Thu, 12 Nov 2009 15:14:27 +0800
Message-ID: <1258010067.3802.11.camel@localhost.localdomain>
References: <4AF7D820.5040503@kernel.org> <200911091315.13151.rjw@sisk.pl>
	 <4AFA210B.3020207@kernel.org>
	 <1257930767.31183.113.camel@localhost.localdomain>
	 <4AFB0B02.4050306@kernel.org>
	 <1257988632.31183.134.camel@localhost.localdomain>
	 <4AFB7D21.6050004@kernel.org>
	 <1257997072.3888.4.camel@localhost.localdomain>
	 <4AFB9B60.7010009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65035 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284AbZKLHP5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Nov 2009 02:15:57 -0500
In-Reply-To: <4AFB9B60.7010009@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Thu, 2009-11-12 at 13:21 +0800, Yinghai Lu wrote:
> ykzhao wrote:
> > On Thu, 2009-11-12 at 11:12 +0800, Yinghai Lu wrote:
> >> ykzhao wrote:
> >>> On Thu, 2009-11-12 at 03:05 +0800, Yinghai Lu wrote:
> >>>> ykzhao wrote:
> >>>>> On Wed, 2009-11-11 at 10:27 +0800, Yinghai Lu wrote:
> >>>>>> try to find_e820_area/reserve_early, and call acpi_reserve_memory early
> >>>>>>
> >>>>>> to get area is below 1M
> >>>>>>
> >>>>>> -v2: change function name to acpi_reserve_wakeup_memory according to Rafael
> >>>>> It seems that the function of find_e820_area is called in several
> >>>>> places.
> >>>>>    >Initmem_init: bootmap = find_e820_area(0, end_pfn<<PAGE_SHIFT,
> >>>>> bootmap_size, PAGE_SIZE);
> >>>>>    
> >>>>> If we also call it in the acpi_reserve_wakeup_memory, do we get the same
> >>>>> base address as that obtained in initmem_init?
> >>>> no. find_e820_area will check the reserve res array that could be updated by reserve_early.
> >>> It will check the reserved region array when calling the function of
> >>> find_e820_area. 
> >>> But it seems that the array is not updated when the find_e820_area is
> >>> called in the function of initmem_init.
> >> right after that will use reserve_bootmem for those range in initmem_init.
> > Yes. The reserve_bootmem is called for the range in initmem_init.
> > But the reserved_early array is not updated.
> 
> it is not needed anymore because bootmem for that node is ready at that point, could use 
> reserve_bootmem_node directly. and before that early_res_to_bootmem will convert that early resource that 
> fall into that node range to bootmem reserved too.
After the bootmem allocator is initialized, the early_res_to_bootmem
will convert the resource in reserved_early array and reserve them in
the bootmem. 

In this patch the find_e820_area is used in the
acpi_reserve_wakeup_memory, which is called after initializing the
bootmem allocator.
Can we still use the find_e820_area after the bootmem allocator is
initialized? 
It seems that the bootmem bitmap is also found by using the
find_e820_area. But we don't update the reserved_early array any more.
Maybe we will get the overlap address with the bootmem bitmap for the
wakeup code.

thanks.
> 
> please check code setup_node_bootmem/early_node_mem/early_res_to_bootmem ...and reserve_bootmem_node...

> 
> YH

