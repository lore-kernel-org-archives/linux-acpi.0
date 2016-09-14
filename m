From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH] ACPI: CPPC: Support PCC with interrupt flag
Date: Wed, 14 Sep 2016 10:55:46 -0700
Message-ID: <CAFHUOYxMOpz2xOQuVpi6y3nVrVF_ihzX9jj-0PLwkckrJFJUXw@mail.gmail.com>
References: <1469135265-27048-1-git-send-email-hotran@apm.com>
 <CAFHUOYxi1=K9RSgxA0HLXH4Tq3iyCLMrYbyGmVowATwWc1KU_g@mail.gmail.com>
 <CAFHUOYx69g7zQwzMQHfBixmbSU3meq0CA3xNz49_kDOPYPrBUQ@mail.gmail.com> <2027903.xXCTulqOxA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35562 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753970AbcINRzs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2016 13:55:48 -0400
Received: by mail-yw0-f173.google.com with SMTP id u82so30146227ywc.2
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2016 10:55:48 -0700 (PDT)
In-Reply-To: <2027903.xXCTulqOxA@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Prashanth Prakash <pprakash@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>, Ashwin Chaugule <ashwinch@google.com>

On Wed, Sep 14, 2016 at 9:49 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, September 14, 2016 08:45:14 AM Hoan Tran wrote:
>> On Tue, Aug 30, 2016 at 11:20 AM, Hoan Tran <hotran@apm.com> wrote:
>> > On Thu, Jul 21, 2016 at 2:07 PM, Hoan Tran <hotran@apm.com> wrote:
>> >> For PCC mailbox with interrupt flag, CPPC should call mbox_chan_txdone()
>> >> function to notify the mailbox framework about TX completion.
>> >>
>> >> Signed-off-by: Hoan Tran <hotran@apm.com>
>> >> ---
>> >> This patch is tested on top and depends on patch[1]:
>> >> [1] http://www.spinics.net/lists/linux-acpi/msg66041.html
>> >>  - [PATCH v3] mailbox: pcc: Support HW-Reduced Communication Subspace type 2
>> >>
>> >>  drivers/acpi/cppc_acpi.c | 6 +++++-
>> >>  1 file changed, 5 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> >> index 2e98173..19606aa 100644
>> >> --- a/drivers/acpi/cppc_acpi.c
>> >> +++ b/drivers/acpi/cppc_acpi.c
>> >> @@ -191,7 +191,11 @@ static int send_pcc_cmd(u16 cmd)
>> >>                         last_cmd_cmpl_time = ktime_get();
>> >>         }
>> >>
>> >> -       mbox_client_txdone(pcc_channel, ret);
>> >> +       if (pcc_channel->mbox->txdone_irq)
>> >> +               mbox_chan_txdone(pcc_channel, ret);
>> >> +       else
>> >> +               mbox_client_txdone(pcc_channel, ret);
>> >> +
>> >>         return ret;
>> >>  }
>> >>
>> >> --
>> >> 1.9.1
>> >>
>> >
>> > Any feedbacks.
>> >
>> > Thanks
>> > Hoan
>>
>> Hi Rafael,
>>
>> Do you have any comments on this patch ?
>
> No, but can you please resend it (with the Reviewed-by tag from Prashanth,
> preferably)?  And please make sure it applies on my linux-next branch.

Hi Rafael,

I just resent the patch with Reviewed-by tag

Thanks
Hoan

>
> Thanks,
> Rafael
>
