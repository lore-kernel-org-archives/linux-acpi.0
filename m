From: Alexey Klimov <alexey.klimov@arm.com>
Subject: Re: [PATCH] mailbox: pcc: fix channel calculation in get_pcc_channel()
Date: Mon,  1 Feb 2016 15:19:05 +0000
Message-ID: <1454339945-30565-1-git-send-email-alexey.klimov@arm.com>
References: <CAJ5Y-eYdPM+hSZdH_Sz10K6iHb0cCB1E4Wh_A_sJn_yyLgLjZQ@mail.gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49348 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbcBAPTY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Feb 2016 10:19:24 -0500
In-Reply-To: <CAJ5Y-eYdPM+hSZdH_Sz10K6iHb0cCB1E4Wh_A_sJn_yyLgLjZQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: ashwin.chaugule@linaro.org, jaswinder.singh@linaro.org, jassisinghbrar@gmail.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Alexey Klimov <alexey.klimov@arm.com>

(adding Rafael and linux-acpi)

On Fri, Jan 15, 2016 at 6:22 PM, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> + Jassi (Linaro addr)
>
> On 15 January 2016 at 13:20, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>> Jassi,
>>
>> On 10 December 2015 at 13:19, Ashwin Chaugule
>> <ashwin.chaugule@linaro.org> wrote:
>>> On 10 December 2015 at 12:28, Alexey Klimov <alexey.klimov@arm.com> wrote:
>>>> This patch fixes the calculation of pcc_chan for non-zero id.
>>>> After the compiler ignores the (unsigned long) cast the
>>>> pcc_mbox_channels pointer is type-cast and then the type-cast
>>>> offset is added which results in address outside of the range
>>>> leading to the kernel crashing.
>>>>
>>>> We might add braces and make it:
>>>>
>>>> pcc_chan = (struct mbox_chan *)
>>>>                 ((unsigned long) pcc_mbox_channels +
>>>>                 (id * sizeof(*pcc_chan)));
>>>>
>>>> but let's go with array approach here and use id as index.
>>>>
>>>> Tested on Juno board.
>>>>
>>>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>>> Signed-off-by: Alexey Klimov <alexey.klimov@arm.com>
>>>> ---
>>>>  drivers/mailbox/pcc.c | 8 +-------
>>>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>>>> index 45d85ae..8f779a1 100644
>>>> --- a/drivers/mailbox/pcc.c
>>>> +++ b/drivers/mailbox/pcc.c
>>>> @@ -81,16 +81,10 @@ static struct mbox_controller pcc_mbox_ctrl = {};
>>>>   */
>>>>  static struct mbox_chan *get_pcc_channel(int id)
>>>>  {
>>>> -       struct mbox_chan *pcc_chan;
>>>> -
>>>>         if (id < 0 || id > pcc_mbox_ctrl.num_chans)
>>>>                 return ERR_PTR(-ENOENT);
>>>>
>>>> -       pcc_chan = (struct mbox_chan *)
>>>> -               (unsigned long) pcc_mbox_channels +
>>>> -               (id * sizeof(*pcc_chan));
>>>> -
>>>> -       return pcc_chan;
>>>> +       return &pcc_mbox_channels[id];
>>>>  }
>>>>
>>>
>>>
>>> Strange that we didn't catch this even with a non-zero id. But the
>>> change makes sense so..
>>>
>>> Acked-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>
>> Can you please include this patch in your pull request to Linus?

Hi Rafael,

any chance you can take this fix via your tree?
I can resend patch if you want.
Looks like Jassi doesn't have time or doesn't care.

Best regards,
Alexey
