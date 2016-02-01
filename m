From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH V2 1/4] ACPI / CPPC: Optimize PCC Read Write operations
Date: Mon, 1 Feb 2016 14:06:07 -0700
Message-ID: <56AFC8BF.7080106@codeaurora.org>
References: <1453511240-20792-2-git-send-email-pprakash@codeaurora.org>
 <1454355493-3242-1-git-send-email-alexey.klimov@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59791 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbcBAVGM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2016 16:06:12 -0500
In-Reply-To: <1454355493-3242-1-git-send-email-alexey.klimov@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Klimov <alexey.klimov@arm.com>, ashwin.chaugule@linaro.org
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org

Hi Alexey,

On 2/1/2016 12:38 PM, Alexey Klimov wrote:
> Hi Prashanth and Ashwin,
>
> On Sat, Jan 23, 2016 at 1:07 AM, Prashanth Prakash <pprakash@codeaurora.org> wrote:
>> From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>
>> Previously the send_pcc_cmd() code checked if the
>> PCC operation had completed before returning from
>> the function. This check was performed regardless
>> of the PCC op type (i.e. Read/Write). Knowing
>> the type of cmd can be used to optimize the check
>> and avoid needless waiting. e.g. with Write ops,
>> the actual Writing is done before calling send_pcc_cmd().
>> And the subsequent Writes will check if the channel is
>> free at the entry of send_pcc_cmd() anyway.
>>
>> However, for Read cmds, we need to wait for the cmd
>> completion bit to be flipped, since the actual Read
>> ops follow after returning from the send_pcc_cmd(). So,
>> only do the looping check at the end for Read ops.
>>
>> Also, instead of using udelay() calls, use ktime as a
>> means to check for deadlines. The current deadline
> udelay() is still there. Well, proposed approach in this patch is better than
> current code but I will be much more happy to see approach without delay()s under
> spin_lock if such approach exists.
udelay() is needed to avoid flooding the interconnects used while accessing the bits.  While running
tests, we wait for the bit to be set on a very small percentage of occasions. 
When it happens, it is mostly when there were requests going from different cores simultaneously,
but I think we can handle it a little differently by batching requests rather than serializing. We are
working on a patch to enable batching. I will post that patch set after a little more testing.

Having said that, yes I agree with you it would be much nicer to get rid of usleep if possible.
>> in which the Remote should flip the cmd completion bit
>> is defined as N * Nominal latency. Where N is arbitrary
>> and large enough to work on slow emulators and Nominal
>> latency comes from the ACPI table (PCCT). This helps
>> in working around the CONFIG_HZ effects on udelay()
>> and also avoids needing different ACPI tables for Silicon
>> and Emulation platforms.
> What's the logic behind choosing N? Is it defined as 500 currently?
> Can it be some kind of configurable module or boot parameter?
> What if nominal latency given by firmware will be 100 mS?
>
> Frankly speaking, I personally expect that slow emulator is going to fail
> timing-sensitive activities and that's fine.
> Your requirement to use same tables for emulator and hardware is understandable
> too.
500 was arbitrarily chosen to make sure emulation would not fail.  I suppose it is cleaner
to remove the retries after some profiling/testing to make sure we are not relying
on retries on actual hardware as well. I can run some testing and address this
as part of different patch-set.
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
> Looks like retries variable is not used properly. You just increment it and that's all.
> Could you please check its usage or remove it?
Yes, retries variable is not necessary.  I will remove it in next version.
>>  static int send_pcc_cmd(u16 cmd)
>>  {
>> -       int retries, result = -EIO;
>> -       struct acpi_pcct_hw_reduced *pcct_ss = pcc_channel->con_priv;
>> +       int ret = -EIO;
>>         struct acpi_pcct_shared_memory *generic_comm_base =
>>                 (struct acpi_pcct_shared_memory *) pcc_comm_addr;
>> -       u32 cmd_latency = pcct_ss->latency;
>>
>> -       /* Min time OS should wait before sending next command. */
>> -       udelay(pcc_cmd_delay);
>> +       /*
>> +        * For CMD_WRITE we know for a fact the caller should have checked
>> +        * the channel before writing to PCC space
>> +        */
>> +       if (cmd == CMD_READ) {
>> +               ret = check_pcc_chan();
>> +               if (ret)
>> +                       return ret;
>> +       }
> For my eyes first pcc command to be called during booting is send_pcc_cmd(CMD_READ)
> from cppc_get_perf_caps(). That means we go to the loop inside check_pcc_chan() and
> to break that loop and successfully continue software expects bit PCC_CMD_COMPLETE to be
> set.
> I checked ACPI specs and didn't find any words about reset value of status register here.
> If it's there could you please point me to it and place comment here? Or you shouldn't rely
> on reset value of status reg (let's imagine that we rebooted kernel without informing firmware).
> I actually hit this bug when I started to test your patches.
The specification does mention the following in the Doorbell Protocol (section 14.3 in 6.0 spec) "To ensure
consistency of the shared memory region, the shared memory region is exclusively owned by OSPM or the
platform at any point in time. After being initialized by the platform, the region is owned by OSPM. Writing..."

Given the above, it is fair to think that the platform will initialize the command completion bit
accordingly. If platform wants to prevent the OSPM from accessing region during init, it can set this bit
accordingly to achieve the same.
>
> [snip]
>
>
> Anyway, I tested your patches and ready to give reviewed-and-tested-by after resolving current issues
> (and after re-testing). So, could you please keep me in c/c in next version?
Sure, I will keep in cc.

Thanks for reviewing the code and providing inputs!
>
> Thanks,
> Alexey.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

