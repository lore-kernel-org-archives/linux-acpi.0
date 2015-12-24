From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 7/7] ACPI / x86: introduce acpi_os_readable() support
Date: Wed, 23 Dec 2015 17:40:30 -0800
Message-ID: <CALCETrWBavzmaDy5u_O09rdqiRn4K=pjDwkwd+hdGd4OWV-+6g@mail.gmail.com>
References: <cover.1446790780.git.lv.zheng@intel.com> <cover.1449108825.git.lv.zheng@intel.com>
 <af8b1799e7eec686fbb3bf239f6f400adb3b8082.1449108826.git.lv.zheng@intel.com>
 <CALCETrXeoGZhrNr9OmqFB+i7-tbM+d3sO8uCNnMx40JfDsjoEw@mail.gmail.com>
 <36DF59CE26D8EE47B0655C516E9CE64028686D35@shsmsx102.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BB08C24@SHSMSX101.ccr.corp.intel.com>
 <CALCETrWzn_9wL_7zL4GdHrFB3c9qaAjnEbLdU+bppLf-GVsx3w@mail.gmail.com>
 <36DF59CE26D8EE47B0655C516E9CE640286886D1@shsmsx102.ccr.corp.intel.com>
 <CALCETrVcYbqNpVi4J_iQL1WPYCA1zPJAs+csx73CaQvYziDY1g@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E883BB0A29B@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB0A29B@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Andy Lutomirski <luto@kernel.org>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 22, 2015 at 7:25 PM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Andy
>
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> owner@vger.kernel.org] On Behalf Of Andy Lutomirski
>> Sent: Wednesday, December 23, 2015 6:49 AM
>> Subject: Re: [PATCH v4 7/7] ACPI / x86: introduce acpi_os_readable()=
 support
>>
>> On Mon, Dec 21, 2015 at 5:03 PM, Chen, Yu C <yu.c.chen@intel.com> wr=
ote:
>> > Hi Andy,
>> > thanks for your review,
>> >
>> >> -----Original Message-----
>> >> From: Andy Lutomirski [mailto:luto@amacapital.net]
>> >> Sent: Friday, December 18, 2015 1:00 AM
>> >> To: Zheng, Lv
>> >> Cc: Chen, Yu C; Moore, Robert; Wysocki, Rafael J; Brown, Len; And=
y
>> >> Lutomirski; Lv Zheng; linux-kernel@vger.kernel.org; Linux ACPI; H=
=2E Peter
>> >> Anvin; Borislav Petkov
>> >> Subject: Re: [PATCH v4 7/7] ACPI / x86: introduce acpi_os_readabl=
e()
>> support
>> >>
>> > [cut]
>> >>
>> >> I think that hpa or Borislav [cc'd] could address the memory map =
details
>> >> better than I could.  However, this functionality seems strange.
>> >>
>> >> Are these physical addresses or virtual addresses that are being =
dumped?
>> > [Yu] They are  virtual addresses to be dumped.
>> >> In  either case, ISTM that using something iike page_is_ram might=
 be a lot
>> >> simpler.
>> > [Yu] if i understand correctly, this API is used to check if the a=
ddress is a valid
>> > 'kmalloc' style address, but not 'kmap' or 'vmalloc' address, and =
page_is_ram
>> > might treat the latter as valid address?
>> >
>>
>> I'm a bit puzzled as to why this matters, but I have no fundamental =
objection to doing it that way.
> [Lv Zheng]
> IMO, using page_is_ram() or something similar, the problem is what we=
 need to solve in the current approach still need to be solved:
> 1. How can we convert a virtual address into a "struct page"?
>     There is no kernel API to convert any virtual address into struct=
 page.
>     Even there is such a kernel API to convert kmap/vmalloc addresses=
, we still couldn't use it.
>     Because if we want to validate kmap/vmaloc pages, we need 2 APIs =
rather than 1 API while ACPICA only provides 1 API for this purpose.
>     The 2 APIs should be get/put style to ping the page mappings as t=
he mappings other than the direct mappings will not be stationary in th=
e kernel address space.
>     Fortunately we needn't take care of the mappings other than the d=
irect mappings (reasons are in the 2nd comment).
>     So we still need to use the direct mapping APIs here.
> 2. How can we ensure the page is a direct mapping page?
>     I think Yu should confirm if there is such a common kernel API.
>     If there is such an API, we should use it so that we can remove t=
he arch specific stuffs.
>
>> What's the use case, though?
> [Lv Zheng]
> Fortunately, currently ACPICA only uses this API to validate if a nam=
espace node, an operand object or a parser object is readable.
> See drivers/acpi/acpica/dbdisplay.c and drivers/acpi/acpica/dbcmds.c.
>
>>  That is, what goes wrong if the function just always returns false?
> [Lv Zheng]
> 1. If it always returns false, then many ACPICA debugger internal obj=
ect conversion/dump functionalities won't be functioning.
>     For example, you can try to type =E2=80=9Cdump \_SB" in acpidbg s=
hell and it will return an error:
>       "Invalid named object at address xxxxxxxxxxxxxxxx"
> 2. While if this function always returns true (current linux-pm/linux=
-next merged stuffs), we can see such a result:
>       Object (ffffxxxxxxxxxxxx) Pathname: \_SB
>           Name : _SB_
>           Type : 06 [Device]
>

It seems a bit unfortunate to me that the ACPICA debugger lets
userspace choose what address to dump rather than dumping by pathname,
but given that constraint, I guess this function is needed.

Can you do something like checking virt_addr_valid and then using
virt_to_pfn and page_is_ram?  If that's not enough (e.g. if it doesn't
work for vmalloc addresses and you need those), you could try to do
something like slow_virt_to_phys, but you'd need to do some extra
checks to avoid the BUG in the function.

--Andy
