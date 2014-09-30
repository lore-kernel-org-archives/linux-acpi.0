From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v7 1/2] Mailbox: Add support for Platform Communication Channel
Date: Tue, 30 Sep 2014 13:23:30 -0400
Message-ID: <CAJ5Y-eaL_O5_FFgpMZZnzXMf6o3iduCkaPuJL66RAsnzaHSrJw@mail.gmail.com>
References: <1410369619-2570-1-git-send-email-ashwin.chaugule@linaro.org>
	<1410369619-2570-2-git-send-email-ashwin.chaugule@linaro.org>
	<20140916174035.GT7960@sirena.org.uk>
	<CAJ5Y-eak5iMak6vqTBNYdWz1tKFRjGUfD7cZor+uHKknwYNhoQ@mail.gmail.com>
	<CAJ5Y-ebOd1wN+FFH4BSB7JgvEqLi_5fq_FFmVD_i50cpoWjKXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38288 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbaI3RXb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Sep 2014 13:23:31 -0400
Received: by mail-wi0-f180.google.com with SMTP id em10so4080258wid.1
        for <linux-acpi@vger.kernel.org>; Tue, 30 Sep 2014 10:23:30 -0700 (PDT)
In-Reply-To: <CAJ5Y-ebOd1wN+FFH4BSB7JgvEqLi_5fq_FFmVD_i50cpoWjKXQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>

Hi Mark,

On 17 September 2014 18:17, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> On 16 September 2014 14:28, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>> Hi Mark,
>>
>> On 16 September 2014 13:40, Mark Brown <broonie@kernel.org> wrote:
>>> On Wed, Sep 10, 2014 at 01:20:18PM -0400, Ashwin Chaugule wrote:
>>>
>>>> ACPI 5.0+ spec defines a generic mode of communication
>>>> between the OS and a platform such as the BMC. This medium
>>>> (PCC) is typically used by CPPC (ACPI CPU Performance management),
>>>> RAS (ACPI reliability protocol) and MPST (ACPI Memory power
>>>> states).
>>>
>>> This mostly looks good to me at a fairly high level, one small nit below
>>> which I don't think should be a blocker to an initial merge but would be
>>> good to fix.
>>>
>>> Reviewed-by: Mark Brown <broonie@kernel.org>
>>
>> Much appreciated!
>>
>>>
>>>> +static bool pcc_tx_done(struct mbox_chan *chan)
>>>> +{
>>>> +     struct acpi_pcct_subspace *pcct_ss = chan->con_priv;
>>>> +     struct acpi_pcct_shared_memory *generic_comm_base =
>>>> +             (struct acpi_pcct_shared_memory *) pcct_ss->base_address;
>>>> +     u16 cmd_delay = pcct_ss->min_turnaround_time;
>>>> +
>>>> +     /* Wait for Platform to consume. */
>>>> +     while (!(readw_relaxed(&generic_comm_base->status) & PCC_CMD_COMPLETE))
>>>> +             udelay(cmd_delay);
>>>
>>> This will busy wait for ever if the controller dies.  We're in big
>>> trouble if that happens but it would be good to have some sort of
>>> timeout and scream here.
>>
>> Agreed. I'll add this along with Lv's feedback.
>
>
> How about something like this?
>
> --------8<-------------
> -
> -       /* Wait for Platform to consume. */
> -       while (!(readw_relaxed(&generic_comm_base->status) & PCC_CMD_COMPLETE))
> -               udelay(cmd_delay);
> -
> +       unsigned int retries = 0;
> +
> +       /* Try a few times while waiting for platform to consume */
> +       while (!(readw_relaxed(&generic_comm_base->status) &
> PCC_CMD_COMPLETE)) {
> +               if (retries++ < 5)
> +                       udelay(cmd_delay);
> +               else {
> +                       pr_err("PCC platform did not respond.\n");
> +                       return false;
> +               }
> +       }
>
> --------8<-------------
>
> And the Mbox client additionally sets .tx_block = true and .tx_out =
> 10(msecs). That way, if the remote hangs or crashes, the
> wait_for_completion in the controller code timesout and sends an -EIO
> to the client .tx_done method so it knows something went wrong.

Can I add the above snippet to V8 with your Reviewed-by tag?

Thanks,
Ashwin
