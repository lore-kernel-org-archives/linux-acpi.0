From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 01/15] ACPICA: Disassembler: Enhance resource descriptor detection
Date: Tue, 13 Jun 2017 17:13:12 +0200
Message-ID: <CAJZ5v0jNPKu91=OKpXihisudc19fpRabNmWM_-PFg3QOEMHXTQ@mail.gmail.com>
References: <cover.1493194142.git.lv.zheng@intel.com> <fe4a8655a06221df851d5781609058f16aa65e93.1493194142.git.lv.zheng@intel.com>
 <59357F55.8050707@hpe.com> <361261e5-ce98-9d33-f2de-88286288e2e1@hpe.com>
 <CAJZ5v0hUaiwZwi1a78zSO_hqp_QNdv9gYce-wwNESz1rnPs+sg@mail.gmail.com>
 <9f2f3edd-74e9-e108-0eff-56564c94147b@hpe.com> <CAJZ5v0jExmFeYwbq2CwCGEetf=JJevePcUJNarb6OKnf0Bb0GQ@mail.gmail.com>
 <d1e64425-29cf-3d2a-2b5b-51cc67e9ca89@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:34084 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753360AbdFMPNN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Jun 2017 11:13:13 -0400
Received: by mail-io0-f172.google.com with SMTP id i7so75239669ioe.1
        for <linux-acpi@vger.kernel.org>; Tue, 13 Jun 2017 08:13:13 -0700 (PDT)
In-Reply-To: <d1e64425-29cf-3d2a-2b5b-51cc67e9ca89@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linda Knippers <linda.knippers@hpe.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, "David E . Box" <david.e.box@intel.com>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Jun 13, 2017 at 3:42 PM, Linda Knippers <linda.knippers@hpe.com> wrote:
>
>
> On 6/5/2017 4:55 PM, Rafael J. Wysocki wrote:
>>
>> On Mon, Jun 5, 2017 at 10:51 PM, Linda Knippers <linda.knippers@hpe.com>
>> wrote:
>>>
>>> On 6/5/2017 4:42 PM, Rafael J. Wysocki wrote:
>>> <snip>
>>>
>>>>> I talked to our FW team and we do generate checksums and not a zero for
>>>>> at
>>>>> least some
>>>>> of the AML. Please revert this change until you can also validate
>>>>> a checksum.  Or shall I post a patch to remove the check?
>>>>
>>>>
>>>>
>>>> I'll skip this patch, no need to do anything else.  Thanks for your
>>>> report!
>>>
>>>
>>>
>>> Thanks.  This patch is already in as of 4.12rc1 and not part of the most
>>> recent
>>> ACPICA drop.
>>
>>
>> Ah, OK.
>>
>> I should have checked I guess. :-)
>>
>> Anyway, I'll revert it, then.
>
>
> Hi Rafael, Is this still in the queue to be reverted?

Yes, it is.

> I see it's still in rc5 but it really needs to go before 4.12 is released.
> We've been broken since rc1.

I will push it for -rc6.

Thanks,
Rafael
