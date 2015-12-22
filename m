From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 7/7] ACPI / x86: introduce acpi_os_readable() support
Date: Tue, 22 Dec 2015 14:49:11 -0800
Message-ID: <CALCETrVcYbqNpVi4J_iQL1WPYCA1zPJAs+csx73CaQvYziDY1g@mail.gmail.com>
References: <cover.1446790780.git.lv.zheng@intel.com> <cover.1449108825.git.lv.zheng@intel.com>
 <af8b1799e7eec686fbb3bf239f6f400adb3b8082.1449108826.git.lv.zheng@intel.com>
 <CALCETrXeoGZhrNr9OmqFB+i7-tbM+d3sO8uCNnMx40JfDsjoEw@mail.gmail.com>
 <36DF59CE26D8EE47B0655C516E9CE64028686D35@shsmsx102.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BB08C24@SHSMSX101.ccr.corp.intel.com>
 <CALCETrWzn_9wL_7zL4GdHrFB3c9qaAjnEbLdU+bppLf-GVsx3w@mail.gmail.com> <36DF59CE26D8EE47B0655C516E9CE640286886D1@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35025 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbbLVWtb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Dec 2015 17:49:31 -0500
Received: by mail-ob0-f178.google.com with SMTP id 18so154845215obc.2
        for <linux-acpi@vger.kernel.org>; Tue, 22 Dec 2015 14:49:31 -0800 (PST)
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE640286886D1@shsmsx102.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Andy Lutomirski <luto@kernel.org>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>

On Mon, Dec 21, 2015 at 5:03 PM, Chen, Yu C <yu.c.chen@intel.com> wrote:
> Hi Andy,
> thanks for your review,
>
>> -----Original Message-----
>> From: Andy Lutomirski [mailto:luto@amacapital.net]
>> Sent: Friday, December 18, 2015 1:00 AM
>> To: Zheng, Lv
>> Cc: Chen, Yu C; Moore, Robert; Wysocki, Rafael J; Brown, Len; Andy
>> Lutomirski; Lv Zheng; linux-kernel@vger.kernel.org; Linux ACPI; H. Peter
>> Anvin; Borislav Petkov
>> Subject: Re: [PATCH v4 7/7] ACPI / x86: introduce acpi_os_readable() support
>>
> [cut]
>>
>> I think that hpa or Borislav [cc'd] could address the memory map details
>> better than I could.  However, this functionality seems strange.
>>
>> Are these physical addresses or virtual addresses that are being dumped?
> [Yu] They are  virtual addresses to be dumped.
>> In  either case, ISTM that using something iike page_is_ram might be a lot
>> simpler.
> [Yu] if i understand correctly, this API is used to check if the address is a valid
> 'kmalloc' style address, but not 'kmap' or 'vmalloc' address, and page_is_ram
> might treat the latter as valid address?
>

I'm a bit puzzled as to why this matters, but I have no fundamental
objection to doing it that way.

What's the use case, though?  That is, what goes wrong if the function
just always returns false?

--Andy

> thanks,
> Yu



-- 
Andy Lutomirski
AMA Capital Management, LLC
