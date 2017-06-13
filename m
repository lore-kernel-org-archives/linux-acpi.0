From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [PATCH 01/15] ACPICA: Disassembler: Enhance resource descriptor
 detection
Date: Tue, 13 Jun 2017 09:42:02 -0400
Message-ID: <d1e64425-29cf-3d2a-2b5b-51cc67e9ca89@hpe.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
 <fe4a8655a06221df851d5781609058f16aa65e93.1493194142.git.lv.zheng@intel.com>
 <59357F55.8050707@hpe.com> <361261e5-ce98-9d33-f2de-88286288e2e1@hpe.com>
 <CAJZ5v0hUaiwZwi1a78zSO_hqp_QNdv9gYce-wwNESz1rnPs+sg@mail.gmail.com>
 <9f2f3edd-74e9-e108-0eff-56564c94147b@hpe.com>
 <CAJZ5v0jExmFeYwbq2CwCGEetf=JJevePcUJNarb6OKnf0Bb0GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:34987 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbdFMNmQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Jun 2017 09:42:16 -0400
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 236916258A
        for <linux-acpi@vger.kernel.org>; Tue, 13 Jun 2017 13:42:15 +0000 (UTC)
In-Reply-To: <CAJZ5v0jExmFeYwbq2CwCGEetf=JJevePcUJNarb6OKnf0Bb0GQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, "David E . Box" <david.e.box@intel.com>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>



On 6/5/2017 4:55 PM, Rafael J. Wysocki wrote:
> On Mon, Jun 5, 2017 at 10:51 PM, Linda Knippers <linda.knippers@hpe.com> wrote:
>> On 6/5/2017 4:42 PM, Rafael J. Wysocki wrote:
>> <snip>
>>
>>>> I talked to our FW team and we do generate checksums and not a zero for
>>>> at
>>>> least some
>>>> of the AML. Please revert this change until you can also validate
>>>> a checksum.  Or shall I post a patch to remove the check?
>>>
>>>
>>> I'll skip this patch, no need to do anything else.  Thanks for your
>>> report!
>>
>>
>> Thanks.  This patch is already in as of 4.12rc1 and not part of the most
>> recent
>> ACPICA drop.
>
> Ah, OK.
>
> I should have checked I guess. :-)
>
> Anyway, I'll revert it, then.

Hi Rafael, Is this still in the queue to be reverted?
I see it's still in rc5 but it really needs to go before 4.12 is released.
We've been broken since rc1.

Thanks,

-- ljk
>
>>> Bob, can you revert this upstream, please?  It looks like the
>>> assumption it is based on doesn't hold.
>>
>> Bob, I'm happy to test something if there is a new patch that looks for zero
>> or a valid checksum.  TBH, I'm not 100% certain that our checksums are
>> correct because nothing has ever tried to verify them.
>
> Well, that's part of the problem here I guess.  If they have never
> been tested, they cannot be trusted.
>
> Still, the commit in question clearly assumed that value to always be
> 0 and it clearly is not the case here.
>
> Thanks,
> Rafael
>
