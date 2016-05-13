From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v2] mailbox: pcc: Support HW-Reduced Communication
 Subspace Type 2
Date: Fri, 13 May 2016 13:23:12 -0400
Message-ID: <CAJ5Y-eb6YwhgORdm4s_CO5_7j5M_oq6HSuTGDfVp2NwZbV6uFw@mail.gmail.com>
References: <1462559914-28363-1-git-send-email-hotran@apm.com>
 <CAJ5Y-ebMB79QrSb4WRXkq-vhJED+JmW8wC1Vqyc3pg9Mh-DMjg@mail.gmail.com>
 <CAFHUOYxWe2VOjABGmm9bnqL8iKeLJ6maN-YDjp3bzWXogU2img@mail.gmail.com>
 <CAJ5Y-ebBmUHySP=wdeusACeM4wrTogVgWXNAkzc5p8jz_zbj2g@mail.gmail.com> <CAFHUOYzDGZirZ-TfbQV-DDdZ7gmwGPUiQ1nZt_KS84=aOM-McA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33696 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbcEMRXd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 May 2016 13:23:33 -0400
Received: by mail-qg0-f48.google.com with SMTP id f92so61196854qgf.0
        for <linux-acpi@vger.kernel.org>; Fri, 13 May 2016 10:23:32 -0700 (PDT)
In-Reply-To: <CAFHUOYzDGZirZ-TfbQV-DDdZ7gmwGPUiQ1nZt_KS84=aOM-McA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Alexey Klimov <alexey.klimov@arm.com>, lkml <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>

On 11 May 2016 at 14:15, Hoan Tran <hotran@apm.com> wrote:
> On Wed, May 11, 2016 at 4:57 AM, Ashwin Chaugule
> <ashwin.chaugule@linaro.org> wrote:
>> On 11 May 2016 at 00:21, Hoan Tran <hotran@apm.com> wrote:
>>> On Tue, May 10, 2016 at 5:00 AM, Ashwin Chaugule
>>>> On 6 May 2016 at 14:38, Hoan Tran <hotran@apm.com> wrote:
>>>>> From: hotran <hotran@apm.com>
>>>>>
>>>>> ACPI 6.1 has a PCC HW-Reduced Communication Subspace Type 2 intended for
>>>>> use on HW-Reduce ACPI Platform, which requires read-modify-write sequence
>>>>> to acknowledge doorbell interrupt. This patch provides the implementation
>>>>> for the Communication Subspace Type 2.
>>>>>
>>>>> This patch depends on patch [1] which supports PCC subspace type 2 header
>>>>> [1] https://lkml.org/lkml/2016/5/5/14
>>>>>  - [PATCH v2 03/13] ACPICA: ACPI 6.1: Support for new PCCT subtable
>>>>>
>>>>> v2
>>>>>  * Remove changes inside "actbl3.h". This file is taken care by ACPICA.
>>>>>  * Parse both subspace type 1 and subspace type 2
>>>>>  * Remove unnecessary variable initialization
>>>>>  * ISR returns IRQ_NONE in case of error
>>>>>
>>>>> v1
>>>>>  * Initial
>>>>>
>>>>> Signed-off-by: Hoan Tran <hotran@apm.com>
>>>>> ---
>>>>>  drivers/mailbox/pcc.c | 395 +++++++++++++++++++++++++++++++++++++-------------
>>>>>  1 file changed, 296 insertions(+), 99 deletions(-)

[..]

>>>>> @@ -357,24 +534,44 @@ static int __init acpi_pcc_probe(void)
>>>>>         pcct_entry = (struct acpi_subtable_header *) (
>>>>>                 (unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
>>>>>
>>>>> +       acpi_pcct_tbl = (struct acpi_table_pcct *) pcct_tbl;
>>>>> +       if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL)
>>>>> +               pcc_mbox_ctx.mbox_ctrl.txdone_irq = true;
>>>>> +
>>>>>         for (i = 0; i < count; i++) {
>>>>>                 struct acpi_generic_address *db_reg;
>>>>>                 struct acpi_pcct_hw_reduced *pcct_ss;
>>>>> -               pcc_mbox_channels[i].con_priv = pcct_entry;
>>>>> +
>>>>> +               pcc_mbox_ctx.chans[i].con_priv = pcct_entry;
>>>>> +               pcc_mbox_ctx.chans[i].mbox = &pcc_mbox_ctx.mbox_ctrl;
>>>>> +
>>>>> +               pcct_ss = (struct acpi_pcct_hw_reduced *) pcct_entry;
>>>>> +
>>>>> +               pcc_mbox_ctx.mbox_chans[i].chan = &pcc_mbox_ctx.chans[i];
>>>>> +               if (pcc_mbox_ctx.mbox_ctrl.txdone_irq) {
>>>>> +                       rc = pcc_parse_subspace_irq(&pcc_mbox_ctx.mbox_chans[i],
>>>>> +                                                   pcct_ss);
>>>>> +                       if (rc < 0)
>>>>> +                               return rc;
>>>>> +               }
>>>>
>>>> I think we should parse the remaining entries and register them if
>>>> they are sane. Some other PCC clients can then continue to function.
>>> I think, it could be an error of PCCT table and need to be returned.
>>>>
>>
>> Well, that could be dealt with a pr_err/warn() for that specific entry
>> ?
> But what happens if the PCC client requests this failed PCC subspace.
> "pcc_parse_subspace_irq" function does "pr_err" for error cases.
>
>> IIRC not all subspaces require IRQ's. Its optional, isnt it?
> Maybe I misunderstood: if "doorbell interrupt" bit of "platform
> communications channel global flags" is set, the platform is capable
> of generating an interrupt to indicate completion of a command. And if
> this bit is set, "doorbell interrupt" and "doorbell interrupt flags"
> fields of each subspace are active
> Could you correct me, thanks
>>

You're right. My concern is addressed by your check for txdone_irq.
Are you able to test this on a system which doesn't have Type 2
support?

Thanks,
Ashwin.
