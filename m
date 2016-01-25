From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH V2 1/4] ACPI / CPPC: Optimize PCC Read Write operations
Date: Mon, 25 Jan 2016 15:26:44 -0500
Message-ID: <CAJ5Y-eZ5w7o2GFaqn8M3JciCQi5OPDJ8THfQGN9JijQi0H-qNw@mail.gmail.com>
References: <1453511240-20792-1-git-send-email-pprakash@codeaurora.org>
 <1453511240-20792-2-git-send-email-pprakash@codeaurora.org> <CAOZdJXX5moGhs_+EMr00z0k4CW+n3s3s6HfzLZKk8VcVnNCS-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35220 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515AbcAYU1G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2016 15:27:06 -0500
Received: by mail-lf0-f44.google.com with SMTP id c192so92245614lfe.2
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2016 12:27:05 -0800 (PST)
In-Reply-To: <CAOZdJXX5moGhs_+EMr00z0k4CW+n3s3s6HfzLZKk8VcVnNCS-w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Prashanth Prakash <pprakash@codeaurora.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>

On 25 January 2016 at 12:19, Timur Tabi <timur@codeaurora.org> wrote:
> On Fri, Jan 22, 2016 at 7:07 PM, Prashanth Prakash
> <pprakash@codeaurora.org> wrote:
>>  static void __iomem *pcc_comm_addr;
>>  static u64 comm_base_addr;
>>  static int pcc_subspace_idx = -1;
>> -static u16 pcc_cmd_delay;
>>  static bool pcc_channel_acquired;
>> +static ktime_t deadline;
>>
>>  /*
>>   * Arbitrary Retries in case the remote processor is slow to respond
>> - * to PCC commands.
>> + * to PCC commands. Keeping it high enough to cover emulators where
>> + * the processors run painfully slow.
>>   */
>>  #define NUM_RETRIES 500
>>
>> +static int check_pcc_chan(void)
>> +{
>> +       int result = -EIO;
>> +       struct acpi_pcct_shared_memory *generic_comm_base =
>> +               (struct acpi_pcct_shared_memory *) pcc_comm_addr;
>
> You're typecasting away the __iomem, and you don't need a typecast for
> void pointers.  This should be:
>
> struct acpi_pcct_shared_memory __iomem *generic_comm_base = pcc_comm_addr;
>
>> +       ktime_t next_deadline = ktime_add(ktime_get(), deadline);
>> +       int retries = 0;
>> +
>> +       /* Retry in case the remote processor was too slow to catch up. */
>> +       while (!ktime_after(ktime_get(), next_deadline)) {
>> +               if (readw_relaxed(&generic_comm_base->status) & PCC_CMD_COMPLETE) {
>> +                       result = 0;
>> +                       break;
>> +               }
>> +               /*
>> +                * Reducing the bus traffic in case this loop takes longer than
>> +                * a few retries.
>> +                */
>> +               udelay(3);
>> +               retries++;
>
> You don't actually use 'retries' in this function, so just delete it.
> Besides, you should be using readl_poll_timeout, instead of this loop.
> It handles the udelay and the ktime for you.
>
>> +       }
>> +
>> +       return result;
>> +}
>> +
>>  static int send_pcc_cmd(u16 cmd)
>>  {
>> -       int retries, result = -EIO;
>> -       struct acpi_pcct_hw_reduced *pcct_ss = pcc_channel->con_priv;
>> +       int ret = -EIO;
>
> Please be consistent in your return variable names.  Sometimes you use
> 'result', sometimes 'ret'.  Pick one (my preference is 'ret') and use
> it exclusively.
>
>>         struct acpi_pcct_shared_memory *generic_comm_base =
>>                 (struct acpi_pcct_shared_memory *) pcc_comm_addr;
>
> You have the same problem with __iomem here.
>
> And don't forget to CC: me and Ashwin on all future versions of this patchset.

Prashanth has been doing the right thing all along. I was CC'd on all
his patchwork, but you changed it (and removed me) while replying.
Unless Rafael thinks otherwise, I see no major issues in V2, so there
is no need for a respin.

Ashwin
