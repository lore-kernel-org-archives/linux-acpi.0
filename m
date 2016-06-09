From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH] ACPI/CPPC: Support for batching CPPC requests
Date: Thu, 9 Jun 2016 10:22:12 -0700
Message-ID: <CAFHUOYyi4k5JuP5unxKyYH=tdxBE1BNm7zW9cjQchcnrmFNg9A@mail.gmail.com>
References: <1463441951-13207-1-git-send-email-pprakash@codeaurora.org>
	<20160526220234.GA26524@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35805 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932283AbcFIRWO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jun 2016 13:22:14 -0400
Received: by mail-vk0-f54.google.com with SMTP id d127so64413378vkh.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jun 2016 10:22:13 -0700 (PDT)
In-Reply-To: <20160526220234.GA26524@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Klimov <alexey.klimov@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Hi Prashanth,

On Thu, May 26, 2016 at 3:02 PM, Alexey Klimov <alexey.klimov@arm.com> wrote:
> On Tue, May 17, 2016 at 12:39 AM, Prashanth Prakash <pprakash@codeaurora.org> wrote:
>>
>> CPPC defined in section 8.4.7 of ACPI 6.1 specification suggests
>> "To amortize the cost of PCC transactions, OSPM should read or write
>> all PCC registers via a single read or write command when possible"
>> This patch enables opportunistic batching of frequency transition
>> requests whenever the request happen to overlap in time.
>>
>> Currently the access to pcc is serialized by a spin lock which does
>> not scale well as we increase the number of cores in the system. This
>> patch improves the scalability by allowing the differnt CPU cores to
>> update PCC subspace in parallel and by batching requests which will
>> reduce certain types of operation(checking command completion bit,
>> ringing doorbell) by a significant margin.
>>
>> Profiling shows significant improvement in the time to service freq.
>> transition request. Using a workload which includes multiple iteration
>> of configure+make of vim (with -j24 option):
>> Without batching requests(without this patch),
>>         6 domains: Avg=20us/request; 24 domains: Avg=52us/request
>> With batching requests(with this patch),
>>         6 domains: Avg=16us/request; 24 domains: Avg=19us/request
>> domain: An individual cpu or a set of related CPUs whose frequency can
>> be scaled independently
>
> With this approach sometimes you will send POSTCHANGE notifications about
> frequency change for some random CPUs before actual request to change
> frequency was sent (and received?) through PCC channel.
> Depending on platform/firmware/configuration this time difference might be high.
>
> How vital or important is to have POSTCHANGE notification in correct time
> order?
>
> Best regards,
> Alexey.
>
>
>
>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>> ---
>>  drivers/acpi/cppc_acpi.c | 166 ++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 141 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 8adac69..3edfd50 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -43,12 +43,34 @@
>>
>>  #include <acpi/cppc_acpi.h>
>>  /*
>> - * Lock to provide mutually exclusive access to the PCC
>> - * channel. e.g. When the remote updates the shared region
>> - * with new data, the reader needs to be protected from
>> - * other CPUs activity on the same channel.
>> + * Lock to provide controlled access to the PCC channel.
>> + *
>> + * For performance critical usecases(currently cppc_set_perf)
>> + *     We need to take read_lock and check if channel belongs to OSPM before
>> + * reading or writing to PCC subspace
>> + *     We need to take write_lock before transferring the channel ownership to
>> + * the platform via a Doorbell
>> + *
>> + * For non-performance critical usecases(init)
>> + *     Take write_lock for all purposes which gives exclusive access
>> + *
>> + * Why not use spin lock?
>> + *     One of the advantages of CPPC is that we can batch/group a large number
>> + * of requests from differnt CPUs and send one request to the platform. Using a
>> + * read-write spinlock allows us to do this in a effecient manner.
>> + *     On larger multicore systems, if we get a large group of cppc_set_perf
>> + * calls they all serialize behind a spin lock, but using a rwlock we can
>> + * execute the requests in a much more scalable manner.
>> + *     See cppc_set_perf() for more details
>> + */
>> +static DEFINE_RWLOCK(pcc_lock);

Any chance to use mutex instead of spinlock ?
In some cases such as (cmd = CMD_READ || pcc_mrtt), because of waiting
for command completion,this spinlock is kept for a while before
unlock. It could waste CPU time to acquire the spinlock.

Thanks
Hoan

>> +
>> +/*
>> + * This bool is set to True when we have updated the CPC registers but hasn't
>> + * triggered a doorbell yet.
>> + * Once we trigger a doorbell for WRITE command we reset this to False
>>   */
>> -static DEFINE_SPINLOCK(pcc_lock);
>> +static bool pending_pcc_write_cmd;
>>
>>  /*
>>   * The cpc_desc structure contains the ACPI register details
>> @@ -105,6 +127,10 @@ static int check_pcc_chan(void)
>>         return ret;
>>  }
>>
>> +/*
>> + * This function transfers the ownership of the PCC to the platform
>> + * So it must be called while holding write_lock(pcc_lock)
>> + */
>>  static int send_pcc_cmd(u16 cmd)
>>  {
>>         int ret = -EIO;
>> @@ -119,6 +145,16 @@ static int send_pcc_cmd(u16 cmd)
>>          * the channel before writing to PCC space
>>          */
>>         if (cmd == CMD_READ) {
>> +               /*
>> +                * If there are pending cpc_writes, then we stole the channel
>> +                * before write completion, so first send a WRITE command to
>> +                * platform
>> +                */
>> +               if (pending_pcc_write_cmd) {
>> +                       pending_pcc_write_cmd = FALSE;
>> +                       send_pcc_cmd(CMD_WRITE);
>> +               }
>> +
>>                 ret = check_pcc_chan();
>>                 if (ret)
>>                         return ret;
>> @@ -723,6 +759,7 @@ int cppc_get_perf_caps(int cpunum, struct
>> cppc_perf_caps *perf_caps)
>>                                                                  *nom_perf;
>>         u64 high, low, ref, nom;
>>         int ret = 0;
>> +       bool caps_regs_in_pcc = FALSE;
>>
>>         if (!cpc_desc) {
>>                 pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>> @@ -734,13 +771,15 @@ int cppc_get_perf_caps(int cpunum, struct
>> cppc_perf_caps *perf_caps)
>>         ref_perf = &cpc_desc->cpc_regs[REFERENCE_PERF];
>>         nom_perf = &cpc_desc->cpc_regs[NOMINAL_PERF];
>>
>> -       spin_lock(&pcc_lock);
>> -
>> -       /* Are any of the regs PCC ?*/
>> +       /* Are any of the regs PCC ? */
>>         if ((highest_reg->cpc_entry.reg.space_id ==
>> ACPI_ADR_SPACE_PLATFORM_COMM) ||
>>                         (lowest_reg->cpc_entry.reg.space_id ==
>> ACPI_ADR_SPACE_PLATFORM_COMM) ||
>>                         (ref_perf->cpc_entry.reg.space_id ==
>> ACPI_ADR_SPACE_PLATFORM_COMM) ||
>>                         (nom_perf->cpc_entry.reg.space_id ==
>> ACPI_ADR_SPACE_PLATFORM_COMM)) {
>> +
>> +               caps_regs_in_pcc = TRUE;
>> +               write_lock(&pcc_lock);
>> +
>>                 /* Ring doorbell once to update PCC subspace */
>>                 if (send_pcc_cmd(CMD_READ) < 0) {
>>                         ret = -EIO;
>> @@ -767,7 +806,8 @@ int cppc_get_perf_caps(int cpunum, struct
>> cppc_perf_caps *perf_caps)
>>                 ret = -EFAULT;
>>
>>  out_err:
>> -       spin_unlock(&pcc_lock);
>> +       if (caps_regs_in_pcc)
>> +               write_unlock(&pcc_lock);
>>         return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>> @@ -785,6 +825,7 @@ int cppc_get_perf_ctrs(int cpunum, struct
>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>         struct cpc_register_resource *delivered_reg, *reference_reg;
>>         u64 delivered, reference;
>>         int ret = 0;
>> +       bool ctrs_regs_in_pcc = FALSE;
>>
>>         if (!cpc_desc) {
>>                 pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>> @@ -794,11 +835,12 @@ int cppc_get_perf_ctrs(int cpunum, struct
>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>         delivered_reg = &cpc_desc->cpc_regs[DELIVERED_CTR];
>>         reference_reg = &cpc_desc->cpc_regs[REFERENCE_CTR];
>>
>> -       spin_lock(&pcc_lock);
>> -
>>         /* Are any of the regs PCC ?*/
>>         if ((delivered_reg->cpc_entry.reg.space_id ==
>> ACPI_ADR_SPACE_PLATFORM_COMM) ||
>>                         (reference_reg->cpc_entry.reg.space_id ==
>> ACPI_ADR_SPACE_PLATFORM_COMM)) {
>> +               ctrs_regs_in_pcc = TRUE;
>> +               write_lock(&pcc_lock);
>> +
>>                 /* Ring doorbell once to update PCC subspace */
>>                 if (send_pcc_cmd(CMD_READ) < 0) {
>>                         ret = -EIO;
>> @@ -824,7 +866,9 @@ int cppc_get_perf_ctrs(int cpunum, struct
>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>         perf_fb_ctrs->prev_reference = reference;
>>
>>  out_err:
>> -       spin_unlock(&pcc_lock);
>> +       if (ctrs_regs_in_pcc)
>> +               write_unlock(&pcc_lock);
>> +
>>         return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
>> @@ -849,13 +893,34 @@ int cppc_set_perf(int cpu, struct
>> cppc_perf_ctrls *perf_ctrls)
>>
>>         desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>>
>> -       spin_lock(&pcc_lock);
>> -
>> -       /* If this is PCC reg, check if channel is free before writing */
>> +       /*
>> +        * This is Phase-I where we want to write to CPC registers
>> +        * -> We want all CPUs to be able to execute this phase in parallel
>> +        *
>> +        * Since read_lock can be acquired by multiple CPUs simultaneously we
>> +        * achieve that goal here
>> +        */
>>         if (desired_reg->cpc_entry.reg.space_id ==
>> ACPI_ADR_SPACE_PLATFORM_COMM) {
>> -               ret = check_pcc_chan();
>> -               if (ret)
>> -                       goto busy_channel;
>> +               read_lock(&pcc_lock);   /* BEGIN Phase-I */
>> +               /*
>> +                * If there are pending write commands i.e pending_pcc_write_cmd
>> +                * is TRUE, then we know OSPM owns the channel as another CPU
>> +                * has already checked for command completion bit and updated
>> +                * the corresponding CPC registers
>> +                */
>> +               if (!pending_pcc_write_cmd) {
>> +                       ret = check_pcc_chan();
>> +                       if (ret) {
>> +                               read_unlock(&pcc_lock);
>> +                               return ret;
>> +                       }
>> +                       /*
>> +                        * Update the pending_write to make sure a PCC CMD_READ
>> +                        * will not arrive and steal the channel during the
>> +                        * transition to write lock
>> +                        */
>> +                       pending_pcc_write_cmd = TRUE;
>> +               }
>>         }
>>
>>         /*
>> @@ -864,15 +929,66 @@ int cppc_set_perf(int cpu, struct
>> cppc_perf_ctrls *perf_ctrls)
>>          */
>>         cpc_write(&desired_reg->cpc_entry.reg, perf_ctrls->desired_perf);
>>
>> -       /* Is this a PCC reg ?*/
>> +       if (desired_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM)
>> +               read_unlock(&pcc_lock); /* END Phase-I */
>> +
>> +       /*
>> +        * This is Phase-II where we transfer the ownership of PCC to Platform
>> +        *
>> +        * Short Summary: Basically if we think of a group of cppc_set_perf
>> +        * requests that happened in short overlapping interval. The last CPU to
>> +        * come out of Phase-I will enter Phase-II and ring the doorbell.
>> +        *
>> +        * We have the following requirements for Phase-II:
>> +        *     1. We want to execute Phase-II only when there are no CPUs
>> +        * currently executing in Phase-I
>> +        *     2. Once we start Phase-II we want to avoid all other CPUs from
>> +        * entering Phase-I.
>> +        *     3. We want only one CPU among all those who went through Phase-I
>> +        * to run phase-II
>> +        *
>> +        * If write_trylock fails to get the lock and doesn't transfer the
>> +        * PCC ownership to the platform, then one of the following will be TRUE
>> +        *     1. There is at-least one CPU in Phase-I which will later execute
>> +        * write_trylock, so the CPUs in Phase-I will be responsible for
>> +        * executing the Phase-II.
>> +        *     2. Some other CPU has beaten this CPU to successfully execute the
>> +        * write_trylock and has already acquired the write_lock. We know for a
>> +        * fact it(other CPU acquiring the write_lock) couldn???t have happened
>> +        * before this CPU???s Phase-I as we held the read_lock.
>> +        *     3. Some other CPU executing pcc CMD_READ has stolen the
>> +        * write_lock, in which case, send_pcc_cmd will check for pending
>> +        * CMD_WRITE commands by checking the pending_pcc_write_cmd.
>> +        * So this CPU can be certain that its request will be delivered
>> +        *    So in all cases, this CPU knows that its request will be delivered
>> +        * by another CPU and can return
>> +        *
>> +        * After getting the write_lock we still need to check for
>> +        * pending_pcc_write_cmd to take care of the following scenario
>> +        *    The thread running this code could be scheduled out between
>> +        * Phase-I and Phase-II. Before it is scheduled back on, another CPU
>> +        * could have delivered the request to Platform by triggering the
>> +        * doorbell and transferred the ownership of PCC to platform. So this
>> +        * avoids triggering an unnecessary doorbell and more importantly before
>> +        * triggering the doorbell it makes sure that the PCC channel ownership
>> +        * is still with OSPM.
>> +        *   pending_pcc_write_cmd can also be cleared by a different CPU, if
>> +        * there was a pcc CMD_READ waiting on write_lock and it steals the lock
>> +        * before the pcc CMD_WRITE is completed. pcc_send_cmd checks for this
>> +        * case during a CMD_READ and if there are pending writes it delivers
>> +        * the write command before servicing the read command
>> +        */
>>         if (desired_reg->cpc_entry.reg.space_id ==
>> ACPI_ADR_SPACE_PLATFORM_COMM) {
>> -               /* Ring doorbell so Remote can get our perf request. */
>> -               if (send_pcc_cmd(CMD_WRITE) < 0)
>> -                       ret = -EIO;
>> +               if (write_trylock(&pcc_lock)) {         /* BEGIN Phase-II */
>> +                       /* Update only if there are pending write commands */
>> +                       if (pending_pcc_write_cmd) {
>> +                               pending_pcc_write_cmd = FALSE;
>> +                               if (send_pcc_cmd(CMD_WRITE) < 0)
>> +                                       ret = -EIO;
>> +                       }
>> +                       write_unlock(&pcc_lock);         /* END Phase-II */
>> +               }
>>         }
>> -busy_channel:
>> -       spin_unlock(&pcc_lock);
>> -
>>         return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_set_perf);
>> --
>> Qualcomm Technologies, Inc. on behalf
>> of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc.
>> is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
>>
