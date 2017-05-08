From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH] ACPI: SPCR: Use access width to determine mmio usage
Date: Mon, 8 May 2017 13:51:20 -0700
Message-ID: <CAPw-ZTkwwuwCSw0Q=8W53e7t5FDEF-hKshOoWvdJ7QhCTRvuqA@mail.gmail.com>
References: <1493910330-17913-1-git-send-email-jon.mason@broadcom.com>
 <4e11bb2b-7cec-6a7b-ca2b-88be31a98b7d@redhat.com> <CAPw-ZTkF2KnC2TWwxWLTKoM5LPkipHvJeQGaBp30JjDNQ76VEA@mail.gmail.com>
 <f122adfb-872e-9ee6-db61-b55c75903b63@redhat.com> <CAPw-ZTnu+YvBN8PAZfMEKuY_3xTPDgr4qmNqi0JOCPXH_k0SDg@mail.gmail.com>
 <CAC3K-4oK9FF_7QfoQCBvgBCoprk+VbRVD-YvC9fm7aRT8Uo+rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:38601 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbdEHUvW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 May 2017 16:51:22 -0400
Received: by mail-it0-f52.google.com with SMTP id e65so45825165ita.1
        for <linux-acpi@vger.kernel.org>; Mon, 08 May 2017 13:51:22 -0700 (PDT)
In-Reply-To: <CAC3K-4oK9FF_7QfoQCBvgBCoprk+VbRVD-YvC9fm7aRT8Uo+rQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jon Mason <jon.mason@broadcom.com>
Cc: Jon Masters <jcm@redhat.com>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devel@acpica.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>

Hi Jon,

On Mon, May 8, 2017 at 1:34 PM, Jon Mason <jon.mason@broadcom.com> wrote:
> On Mon, May 8, 2017 at 3:57 PM, Loc Ho <lho@apm.com> wrote:
>> Hi Jon,
>>
>>>>
>>>>>> The current SPCR code does not check the access width of the mmio, and
>>>>>> uses a default of 8bit register accesses.  This prevents devices that
>>>>>> only do 16 or 32bit register accesses from working.  By simply checking
>>>>>> this field and setting the mmio string appropriately, this issue can be
>>>>>> corrected.  To prevent any legacy issues, the code will default to 8bit
>>>>>> accesses if the value is anything but 16 or 32.
>>>>>
>>>>> Thanks for this. Just as an FYI I've a running discussion with Microsoft
>>>>> about defining additional UART subtypes in the DBG2 for special case
>>>>> UARTs. Specifically, I want to address AppliedMicro's special 8250 dw IP
>>>>> that also has a non-standard clock. At this time, there is general
>>>>> agreement to use the access width for some cases rather than defining
>>>>> yet more subtypes - so your patch is good.
>>>>>
>>>>> Loc/Applied: please track this thread, incorporate feedback, and also
>>>>> track the other general recent discussions of 8250 dw from this week.
>>>>
>>>> Thanks for forward me this patch. This patch does not work with X-Gene
>>>> v1 and v2 SoC's. As BIOS SPCR encodes these info as:
>>>>
>>>> Bit Width: 32
>>>> Bit Offset: 0
>>>> Encoded Access Width: 01 (Byte Access)
>>>>
>>>> With this patch, it would use the "mmio" instead the "mmio32" as with
>>>> this patch - https://patchwork.kernel.org/patch/9460959
>>>
>>> I think this is why we need the DBG2 subtype for Applied X-Gene1. I'm
>>> hoping the update to the SPCR/DBG2 spec is done soon.
>>
>> We can't rely on the BIOS change to support this new subtype as we
>> have system that is already in production deployment. When these
>> system upgrade to new version of the OS (stock, RHELSA, or whatever),
>> they will break. We need the patch from
>> https://patchwork.kernel.org/patch/9460959/ rolled upstream.
>
> There is no reason why the patch you reference cannot co-exist with
> the one I am submitting here.  In this case, my patch would set it to
> mmio, then the patch you link above would reset it to mmio32.
> Personally, I would recommend a big, fat comment on why this extra
> step is necessary, but it should work as desired.  Alternatively, we
> could add some kind of quirk library (similar to
> qdf2400_erratum_44_present) where the OEM/OEM Table ID is referenced
> and workaround applied.  Thoughts?

That's was my first version but after seeing both versions, I think
they are better solution as it works for more SoC's than just our. As
you had suggested, we should apply your patch and
https://patchwork.kernel.org/patch/9460959. The third patch -
https://patchwork.kernel.org/patch/9462183/ - conflicts with your.

Summary:
1. Applied your - https://lkml.org/lkml/2017/5/4/450
2. Applied this one - https://patchwork.kernel.org/patch/9460959/

-Loc
