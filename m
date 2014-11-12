From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v10 1/1] Mailbox: Add support for Platform Communication
 Channel
Date: Wed, 12 Nov 2014 13:32:12 +0000
Message-ID: <5463615C.90306@arm.com>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org> <CAJ5Y-eZ+q2dHuuWwVjMCcVtXqSwg0o9Zj-kqQS95K40VakwReQ@mail.gmail.com> <546224C8.7050502@arm.com> <1620095.ORCbaZ8QlJ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:57659 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbaKLNdS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2014 08:33:18 -0500
In-Reply-To: <1620095.ORCbaZ8QlJ@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "lv.zheng@intel.com" <lv.zheng@intel.com>



On 11/11/14 20:25, Arnd Bergmann wrote:
> On Tuesday 11 November 2014 15:01:28 Sudeep Holla wrote:
>> On 11/11/14 13:18, Ashwin Chaugule wrote:
>>> On 11 November 2014 05:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>> On 07/11/14 14:52, Ashwin Chaugule wrote:
>>>>> +static struct mbox_chan pcc_mbox_chan[MAX_PCC_SUBSPACES];
>>>>
>>>>
>>>> Really, do you want to allocate 256 structures of mbox_chan even on
>>>> systems with just 1 - 2 channels(typically that would be the case) ?
>>>>
>>>
>>> Spec says, max of 256. Easier to support it this way.
>>>
>>
>> I tend to disagree, you can allocate dynamically. And use exactly same
>> logic you use in get_subspace_id to populate con_priv later. When you
>> parse PCC Subspace, you can just validate header and not record them in
>> pcc_mbox_chan. You can get the exact count in acpi_table_parse_entries
>> and then do the required allocation.
>
> Right, I think that would be best.
>
>>>>> +
>>>>> +       count = acpi_table_parse_entries(ACPI_SIG_PCCT,
>>>>> +                       sizeof(struct acpi_table_pcct),
>>>>
>>>>
>>>> s/struct acpi_table_pcct/*pcct_tbl/
>>>>
>>>> In general, the interrupt part of the PCCT SS is not considered in this
>>>> patch. It's better to see/discuss how that can be fit into the mailbox
>>>> framework, though it could be follow up patch.
>>>
>>> The IRQ part of the spec seems to be under discussion (single irq per
>>> subspace / common IRQ across all) and as you may be aware we're
>>> working on trying it out on Juno. That'll guide the design. What I
>>> have here is good enough to start off with and has been tested. I dont
>>> think we should have a problem using the mailbox API for asyn tx
>>> though, but I'd really^n prefer if we get something out there first.
>>>
>>
>> That's the different and still under discussion. But you need to support
>> Type 1 subspace as it stands in ACPI v5.1
>
> Why? We should only implement whatever is required to support existing hardware,
> not because something is in the spec.

Agreed. I assumed that this was tested on some hardware which adhere to
Type 1 subspace of the spec and I asked to implement interrupt mode as
it is always better compared to polling mode and current spec. has
support for the interrupts.

Also, the existing Type1 is not sufficient for the mailbox/PCC on Juno
platform, hence the new proposal.

Regards,
Sudeep

