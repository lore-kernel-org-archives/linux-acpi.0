From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / IPMI: change warning to debug on timeout
Date: Wed, 29 Mar 2017 00:06:45 +0200
Message-ID: <CAJZ5v0hbPkzwV0wkTm1rE4d3R-xu9CAQBV68p=S-eHWCQMEuRA@mail.gmail.com>
References: <1490283150-24000-1-git-send-email-okaya@codeaurora.org>
 <537c0d7a-fd95-2e7f-be07-9e3ca79ca07a@acm.org> <39c54677-1472-afff-ec70-45a790f56e50@codeaurora.org>
 <67243d7f-0195-a214-b9d4-bdac48743893@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34182 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753871AbdC1WHL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2017 18:07:11 -0400
In-Reply-To: <67243d7f-0195-a214-b9d4-bdac48743893@acm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>

On Tue, Mar 28, 2017 at 10:01 PM, Corey Minyard <minyard@acm.org> wrote:
> On 03/25/2017 09:08 AM, Sinan Kaya wrote:
>>
>> On 3/24/2017 10:55 PM, Corey Minyard wrote:
>>>
>>> Why would a timeout for a message be expected?  The BMC should
>>> at least respond with an error for an incorrect message.
>>
>> Let me add some more context...
>>
>> In this particular case, the FRU ID that I was trying to access was
>> correct.
>>
>> Platform supports PCIe hotplug. The FRU is embedded into the HW that
>> is being removed. That's what I mean by non-existent.
>>
>> When the device is ejected and a FRU command is executed, BMC times out
>> reaching to the FRU on the device.
>>
>> When the device is inserted, everything works as expected.
>
>
> I haven't added this yet.  Someone who knows more about the ACPI side of
> IPMI
> should probably comment.  So I've added Lv Zheng.
>
> This is ok with me, though.  If you remove a management controller, a
> timeout is
> expected.  However, if the management controller is still present, a timeout
> is
> probably not the best error code, "destination unavailable" is probably a
> better
> choice.
>
> So:
>
> Acked-by: Corey Minyard <cminyard@mvista.com>
>
> -corey

FWIW, this change is fine by me, so please feel free to route this
through the IPMI tree along with the other patch from Sinan.

Thanks,
Rafael
