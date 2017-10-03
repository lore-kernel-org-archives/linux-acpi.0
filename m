From: George Cherian <gcherian@caviumnetworks.com>
Subject: Re: [PATCH v4 2/2] ACPI / CPPC: Make cppc acpi driver aware of pcc
 subspace ids
Date: Tue, 3 Oct 2017 16:31:35 +0530
Message-ID: <e0895d9c-032d-04b7-6003-d3c0447922ca@caviumnetworks.com>
References: <1505885087-5112-1-git-send-email-george.cherian@cavium.com>
 <1505885087-5112-3-git-send-email-george.cherian@cavium.com>
 <929b30f2-03d1-269c-8672-72577a4e5a46@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-dm3nam03on0055.outbound.protection.outlook.com ([104.47.41.55]:5185
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750720AbdJCLB4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Oct 2017 07:01:56 -0400
In-Reply-To: <929b30f2-03d1-269c-8672-72577a4e5a46@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>, George Cherian <george.cherian@cavium.com>, devel@acpica.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: lv.zheng@intel.com, robert.moore@intel.com, jassisinghbrar@gmail.com, lenb@kernel.org, rjw@rjwysocki.net

Hi Prakash,

On 09/29/2017 04:49 AM, Prakash, Prashanth wrote:
> Hi George,
> 
> On 9/19/2017 11:24 PM, George Cherian wrote:
>> Based on ACPI 6.2 Section 8.4.7.1.9 If the PCC register space is used,
>> all PCC registers, for all processors in the same performance
>> domain (as defined by _PSD), must be defined to be in the same subspace.
>> Based on Section 14.1 of ACPI specification, it is possible to have a
>> maximum of 256 PCC subspace ids. Add support of multiple PCC subspace id
>> instead of using a single global pcc_data structure.
>>
>> While at that fix the time_delta check in send_pcc_cmd() so that last_mpar_reset
>> and mpar_count is initialized properly.
>>
>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 243 +++++++++++++++++++++++++++++------------------
>>   1 file changed, 153 insertions(+), 90 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index e5b47f0..3ae79ef 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -75,13 +75,16 @@ struct cppc_pcc_data {
>>   
>>   	/* Wait queue for CPUs whose requests were batched */
>>   	wait_queue_head_t pcc_write_wait_q;
>> +	ktime_t last_cmd_cmpl_time;
>> +	ktime_t last_mpar_reset;
>> +	int mpar_count;
>> +	int refcount;
>>   };
>>   
>> -/* Structure to represent the single PCC channel */
>> -static struct cppc_pcc_data pcc_data = {
>> -	.pcc_subspace_idx = -1,
>> -	.platform_owns_pcc = true,
>> -};
>> +/* Array  to represent the PCC channel per subspace id */
>> +static struct cppc_pcc_data *pcc_data[MAX_PCC_SUBSPACES];
>> +/* The cpu_pcc_subspace_idx containsper CPU subspace id */
>> +static DEFINE_PER_CPU(int, cpu_pcc_subspace_idx);
>>   
>>   /*
>>    * The cpc_desc structure contains the ACPI register details
>> @@ -93,7 +96,8 @@ static struct cppc_pcc_data pcc_data = {
>>   static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>>   
>>   /* pcc mapped address + header size + offset within PCC subspace */
>> -#define GET_PCC_VADDR(offs) (pcc_data.pcc_comm_addr + 0x8 + (offs))
>> +#define GET_PCC_VADDR(offs, pcc_ss_id) (pcc_data[pcc_ss_id]->pcc_comm_addr + \
>> +						0x8 + (offs))
>>   
>>   /* Check if a CPC register is in PCC */
>>   #define CPC_IN_PCC(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&		\
>> @@ -188,13 +192,16 @@ static struct kobj_type cppc_ktype = {
>>   	.default_attrs = cppc_attrs,
>>   };
>>   
>> -static int check_pcc_chan(bool chk_err_bit)
>> +static int check_pcc_chan(int pcc_ss_id, bool chk_err_bit)
>>   {
>>   	int ret = -EIO, status = 0;
>> -	struct acpi_pcct_shared_memory __iomem *generic_comm_base = pcc_data.pcc_comm_addr;
>> -	ktime_t next_deadline = ktime_add(ktime_get(), pcc_data.deadline);
>> +	struct cppc_pcc_data *pcc_ss_data = pcc_data[pcc_ss_id];
>> +	struct acpi_pcct_shared_memory __iomem *generic_comm_base =
>> +		pcc_ss_data->pcc_comm_addr;
>> +	ktime_t next_deadline = ktime_add(ktime_get(),
>> +					  pcc_ss_data->deadline);
>>   
>> -	if (!pcc_data.platform_owns_pcc)
>> +	if (!pcc_ss_data->platform_owns_pcc)
>>   		return 0;
>>   
>>   	/* Retry in case the remote processor was too slow to catch up. */
>> @@ -219,7 +226,7 @@ static int check_pcc_chan(bool chk_err_bit)
>>   	}
>>   
>>   	if (likely(!ret))
>> -		pcc_data.platform_owns_pcc = false;
>> +		pcc_ss_data->platform_owns_pcc = false;
>>   	else
>>   		pr_err("PCC check channel failed. Status=%x\n", status);
>>   
>> @@ -230,13 +237,12 @@ static int check_pcc_chan(bool chk_err_bit)
>>    * This function transfers the ownership of the PCC to the platform
>>    * So it must be called while holding write_lock(pcc_lock)
>>    */
>> -static int send_pcc_cmd(u16 cmd)
>> +static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
>>   {
>>   	int ret = -EIO, i;
>> +	struct cppc_pcc_data *pcc_ss_data = pcc_data[pcc_ss_id];
>>   	struct acpi_pcct_shared_memory *generic_comm_base =
>> -		(struct acpi_pcct_shared_memory *) pcc_data.pcc_comm_addr;
>> -	static ktime_t last_cmd_cmpl_time, last_mpar_reset;
>> -	static int mpar_count;
>> +		(struct acpi_pcct_shared_memory *)pcc_ss_data->pcc_comm_addr;
>>   	unsigned int time_delta;
>>   
>>   	/*
>> @@ -249,24 +255,25 @@ static int send_pcc_cmd(u16 cmd)
>>   		 * before write completion, so first send a WRITE command to
>>   		 * platform
>>   		 */
>> -		if (pcc_data.pending_pcc_write_cmd)
>> -			send_pcc_cmd(CMD_WRITE);
>> +		if (pcc_ss_data->pending_pcc_write_cmd)
>> +			send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>>   
>> -		ret = check_pcc_chan(false);
>> +		ret = check_pcc_chan(pcc_ss_id, false);
>>   		if (ret)
>>   			goto end;
>>   	} else /* CMD_WRITE */
>> -		pcc_data.pending_pcc_write_cmd = FALSE;
>> +		pcc_ss_data->pending_pcc_write_cmd = FALSE;
>>   
>>   	/*
>>   	 * Handle the Minimum Request Turnaround Time(MRTT)
>>   	 * "The minimum amount of time that OSPM must wait after the completion
>>   	 * of a command before issuing the next command, in microseconds"
>>   	 */
>> -	if (pcc_data.pcc_mrtt) {
>> -		time_delta = ktime_us_delta(ktime_get(), last_cmd_cmpl_time);
>> -		if (pcc_data.pcc_mrtt > time_delta)
>> -			udelay(pcc_data.pcc_mrtt - time_delta);
>> +	if (pcc_ss_data->pcc_mrtt) {
>> +		time_delta = ktime_us_delta(ktime_get(),
>> +					    pcc_ss_data->last_cmd_cmpl_time);
>> +		if (pcc_ss_data->pcc_mrtt > time_delta)
>> +			udelay(pcc_ss_data->pcc_mrtt - time_delta);
>>   	}
>>   
>>   	/*
>> @@ -280,18 +287,19 @@ static int send_pcc_cmd(u16 cmd)
>>   	 * not send the request to the platform after hitting the MPAR limit in
>>   	 * any 60s window
>>   	 */
>> -	if (pcc_data.pcc_mpar) {
>> -		if (mpar_count == 0) {
>> -			time_delta = ktime_ms_delta(ktime_get(), last_mpar_reset);
>> -			if (time_delta < 60 * MSEC_PER_SEC) {
>> +	if (pcc_ss_data->pcc_mpar) {
>> +		if (pcc_ss_data->mpar_count == 0) {
>> +			time_delta = ktime_ms_delta(ktime_get(),
>> +						    pcc_ss_data->last_mpar_reset);
>> +			if ((time_delta < 60 * MSEC_PER_SEC) && pcc_ss_data->last_mpar_reset) {
>>   				pr_debug("PCC cmd not sent due to MPAR limit");
>>   				ret = -EIO;
>>   				goto end;
>>   			}
>> -			last_mpar_reset = ktime_get();
>> -			mpar_count = pcc_data.pcc_mpar;
>> +			pcc_ss_data->last_mpar_reset = ktime_get();
>> +			pcc_ss_data->mpar_count = pcc_ss_data->pcc_mpar;
>>   		}
>> -		mpar_count--;
>> +		pcc_ss_data->mpar_count--;
>>   	}
>>   
>>   	/* Write to the shared comm region. */
>> @@ -300,10 +308,10 @@ static int send_pcc_cmd(u16 cmd)
>>   	/* Flip CMD COMPLETE bit */
>>   	writew_relaxed(0, &generic_comm_base->status);
>>   
>> -	pcc_data.platform_owns_pcc = true;
>> +	pcc_ss_data->platform_owns_pcc = true;
>>   
>>   	/* Ring doorbell */
>> -	ret = mbox_send_message(pcc_data.pcc_channel, &cmd);
>> +	ret = mbox_send_message(pcc_ss_data->pcc_channel, &cmd);
>>   	if (ret < 0) {
>>   		pr_err("Err sending PCC mbox message. cmd:%d, ret:%d\n",
>>   				cmd, ret);
>> @@ -311,15 +319,15 @@ static int send_pcc_cmd(u16 cmd)
>>   	}
>>   
>>   	/* wait for completion and check for PCC errro bit */
>> -	ret = check_pcc_chan(true);
>> +	ret = check_pcc_chan(pcc_ss_id, true);
>>   
>> -	if (pcc_data.pcc_mrtt)
>> -		last_cmd_cmpl_time = ktime_get();
>> +	if (pcc_ss_data->pcc_mrtt)
>> +		pcc_ss_data->last_cmd_cmpl_time = ktime_get();
>>   
>> -	if (pcc_data.pcc_channel->mbox->txdone_irq)
>> -		mbox_chan_txdone(pcc_data.pcc_channel, ret);
>> +	if (pcc_ss_data->pcc_channel->mbox->txdone_irq)
>> +		mbox_chan_txdone(pcc_ss_data->pcc_channel, ret);
>>   	else
>> -		mbox_client_txdone(pcc_data.pcc_channel, ret);
>> +		mbox_client_txdone(pcc_ss_data->pcc_channel, ret);
>>   
>>   end:
>>   	if (cmd == CMD_WRITE) {
>> @@ -329,12 +337,12 @@ static int send_pcc_cmd(u16 cmd)
>>   				if (!desc)
>>   					continue;
>>   
>> -				if (desc->write_cmd_id == pcc_data.pcc_write_cnt)
>> +				if (desc->write_cmd_id == pcc_ss_data->pcc_write_cnt)
>>   					desc->write_cmd_status = ret;
>>   			}
>>   		}
>> -		pcc_data.pcc_write_cnt++;
>> -		wake_up_all(&pcc_data.pcc_write_wait_q);
>> +		pcc_ss_data->pcc_write_cnt++;
>> +		wake_up_all(&pcc_ss_data->pcc_write_wait_q);
>>   	}
>>   
>>   	return ret;
>> @@ -536,16 +544,16 @@ int acpi_get_psd_map(struct cppc_cpudata **all_cpu_data)
>>   }
>>   EXPORT_SYMBOL_GPL(acpi_get_psd_map);
>>   
>> -static int register_pcc_channel(int pcc_subspace_idx)
>> +static int register_pcc_channel(int pcc_ss_idx)
>>   {
>>   	struct acpi_pcct_hw_reduced *cppc_ss;
>>   	u64 usecs_lat;
>>   
>> -	if (pcc_subspace_idx >= 0) {
>> -		pcc_data.pcc_channel = pcc_mbox_request_channel(&cppc_mbox_cl,
>> -				pcc_subspace_idx);
>> +	if (pcc_ss_idx >= 0) {
>> +		pcc_data[pcc_ss_idx]->pcc_channel =
>> +			pcc_mbox_request_channel(&cppc_mbox_cl,	pcc_ss_idx);
>>   
>> -		if (IS_ERR(pcc_data.pcc_channel)) {
>> +		if (IS_ERR(pcc_data[pcc_ss_idx]->pcc_channel)) {
>>   			pr_err("Failed to find PCC communication channel\n");
>>   			return -ENODEV;
>>   		}
>> @@ -556,7 +564,7 @@ static int register_pcc_channel(int pcc_subspace_idx)
>>   		 * PCC channels) and stored pointers to the
>>   		 * subspace communication region in con_priv.
>>   		 */
>> -		cppc_ss = (pcc_data.pcc_channel)->con_priv;
>> +		cppc_ss = (pcc_data[pcc_ss_idx]->pcc_channel)->con_priv;
>>   
>>   		if (!cppc_ss) {
>>   			pr_err("No PCC subspace found for CPPC\n");
>> @@ -569,19 +577,20 @@ static int register_pcc_channel(int pcc_subspace_idx)
>>   		 * So add an arbitrary amount of wait on top of Nominal.
>>   		 */
>>   		usecs_lat = NUM_RETRIES * cppc_ss->latency;
>> -		pcc_data.deadline = ns_to_ktime(usecs_lat * NSEC_PER_USEC);
>> -		pcc_data.pcc_mrtt = cppc_ss->min_turnaround_time;
>> -		pcc_data.pcc_mpar = cppc_ss->max_access_rate;
>> -		pcc_data.pcc_nominal = cppc_ss->latency;
>> -
>> -		pcc_data.pcc_comm_addr = acpi_os_ioremap(cppc_ss->base_address, cppc_ss->length);
>> -		if (!pcc_data.pcc_comm_addr) {
>> +		pcc_data[pcc_ss_idx]->deadline = ns_to_ktime(usecs_lat * NSEC_PER_USEC);
>> +		pcc_data[pcc_ss_idx]->pcc_mrtt = cppc_ss->min_turnaround_time;
>> +		pcc_data[pcc_ss_idx]->pcc_mpar = cppc_ss->max_access_rate;
>> +		pcc_data[pcc_ss_idx]->pcc_nominal = cppc_ss->latency;
>> +
>> +		pcc_data[pcc_ss_idx]->pcc_comm_addr =
>> +			acpi_os_ioremap(cppc_ss->base_address, cppc_ss->length);
>> +		if (!pcc_data[pcc_ss_idx]->pcc_comm_addr) {
>>   			pr_err("Failed to ioremap PCC comm region mem\n");
>>   			return -ENOMEM;
>>   		}
>>   
>>   		/* Set flag so that we dont come here for each CPU. */
>> -		pcc_data.pcc_channel_acquired = true;
>> +		pcc_data[pcc_ss_idx]->pcc_channel_acquired = true;
>>   	}
>>   
>>   	return 0;
>> @@ -600,6 +609,39 @@ bool __weak cpc_ffh_supported(void)
>>   	return false;
>>   }
>>   
>> +
>> +/**
>> + * pcc_data_alloc() - Allocate the pcc_data memory for pcc subspace
>> + *
>> + * Check and allocate the cppc_pcc_data memory.
>> + * In some processor configurations it is possible that same subspace
>> + * is shared between multiple CPU's. This is seen especially in CPU's
>> + * with hardware multi-threading support.
>> + *
>> + * Return: 0 for success, errno for failure
>> + */
>> +int pcc_data_alloc(int pcc_ss_id)
>> +{
>> +	int loop;
>> +
>> +	if (pcc_ss_id < 0)
> Above should be (pcc_ss_id < 0 || pcc_ss_id >= MAX_PCC_SUBSPACES)
Yes we can have this additional check.
>> +		return -EINVAL;
>> +
>> +	for (loop = 0; pcc_data[loop] != NULL; loop++) {
>> +		if (pcc_data[loop]->pcc_subspace_idx == pcc_ss_id) {
>> +			pcc_data[loop]->refcount++;
>> +			return 0;
>> +		}
>> +	}
> Why do we need the above for loop? can't it be direct array lookup?
> if (pcc_data[pcc_ss_id]) {
>      //increment ref_count and return
> }
Yes, we could get rid of the loop and increment the reference directly 
if already allocated.

> 
> Also, we should remove the pcc_subspace_idx from cppc_pcc_data structure,
> it is no longer useful and probably adds to confusion.
Please see below
>> +
>> +	pcc_data[pcc_ss_id] = kzalloc(sizeof(struct cppc_pcc_data), GFP_KERNEL);
>> +	if (!pcc_data[pcc_ss_id])
>> +		return -ENOMEM;
>> +	pcc_data[pcc_ss_id]->pcc_subspace_idx = pcc_ss_id;
>> +	pcc_data[pcc_ss_id]->refcount++;
>> +
>> +	return 0;
>> +}
>>   /*
>>    * An example CPC table looks like the following.
>>    *
>> @@ -661,6 +703,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>>   	struct device *cpu_dev;
>>   	acpi_handle handle = pr->handle;
>>   	unsigned int num_ent, i, cpc_rev;
>> +	int pcc_subspace_id = -1;
>>   	acpi_status status;
>>   	int ret = -EFAULT;
>>   
>> @@ -733,12 +776,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>>   			 * so extract it only once.
>>   			 */
>>   			if (gas_t->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
>> -				if (pcc_data.pcc_subspace_idx < 0)
>> -					pcc_data.pcc_subspace_idx = gas_t->access_width;
>> -				else if (pcc_data.pcc_subspace_idx != gas_t->access_width) {
>> -					pr_debug("Mismatched PCC ids.\n");
> We need to retain the above checks to make sure all PCC registers
> within a _CPC package is under same subspace. The Spec still requires:
> "If the PCC register space is used, all PCC registers, for all processors in
> the same performance domain (as defined by _PSD), must be defined
> to be in the same subspace."

So that means we need to maintain the pcc_subspace_idx in cppc_pcc_data.
If so, then I can move the check inside pcc_data_alloc().
> 
>> +				pcc_subspace_id = gas_t->access_width;
>> +				if (pcc_data_alloc(pcc_subspace_id))
>>   					goto out_free;
> We need to call pcc_data_alloc(to increment the reference) only once per CPU,
> otherwise acpi_cppc_processor_exit( ) will never free the memory allocated in
> pcc_data.

It is infact called only once per CPU, The refcounting was added in case 
if multiple CPU's share the same domain for eg:
In instances, where CPU have hardware multi-threading support.
or in cases where all CPU's are controlled using single subspace (as 
earlier).

Do you see any issue with acpi_cppc_processor_exit() in the earlier 
cases, where refcount remains > 0 and the memory not getting freed-up?
> 
> 
> --
> Thanks,
> Prashanth
> 
