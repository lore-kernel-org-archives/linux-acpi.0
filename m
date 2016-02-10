From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH V3 1/4] ACPI / CPPC: Optimize PCC Read Write operations
Date: Wed, 10 Feb 2016 16:15:18 -0500
Message-ID: <CAJ5Y-eZ7u7WdC3BX7ok=cvck9pOREOJzzB4J0cKsQt2rgK8LHQ@mail.gmail.com>
References: <1455134762-31400-1-git-send-email-pprakash@codeaurora.org>
 <1455134762-31400-2-git-send-email-pprakash@codeaurora.org> <56BBA0CB.2000504@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36283 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbcBJVPj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2016 16:15:39 -0500
Received: by mail-lf0-f43.google.com with SMTP id 78so20070766lfy.3
        for <linux-acpi@vger.kernel.org>; Wed, 10 Feb 2016 13:15:38 -0800 (PST)
In-Reply-To: <56BBA0CB.2000504@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Prashanth Prakash <pprakash@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Alexey Klimov <alexey.klimov@arm.com>

On 10 February 2016 at 15:42, Timur Tabi <timur@codeaurora.org> wrote:
> Prashanth Prakash wrote:
>
>> +static int check_pcc_chan(void)
>> +{
>> +       int ret = -EIO;
>> +       struct acpi_pcct_shared_memory __iomem *generic_comm_base =
>> pcc_comm_addr;
>> +       ktime_t next_deadline = ktime_add(ktime_get(), deadline);
>> +
>> +       /* Retry in case the remote processor was too slow to catch up. */
>> +       while (!ktime_after(ktime_get(), next_deadline)) {
>> +               if (readw_relaxed(&generic_comm_base->status) &
>> PCC_CMD_COMPLETE) {
>> +                       ret = 0;
>> +                       break;
>> +               }
>> +               /*
>> +                * Reducing the bus traffic in case this loop takes longer
>> than
>> +                * a few retries.
>> +                */
>> +               udelay(3);
>> +       }
>
>
> Like I said last time, you really should use readq_relaxed_poll_timeout(),
> which does exactly the same thing as this loop, but more elegantly.

Nope.

>I think
> this will work:
>
> u32 status;
> ret = readq_relaxed_poll_timeout(&generic_comm_base->status, status, status
> & PCC_CMD_COMPLETE, 3, deadline);
> return ret ? -EIO : 0;
> ...
> deadline = NUM_RETRIES * cppc_ss->latency;
>
> This lets you completely eliminate all usage of ktime.

..Only to be re substituted by the macro all over again. So, there
really is no value in replacing this with a macro.  Also,
readx_relaxed_poll_timeout() has a usleep(), which will kill all the
optimization here. Its also horribly wrong in this context.

The alternative readx_poll_timeout_atomic() has a udelay() but it also
adds way more conditionals than this code. So, there is no need to
change things for the sake of cosmetic reasons.

> You can eliminate
> the global variable 'deadline' also, if you can figure out how to pass the
> cppc_ss object to check_pcc_chan().
>
>> -       /* Wait for a nominal time to let platform process command. */
>> -       udelay(cmd_latency);
>> -
>> -       /* Retry in case the remote processor was too slow to catch up. */
>> -       for (retries = NUM_RETRIES; retries > 0; retries--) {
>> -               if (readw_relaxed(&generic_comm_base->status) &
>> PCC_CMD_COMPLETE) {
>> -                       result = 0;
>> -                       break;
>> -               }
>> -       }
>> +       /*
>> +        * For READs we need to ensure the cmd completed to ensure
>> +        * the ensuing read()s can proceed. For WRITEs we dont care
>
>
> "don't"
>

Ashwin
