From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH V3 1/4] ACPI / CPPC: Optimize PCC Read Write operations
Date: Tue, 16 Feb 2016 13:47:15 -0500
Message-ID: <CAJ5Y-eb=0NnH67DfcuYn519S4n3QtXYtEF6m-G3zetcOS+cXcg@mail.gmail.com>
References: <1455134762-31400-1-git-send-email-pprakash@codeaurora.org>
 <1455134762-31400-2-git-send-email-pprakash@codeaurora.org> <20160215163719.GA22453@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36746 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbcBPSrh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2016 13:47:37 -0500
Received: by mail-lf0-f45.google.com with SMTP id 78so112848346lfy.3
        for <linux-acpi@vger.kernel.org>; Tue, 16 Feb 2016 10:47:36 -0800 (PST)
In-Reply-To: <20160215163719.GA22453@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: Prashanth Prakash <pprakash@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Timur Tabi <timur@codeaurora.org>

Hi Alexey,

On 15 February 2016 at 11:37, Alexey Klimov <alexey.klimov@arm.com> wrote:
> Hi Prashanth and Ashwin,
>
> On Wed, Feb 10, 2016 at 01:05:59PM -0700, Prashanth Prakash wrote:
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
>> in which the Remote should flip the cmd completion bit
>> is defined as N * Nominal latency. Where N is arbitrary
>> and large enough to work on slow emulators and Nominal
>> latency comes from the ACPI table (PCCT). This helps
>> in working around the CONFIG_HZ effects on udelay()
>> and also avoids needing different ACPI tables for Silicon
>> and Emulation platforms.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>> ---
>>  drivers/acpi/cppc_acpi.c | 99 ++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 71 insertions(+), 28 deletions(-)

[..]

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
>> +     int ret = -EIO;
>> +     struct acpi_pcct_shared_memory __iomem *generic_comm_base = pcc_comm_addr;
>> +     ktime_t next_deadline = ktime_add(ktime_get(), deadline);
>> +
>> +     /* Retry in case the remote processor was too slow to catch up. */
>> +     while (!ktime_after(ktime_get(), next_deadline)) {
>> +             if (readw_relaxed(&generic_comm_base->status) & PCC_CMD_COMPLETE) {
>
> What do you think about polling for error too?
> Firmware might set error bit and kernel will spin here for full cycle (maybe even
> more than one time).
>

Hm. I dont think thats useful since we dont do anything special if the
firmware errors out. Perhaps at some later point we can stop sending
new requests if there are firmware errors, but then how would we know
when to resume?

>
>> +                     ret = 0;
>> +                     break;
>> +             }
>> +             /*
>> +              * Reducing the bus traffic in case this loop takes longer than
>> +              * a few retries.
>> +              */
>> +             udelay(3);
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>>  static int send_pcc_cmd(u16 cmd)
>>  {
>> -     int retries, result = -EIO;
>> -     struct acpi_pcct_hw_reduced *pcct_ss = pcc_channel->con_priv;
>> +     int ret = -EIO;
>>       struct acpi_pcct_shared_memory *generic_comm_base =
>>               (struct acpi_pcct_shared_memory *) pcc_comm_addr;
>> -     u32 cmd_latency = pcct_ss->latency;
>>
>> -     /* Min time OS should wait before sending next command. */
>> -     udelay(pcc_cmd_delay);
>
> Ouch.
> This delay is Minimum Request Turnaround Time and specification is strict about this:
> The minimum amount of time that OSPM must wait after the
> completion of a command before issuing the next command, in microseconds.
>
> And you're going to completely remove delay that described as "must wait" regardless if it's
> write or read command. In my view completion of a command is when CMD complete bit is set to 1.
> This field in table is not optional.

The spec has a whole bunch of delays which are highly questionable.
e.g. the Min Request Turnaround time and the Max periodic access rate.
Both seem quite useless since their original intention was to avoid
the OS from flooding the BMC. But one can argue that the firmware can
throttle the OS requests via the Command Completion bit anyway. I also
didnt like the usage of udelays and prefer the ktime math, but that
seems overkill given the questionable value of these fields.

>
> Even worse, what if platform report latency = 0 (or very close to zero) and turnaround time as very large number?
>

Such a firmware would need serious rework. Besides, if for whatever
reason they choose to have it, the command complete bit can be used to
throttle the OS requests.

>> +             /*
>> +              * cppc_ss->latency is just a Nominal value. In reality
>> +              * the remote processor could be much slower to reply.
>> +              * So add an arbitrary amount of wait on top of Nominal.
>
> Specification requires platform to report accurate values.
> If remote party requires arbitrary amount on top that means someone screwed up
> values in firmware.
> That's not only slowness of remote processor but broken/inaccurate values given by firmware.
> I think if you want this comment you need to blame firmware too.
>

Not necessarily. The firmware could have other threads going on, which
sporadically cause additional ( > Nominal) latencies and the OS must
honor that. Its only a "Nominal" value after all.

>
>> +              */
>> +             usecs_lat = NUM_RETRIES * cppc_ss->latency;
>> +             deadline = ns_to_ktime(usecs_lat * NSEC_PER_USEC);
>>
>>               pcc_comm_addr = acpi_os_ioremap(comm_base_addr, len);
>>               if (!pcc_comm_addr) {
>> @@ -604,7 +640,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>>                       (ref_perf->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) ||
>>                       (nom_perf->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM)) {
>>               /* Ring doorbell once to update PCC subspace */
>> -             if (send_pcc_cmd(CMD_READ)) {
>> +             if (send_pcc_cmd(CMD_READ) < 0) {
>
> Somewhere in previous email I asked you to point me to specs with words about init values before
> issuing first PCC command. Thanks for that.
> However I still think that comment should be added about init value of status register.
> Please add it unless you have something to come up with. I think such comment will be useful.
>
>

Ok. We'll add it if we need to revise this patchset.


Thanks,
Ashwin.
