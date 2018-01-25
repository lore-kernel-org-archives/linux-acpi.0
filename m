From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] xen: add acpi_arch_get_root_pointer() for pvh guests
Date: Thu, 25 Jan 2018 13:35:15 +0100
Message-ID: <20180125123515.GA30787@kroah.com>
References: <20180125100454.23203-1-jgross@suse.com>
 <20180125100454.23203-3-jgross@suse.com>
 <20180125103719.GA16777@kroah.com>
 <033717a8-f53a-3379-1e05-58b3d2bed24b@suse.com>
 <20180125110051.GA31911@kroah.com>
 <b67f9405-5a6b-fd8c-7778-c12ca724ab0b@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60828 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeAYMf1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jan 2018 07:35:27 -0500
Content-Disposition: inline
In-Reply-To: <b67f9405-5a6b-fd8c-7778-c12ca724ab0b@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org, lenb@kernel.org, rafael.j.wysocki@intel.com, mingo@redhat.com, boris.ostrovsky@oracle.com, stable@vger.kernel.org

On Thu, Jan 25, 2018 at 01:06:26PM +0100, Juergen Gross wrote:
> On 25/01/18 12:00, Greg KH wrote:
> > On Thu, Jan 25, 2018 at 11:49:35AM +0100, Juergen Gross wrote:
> >> On 25/01/18 11:37, Greg KH wrote:
> >>> On Thu, Jan 25, 2018 at 11:04:54AM +0100, Juergen Gross wrote:
> >>>> Add acpi_arch_get_root_pointer() for Xen PVH guests to communicate
> >>>> the address of the RSDP table given to the kernel via Xen start info.
> >>>>
> >>>> This makes the kernel boot again in PVH mode after on recent Xen the
> >>>> RSDP was moved to higher addresses. So up to that change it was pure
> >>>> luck that the legacy method to locate the RSDP was working when
> >>>> running as PVH mode.
> >>>>
> >>>> Cc: <stable@vger.kernel.org> # 4.11
> >>>> Signed-off-by: Juergen Gross <jgross@suse.com>
> >>>> ---
> >>>>  arch/x86/xen/enlighten_pvh.c | 15 ++++++++++++---
> >>>>  1 file changed, 12 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
> >>>> index 436c4f003e17..9a5c3a7fe673 100644
> >>>> --- a/arch/x86/xen/enlighten_pvh.c
> >>>> +++ b/arch/x86/xen/enlighten_pvh.c
> >>>> @@ -16,15 +16,24 @@
> >>>>  /*
> >>>>   * PVH variables.
> >>>>   *
> >>>> - * xen_pvh and pvh_bootparams need to live in data segment since they
> >>>> - * are used after startup_{32|64}, which clear .bss, are invoked.
> >>>> + * xen_pvh, pvh_bootparams and pvh_start_info need to live in data segment
> >>>> + * since they are used after startup_{32|64}, which clear .bss, are invoked.
> >>>>   */
> >>>>  bool xen_pvh __attribute__((section(".data"))) = 0;
> >>>>  struct boot_params pvh_bootparams __attribute__((section(".data")));
> >>>> +struct hvm_start_info pvh_start_info __attribute__((section(".data")));
> >>>>  
> >>>> -struct hvm_start_info pvh_start_info;
> >>>>  unsigned int pvh_start_info_sz = sizeof(pvh_start_info);
> >>>>  
> >>>> +acpi_physical_address acpi_arch_get_root_pointer(void)
> >>>> +{
> >>>> +	if (xen_pvh)
> >>>> +		return pvh_start_info.rsdp_paddr;
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(acpi_arch_get_root_pointer);
> >>>
> >>> Why does this have to be an exported symbol?  Does this code get built
> >>> as a module and will the linker somehow go and rewrite the previous call
> >>> places with this one if it gets loaded?
> >>
> >> With being called by drivers/acpi/... I just wanted to make sure it is
> >> working properly even in case the acpi code is built as a module.
> > 
> > I didn't think the core ACPI code can be built as a module, have you
> > tried that?
> 
> No, but as the build wouldn't break whenever this is changed I wanted
> to make sure the symbol is found.
> 
> If you feel strong about that I can remove the EXPORT_SYMBOL_GPL().

Please don't export symbols that do not need to be exported, that's just
a waste.

thanks,

greg k-h
