From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH] ACPI: CPPC: Support PCC with interrupt flag
Date: Wed, 14 Sep 2016 09:45:27 -0600
Message-ID: <733a9b93-fe0d-46d4-9c48-7d7407b4e69f@codeaurora.org>
References: <1469135265-27048-1-git-send-email-hotran@apm.com>
 <CAFHUOYxi1=K9RSgxA0HLXH4Tq3iyCLMrYbyGmVowATwWc1KU_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFHUOYxi1=K9RSgxA0HLXH4Tq3iyCLMrYbyGmVowATwWc1KU_g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hoan Tran <hotran@apm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>, ashwinch@google.com
List-Id: linux-acpi@vger.kernel.org

Hi Hoan,

On 8/30/2016 12:20 PM, Hoan Tran wrote:
> On Thu, Jul 21, 2016 at 2:07 PM, Hoan Tran <hotran@apm.com> wrote:
>> For PCC mailbox with interrupt flag, CPPC should call mbox_chan_txdone()
>> function to notify the mailbox framework about TX completion.
>>
>> Signed-off-by: Hoan Tran <hotran@apm.com>
>> ---
>> This patch is tested on top and depends on patch[1]:
>> [1] http://www.spinics.net/lists/linux-acpi/msg66041.html
>>  - [PATCH v3] mailbox: pcc: Support HW-Reduced Communication Subspace type 2
>>
>>  drivers/acpi/cppc_acpi.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 2e98173..19606aa 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -191,7 +191,11 @@ static int send_pcc_cmd(u16 cmd)
>>                         last_cmd_cmpl_time = ktime_get();
>>         }
>>
>> -       mbox_client_txdone(pcc_channel, ret);
>> +       if (pcc_channel->mbox->txdone_irq)
>> +               mbox_chan_txdone(pcc_channel, ret);
>> +       else
>> +               mbox_client_txdone(pcc_channel, ret);
>> +
Firstly, sorry for the delay.

I was wondering if we should call txdone in PCC interrupt routine as done in
some of the mailbox drivers. But then, since we need to support both polling
and interrupt, I suppose this makes sense.

Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>

Thanks,
Prashanth
>>         return ret;
>>  }
>>
>> --
>> 1.9.1
>>
> Any feedbacks.
>
> Thanks
> Hoan
