From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 7/7] ACPI / x86: introduce acpi_os_readable() support
Date: Thu, 17 Dec 2015 08:59:32 -0800
Message-ID: <CALCETrWzn_9wL_7zL4GdHrFB3c9qaAjnEbLdU+bppLf-GVsx3w@mail.gmail.com>
References: <cover.1446790780.git.lv.zheng@intel.com> <cover.1449108825.git.lv.zheng@intel.com>
 <af8b1799e7eec686fbb3bf239f6f400adb3b8082.1449108826.git.lv.zheng@intel.com>
 <CALCETrXeoGZhrNr9OmqFB+i7-tbM+d3sO8uCNnMx40JfDsjoEw@mail.gmail.com>
 <36DF59CE26D8EE47B0655C516E9CE64028686D35@shsmsx102.ccr.corp.intel.com> <1AE640813FDE7649BE1B193DEA596E883BB08C24@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33040 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbbLQQ7w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2015 11:59:52 -0500
Received: by mail-oi0-f50.google.com with SMTP id y66so46077632oig.0
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2015 08:59:52 -0800 (PST)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB08C24@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Andy Lutomirski <luto@kernel.org>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>

On Tue, Dec 15, 2015 at 4:25 PM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Andy and Yu
>
>> From: Zheng, Lv
>> Sent: Tuesday, December 15, 2015 4:52 PM
>>
>> Hi,
>>
>> > From: Chen, Yu C
>> > Sent: Tuesday, December 15, 2015 2:13 PM
>> >
>> > Hi, Andy
>> >
>> > > From: Andy Lutomirski [mailto:luto@amacapital.net]
>> > > Sent: Tuesday, December 15, 2015 7:28 AM
>> > >
>> > > On Wed, Dec 2, 2015 at 6:43 PM, Lv Zheng <lv.zheng@intel.com> wrote:
>> > > > From: Chen Yu <yu.c.chen@intel.com>
>> > > >
>> > > > This patch implements acpi_os_readable(). The function is used by
>> > > > ACPICA AML debugger to validate user specified pointers for dumping
>> > > > the memory as ACPICA descriptor objects.
>> > > >
>> > [cut]
>> > > >
>> > > > +bool __acpi_memory_readable(void *pointer, size_t length) {
>> > > > +       unsigned long obj_start, obj_end;
>> > > > +       unsigned long start_pfn, end_pfn;
>> > >
>> > > What does "readable" mean in this context?
>>
>> [Lv Zheng]
>> The function is used by ACPICA "dump" command.
>> It accepts an arbitrary address, and tries to dump the memory block specified
>> by the address as an acpi_object.
>> You can try: "help dump" in the interactive mode to confirm.
>> While acpi_object is actually all created by kmalloc.
> [Lv Zheng]
> This statement might be wrong, Let me Cc Bob to confirm.
>
> Hi, Bob
>
> Do we have statically allocated acpi_objects?
> If we have, we need to change this patch to allow high map .data/.bss segments addresses to pass this check.
>

I think that hpa or Borislav [cc'd] could address the memory map
details better than I could.  However, this functionality seems
strange.

Are these physical addresses or virtual addresses that are being
dumped?  In either case, ISTM that using something iike page_is_ram
might be a lot simpler.

--Andy

> Thanks and best regards
> -Lv
>
>> So we just check if the specified memory block belongs to the kernel heap.
>> The readable/writeable is not so meaningful here as the kernel heap should
>> always be both readable and writeable.
>>
>> We do a lot of checks in this function in order to allow it to:
>> 1. return true if "pointer" belongs to kernel heap when "length" is 0;
>> 2. return false if "pointer" doesn't belong to kernel heap when "length" is 0;
>> 3. return true if "pointer ~ pointer+length-1" belongs to a kernel heap range;
>> 4. return false if "pointer ~ pointer+length-1" doesn't belong to any kernel heap
>> range.
>>
>> These checks are weak, but can help to avoid panics if users specify wrong
>> pointers for the "dump" command.
>>
>> > 'readable' means :  the address provided by the user,
>> > is a dynamically allocated  virtual address -
>> > because  the  acpi address space are allocated by 'kmalloc',
>> > acpi debugger must check if this address is a valid 'kmalloc'
>> > address before accessing it.
>> >
>> > This function does the sanity check that, the vitual address is a:
>> > 1.   dynamically allocated address (beyond PAGE_OFFSET , but lower
>> > than high_memory, VMALLOC_START, eg)
>> > 2.  besides, the physical address must be direct-mapped(so it would not be a
>> > hole).
>>
>> [Lv Zheng]
>> There is a special case (possibly hackish) on x86_64.
>> x86_64 kernel maps kernel image twice.
>> One is called as high map and the other is called as low map.
>>
>> Since we use __pa() to convert a virtual address,
>> If the virtual address belongs to the high map range, __pa() which takes care of
>> converting high map addresses actually returns a physical address where there
>> should also be low map mappings ready for it.
>> Thus the converted PFN from the result of __pa() will be treated as valid.
>>
>> But this doesn't mean there is a high map for this virtual address.
>> x86_64 kernel drops several pages from high map in cleanup_highmap().
>> So accessing a virtual address that belongs to the holes whose page mappings
>> have been dropped in this function could still result in panic due to no mappings.
>> By enforcing this check, we can avoid such a case.
>> Actually no acpi_object's virtual address will belong to high map range.
>>
>> Thanks and best regards
>> -Lv



-- 
Andy Lutomirski
AMA Capital Management, LLC
