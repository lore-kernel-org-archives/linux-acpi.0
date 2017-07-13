From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 2/2] ACPI / CPPC: Make cppc acpi driver aware of pcc
 subspace ids
Date: Thu, 13 Jul 2017 15:44:38 -0600
Message-ID: <84ba5386-d33b-b7e7-9295-c15f02fe1d01@codeaurora.org>
References: <1497363431-10002-1-git-send-email-george.cherian@cavium.com>
 <1497363431-10002-3-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53932 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdGMVon (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jul 2017 17:44:43 -0400
In-Reply-To: <1497363431-10002-3-git-send-email-george.cherian@cavium.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, jassisinghbrar@gmail.com, robert.moore@intel.com, lv.zheng@intel.com

Hi George,

On 6/13/2017 8:17 AM, George Cherian wrote:
> Based on ACPI 6.2 Section 8.4.7.1.9 If the PCC register space is used,
> all PCC registers, for all processors in the same performance
> domain (as defined by _PSD), must be defined to be in the same subspace.
> Based on Section 14.1 of ACPI specification, it is possible to have a
> maximum of 256 PCC subspace ids. Add support of multiple PCC subspace id
> instead of using a single global pcc_data structure.
>
> While at that fix the time_delta check in send_pcc_cmd() so that last_mpar_reset
> and mpar_count is initialized properly.
>
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>  drivers/acpi/cppc_acpi.c | 179 +++++++++++++++++++++++++----------------------
>  1 file changed, 96 insertions(+), 83 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 3ca0729..79c35b1 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -77,11 +77,10 @@ struct cppc_pcc_data {
>  	wait_queue_head_t pcc_write_wait_q;
>  };
>  
> -/* Structure to represent the single PCC channel */
> -static struct cppc_pcc_data pcc_data = {
> -	.pcc_subspace_idx = -1,
> -	.platform_owns_pcc = true,
> -};
> +/* Array  to represent the PCC channel per subspace id */
> +static struct cppc_pcc_data pcc_data[MAX_PCC_SUBSPACES];
It is unlikely we will end up using all 256 PCC subspaces, so can we
please make it a an array(size=MAX_PCC_SUBSPACES) of cppc_pcc_data
pointers. We can dynamically allocate the cppc_pcc_data structures and
maintain their references in this array.
> +/* The cpu_pcc_subspace_idx containsper CPU subspace id */
> +static DEFINE_PER_CPU(int, cpu_pcc_subspace_idx);
>  
>  /*
>   * The cpc_desc structure contains the ACPI register details
> @@ -93,7 +92,8 @@ static struct cppc_pcc_data pcc_data = {
>  static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>  
>  /* pcc mapped address + header size + offset within PCC subspace */
> -#define GET_PCC_VADDR(offs) (pcc_data.pcc_comm_addr + 0x8 + (offs))
> +#define GET_PCC_VADDR(offs, pcc_ss_id) (pcc_data[pcc_ss_id].pcc_comm_addr + \
> +						0x8 + (offs))
>  
>  /* Check if a CPC regsiter is in PCC */
>  #define CPC_IN_PCC(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&		\
> @@ -183,13 +183,16 @@ static struct kobj_type cppc_ktype = {
>  	.default_attrs = cppc_attrs,
>  };
>  
> -static int check_pcc_chan(bool chk_err_bit)
> +static int check_pcc_chan(int pcc_ss_id, bool chk_err_bit)
>  {
>  	int ret = -EIO, status = 0;
> -	struct acpi_pcct_shared_memory __iomem *generic_comm_base = pcc_data.pcc_comm_addr;
> -	ktime_t next_deadline = ktime_add(ktime_get(), pcc_data.deadline);
> +	struct cppc_pcc_data *pcc_ss_data = &pcc_data[pcc_ss_id];
> +	struct acpi_pcct_shared_memory __iomem *generic_comm_base =
> +		pcc_ss_data->pcc_comm_addr;
> +	ktime_t next_deadline = ktime_add(ktime_get(),
> +					  pcc_ss_data->deadline);
>  
> -	if (!pcc_data.platform_owns_pcc)
> +	if (!pcc_ss_data->platform_owns_pcc)
>  		return 0;
>  
>  	/* Retry in case the remote processor was too slow to catch up. */
> @@ -214,7 +217,7 @@ static int check_pcc_chan(bool chk_err_bit)
>  	}
>  
>  	if (likely(!ret))
> -		pcc_data.platform_owns_pcc = false;
> +		pcc_ss_data->platform_owns_pcc = false;
>  	else
>  		pr_err("PCC check channel failed. Status=%x\n", status);
>  
> @@ -225,11 +228,12 @@ static int check_pcc_chan(bool chk_err_bit)
>   * This function transfers the ownership of the PCC to the platform
>   * So it must be called while holding write_lock(pcc_lock)
>   */
> -static int send_pcc_cmd(u16 cmd)
> +static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
>  {
>  	int ret = -EIO, i;
> +	struct cppc_pcc_data *pcc_ss_data = &pcc_data[pcc_ss_id];
>  	struct acpi_pcct_shared_memory *generic_comm_base =
> -		(struct acpi_pcct_shared_memory *) pcc_data.pcc_comm_addr;
> +		(struct acpi_pcct_shared_memory *)pcc_ss_data->pcc_comm_addr;
>  	static ktime_t last_cmd_cmpl_time, last_mpar_reset;
>  	static int mpar_count;
Since we had only one PCC channel until ACPI6.1, it was ok to maintain
these (mpar_count, last_cmd_cmpl_time, last_mpar_reset) here as static
variables.
Now that we are supporting multiple PCC subspaces these should be
maintained per PCC subspaces. Can you please move these over to the
cppc_pcc_data?
>  	unsigned int time_delta;
> @@ -244,24 +248,24 @@ static int send_pcc_cmd(u16 cmd)
>  		 * before write completion, so first send a WRITE command to
>  		 * platform
>  		 */
> -		if (pcc_data.pending_pcc_write_cmd)
> -			send_pcc_cmd(CMD_WRITE);
> +		if (pcc_ss_data->pending_pcc_write_cmd)
> +			send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>  
> -		ret = check_pcc_chan(false);
> +		ret = check_pcc_chan(pcc_ss_id, false);
>  		if (ret)
>  			goto end;
>  	} else /* CMD_WRITE */
> -		pcc_data.pending_pcc_write_cmd = FALSE;
> +		pcc_ss_data->pending_pcc_write_cmd = FALSE;
>  
>  	/*
>  	 * Handle the Minimum Request Turnaround Time(MRTT)
>  	 * "The minimum amount of time that OSPM must wait after the completion
>  	 * of a command before issuing the next command, in microseconds"
>  	 */
> -	if (pcc_data.pcc_mrtt) {
> +	if (pcc_ss_data->pcc_mrtt) {
>  		time_delta = ktime_us_delta(ktime_get(), last_cmd_cmpl_time);
> -		if (pcc_data.pcc_mrtt > time_delta)
> -			udelay(pcc_data.pcc_mrtt - time_delta);
> +		if (pcc_ss_data->pcc_mrtt > time_delta)
> +			udelay(pcc_ss_data->pcc_mrtt - time_delta);
>  	}
>  
>  	/*
> @@ -275,16 +279,16 @@ static int send_pcc_cmd(u16 cmd)
>  	 * not send the request to the platform after hitting the MPAR limit in
>  	 * any 60s window
>  	 */
> -	if (pcc_data.pcc_mpar) {
> +	if (pcc_ss_data->pcc_mpar) {
>  		if (mpar_count == 0) {
>  			time_delta = ktime_ms_delta(ktime_get(), last_mpar_reset);
> -			if (time_delta < 60 * MSEC_PER_SEC) {
> +			if ((time_delta < 60 * MSEC_PER_SEC) && last_mpar_reset) {
>  				pr_debug("PCC cmd not sent due to MPAR limit");
>  				ret = -EIO;
>  				goto end;
>  			}
>  			last_mpar_reset = ktime_get();
> -			mpar_count = pcc_data.pcc_mpar;
> +			mpar_count = pcc_ss_data->pcc_mpar;
>  		}
>  		mpar_count--;
>  	}
The above mpar and mrtt checks should be modified to use per subspace variables.
> @@ -295,10 +299,10 @@ static int send_pcc_cmd(u16 cmd)
>  	/* Flip CMD COMPLETE bit */
>  	writew_relaxed(0, &generic_comm_base->status);
>  
> -	pcc_data.platform_owns_pcc = true;
> +	pcc_ss_data->platform_owns_pcc = true;
>  
>  	/* Ring doorbell */
> -	ret = mbox_send_message(pcc_data.pcc_channel, &cmd);
> +	ret = mbox_send_message(pcc_ss_data->pcc_channel, &cmd);
>  	if (ret < 0) {
>  		pr_err("Err sending PCC mbox message. cmd:%d, ret:%d\n",
>  				cmd, ret);
> @@ -306,15 +310,15 @@ static int send_pcc_cmd(u16 cmd)
>  	}
>  
>  	/* wait for completion and check for PCC errro bit */
> -	ret = check_pcc_chan(true);
> +	ret = check_pcc_chan(pcc_ss_id, true);
>  
> -	if (pcc_data.pcc_mrtt)
> +	if (pcc_ss_data->pcc_mrtt)
>  		last_cmd_cmpl_time = ktime_get();
>  
> -	if (pcc_data.pcc_channel->mbox->txdone_irq)
> -		mbox_chan_txdone(pcc_data.pcc_channel, ret);
> +	if (pcc_ss_data->pcc_channel->mbox->txdone_irq)
> +		mbox_chan_txdone(pcc_ss_data->pcc_channel, ret);
>  	else
> -		mbox_client_txdone(pcc_data.pcc_channel, ret);
> +		mbox_client_txdone(pcc_ss_data->pcc_channel, ret);
>  
>  end:
>  	if (cmd == CMD_WRITE) {
> @@ -324,12 +328,12 @@ static int send_pcc_cmd(u16 cmd)
>  				if (!desc)
>  					continue;
>  
> -				if (desc->write_cmd_id == pcc_data.pcc_write_cnt)
> +				if (desc->write_cmd_id == pcc_ss_data->pcc_write_cnt)
>  					desc->write_cmd_status = ret;
>  			}
>  		}
> -		pcc_data.pcc_write_cnt++;
> -		wake_up_all(&pcc_data.pcc_write_wait_q);
> +		pcc_ss_data->pcc_write_cnt++;
> +		wake_up_all(&pcc_ss_data->pcc_write_wait_q);
>  	}
>  
>  	return ret;
> @@ -531,16 +535,16 @@ int acpi_get_psd_map(struct cppc_cpudata **all_cpu_data)
>  }
>  EXPORT_SYMBOL_GPL(acpi_get_psd_map);
>  
> -static int register_pcc_channel(int pcc_subspace_idx)
> +static int register_pcc_channel(int pcc_ss_idx)
>  {
>  	struct acpi_pcct_hw_reduced *cppc_ss;
>  	u64 usecs_lat;
>  
> -	if (pcc_subspace_idx >= 0) {
> -		pcc_data.pcc_channel = pcc_mbox_request_channel(&cppc_mbox_cl,
> -				pcc_subspace_idx);
> +	if (pcc_ss_idx >= 0) {
> +		pcc_data[pcc_ss_idx].pcc_channel =
> +			pcc_mbox_request_channel(&cppc_mbox_cl,	pcc_ss_idx);
>  
> -		if (IS_ERR(pcc_data.pcc_channel)) {
> +		if (IS_ERR(pcc_data[pcc_ss_idx].pcc_channel)) {
>  			pr_err("Failed to find PCC communication channel\n");
>  			return -ENODEV;
>  		}
> @@ -551,7 +555,7 @@ static int register_pcc_channel(int pcc_subspace_idx)
>  		 * PCC channels) and stored pointers to the
>  		 * subspace communication region in con_priv.
>  		 */
> -		cppc_ss = (pcc_data.pcc_channel)->con_priv;
> +		cppc_ss = (pcc_data[pcc_ss_idx].pcc_channel)->con_priv;
>  
>  		if (!cppc_ss) {
>  			pr_err("No PCC subspace found for CPPC\n");
> @@ -564,19 +568,20 @@ static int register_pcc_channel(int pcc_subspace_idx)
>  		 * So add an arbitrary amount of wait on top of Nominal.
>  		 */
>  		usecs_lat = NUM_RETRIES * cppc_ss->latency;
> -		pcc_data.deadline = ns_to_ktime(usecs_lat * NSEC_PER_USEC);
> -		pcc_data.pcc_mrtt = cppc_ss->min_turnaround_time;
> -		pcc_data.pcc_mpar = cppc_ss->max_access_rate;
> -		pcc_data.pcc_nominal = cppc_ss->latency;
> -
> -		pcc_data.pcc_comm_addr = acpi_os_ioremap(cppc_ss->base_address, cppc_ss->length);
> -		if (!pcc_data.pcc_comm_addr) {
> +		pcc_data[pcc_ss_idx].deadline = ns_to_ktime(usecs_lat * NSEC_PER_USEC);
> +		pcc_data[pcc_ss_idx].pcc_mrtt = cppc_ss->min_turnaround_time;
> +		pcc_data[pcc_ss_idx].pcc_mpar = cppc_ss->max_access_rate;
> +		pcc_data[pcc_ss_idx].pcc_nominal = cppc_ss->latency;
> +
> +		pcc_data[pcc_ss_idx].pcc_comm_addr =
> +			acpi_os_ioremap(cppc_ss->base_address, cppc_ss->length);
> +		if (!pcc_data[pcc_ss_idx].pcc_comm_addr) {
>  			pr_err("Failed to ioremap PCC comm region mem\n");
>  			return -ENOMEM;
>  		}
>  
>  		/* Set flag so that we dont come here for each CPU. */
> -		pcc_data.pcc_channel_acquired = true;
> +		pcc_data[pcc_ss_idx].pcc_channel_acquired = true;
>  	}
>  
>  	return 0;
> @@ -656,6 +661,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  	struct device *cpu_dev;
>  	acpi_handle handle = pr->handle;
>  	unsigned int num_ent, i, cpc_rev;
> +	unsigned int pcc_subspace_id = 0;
>  	acpi_status status;
>  	int ret = -EFAULT;
>  
> @@ -728,12 +734,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  			 * so extract it only once.
>  			 */
>  			if (gas_t->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
> -				if (pcc_data.pcc_subspace_idx < 0)
> -					pcc_data.pcc_subspace_idx = gas_t->access_width;
> -				else if (pcc_data.pcc_subspace_idx != gas_t->access_width) {
> -					pr_debug("Mismatched PCC ids.\n");
> -					goto out_free;
> -				}
> +				pcc_subspace_id = gas_t->access_width;
> +				pcc_data[pcc_subspace_id].pcc_subspace_idx = gas_t->access_width;
> +				per_cpu(cpu_pcc_subspace_idx, pr->id) = gas_t->access_width;
pcc_data[pcc_subspace_id].pcc_subspace_idx = pcc_subspace_id;
per_cpu(cpu_pcc_subspace_idx, pr->id) = pcc_subspace_id;

I don't see a need for pcc_subspace_idx to be in struct cppc_pcc_data
anymore.  If you agree, may be we can remove it.

>  			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>  				if (gas_t->address) {
>  					void __iomem *addr;
> @@ -766,14 +769,14 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  	if (ret)
>  		goto out_free;
>  
> -	/* Register PCC channel once for all CPUs. */
> -	if (!pcc_data.pcc_channel_acquired) {
> -		ret = register_pcc_channel(pcc_data.pcc_subspace_idx);
> +	/* Register PCC channel once for all PCC subspace id. */
> +	if (!pcc_data[pcc_subspace_id].pcc_channel_acquired) {
Looks like we assume a PCC subspace is always present and looking at the
6.2 spec it doesn't look like a mandatory requirement. So, the correct check
here should be:
if (pcc_subspace_id is valid && !pcc_data[pcc_subspace_id].pcc_channel_acquired)

We need to make sure pcc_subspace_id is set to an invalid value until we find a valid
PCC subspace within the _CPC package. You can correct this in next version or I can
submit a small patch.
> +		ret = register_pcc_channel(pcc_data[pcc_subspace_id].pcc_subspace_idx);
>  		if (ret)
>  			goto out_free;
>  
> -		init_rwsem(&pcc_data.pcc_lock);
> -		init_waitqueue_head(&pcc_data.pcc_write_wait_q);
> +		init_rwsem(&pcc_data[pcc_subspace_id].pcc_lock);
> +		init_waitqueue_head(&pcc_data[pcc_subspace_id].pcc_write_wait_q);
>  	}
>  
>  	/* Everything looks okay */
> @@ -883,6 +886,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>  {
>  	int ret_val = 0;
>  	void __iomem *vaddr = 0;
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>  	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>  
>  	if (reg_res->type == ACPI_TYPE_INTEGER) {
> @@ -892,7 +896,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>  
>  	*val = 0;
>  	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM)
> -		vaddr = GET_PCC_VADDR(reg->address);
> +		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
>  	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>  		vaddr = reg_res->sys_mem_vaddr;
>  	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
> @@ -927,10 +931,11 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>  {
>  	int ret_val = 0;
>  	void __iomem *vaddr = 0;
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>  	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>  
>  	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM)
> -		vaddr = GET_PCC_VADDR(reg->address);
> +		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
>  	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>  		vaddr = reg_res->sys_mem_vaddr;
>  	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
> @@ -974,6 +979,8 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>  	struct cpc_register_resource *highest_reg, *lowest_reg, *ref_perf,
>  								 *nom_perf;
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> +	struct cppc_pcc_data *pcc_ss_data = &pcc_data[pcc_ss_id];
>  	u64 high, low, nom;
>  	int ret = 0, regs_in_pcc = 0;
>  
> @@ -991,9 +998,9 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  	if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
>  		CPC_IN_PCC(ref_perf) || CPC_IN_PCC(nom_perf)) {
>  		regs_in_pcc = 1;
> -		down_write(&pcc_data.pcc_lock);
> +		down_write(&pcc_ss_data->pcc_lock);
>  		/* Ring doorbell once to update PCC subspace */
> -		if (send_pcc_cmd(CMD_READ) < 0) {
> +		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
>  			ret = -EIO;
>  			goto out_err;
>  		}
> @@ -1013,7 +1020,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  
>  out_err:
>  	if (regs_in_pcc)
> -		up_write(&pcc_data.pcc_lock);
> +		up_write(&pcc_ss_data->pcc_lock);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
> @@ -1030,6 +1037,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>  	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>  	struct cpc_register_resource *delivered_reg, *reference_reg,
>  		*ref_perf_reg, *ctr_wrap_reg;
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> +	struct cppc_pcc_data *pcc_ss_data = &pcc_data[pcc_ss_id];
>  	u64 delivered, reference, ref_perf, ctr_wrap_time;
>  	int ret = 0, regs_in_pcc = 0;
>  
> @@ -1053,10 +1062,10 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>  	/* Are any of the regs PCC ?*/
>  	if (CPC_IN_PCC(delivered_reg) || CPC_IN_PCC(reference_reg) ||
>  		CPC_IN_PCC(ctr_wrap_reg) || CPC_IN_PCC(ref_perf_reg)) {
> -		down_write(&pcc_data.pcc_lock);
> +		down_write(&pcc_ss_data->pcc_lock);
>  		regs_in_pcc = 1;
>  		/* Ring doorbell once to update PCC subspace */
> -		if (send_pcc_cmd(CMD_READ) < 0) {
> +		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
>  			ret = -EIO;
>  			goto out_err;
>  		}
> @@ -1086,7 +1095,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>  	perf_fb_ctrs->ctr_wrap_time = ctr_wrap_time;
>  out_err:
>  	if (regs_in_pcc)
> -		up_write(&pcc_data.pcc_lock);
> +		up_write(&pcc_ss_data->pcc_lock);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
> @@ -1102,6 +1111,8 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  {
>  	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>  	struct cpc_register_resource *desired_reg;
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = &pcc_data[pcc_ss_id];
>  	int ret = 0;
>  
>  	if (!cpc_desc) {
> @@ -1119,11 +1130,11 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  	 * achieve that goal here
>  	 */
>  	if (CPC_IN_PCC(desired_reg)) {
> -		down_read(&pcc_data.pcc_lock);	/* BEGIN Phase-I */
> -		if (pcc_data.platform_owns_pcc) {
> -			ret = check_pcc_chan(false);
> +		down_read(&pcc_ss_data->pcc_lock); /* BEGIN Phase-I */
> +		if (pcc_ss_data->platform_owns_pcc) {
> +			ret = check_pcc_chan(pcc_ss_id, false);
>  			if (ret) {
> -				up_read(&pcc_data.pcc_lock);
> +				up_read(&pcc_ss_data->pcc_lock);
>  				return ret;
>  			}
>  		}
> @@ -1131,8 +1142,8 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  		 * Update the pending_write to make sure a PCC CMD_READ will not
>  		 * arrive and steal the channel during the switch to write lock
>  		 */
> -		pcc_data.pending_pcc_write_cmd = true;
> -		cpc_desc->write_cmd_id = pcc_data.pcc_write_cnt;
> +		pcc_ss_data->pending_pcc_write_cmd = true;
> +		cpc_desc->write_cmd_id = pcc_ss_data->pcc_write_cnt;
>  		cpc_desc->write_cmd_status = 0;
>  	}
>  
> @@ -1143,7 +1154,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  	cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
>  
>  	if (CPC_IN_PCC(desired_reg))
> -		up_read(&pcc_data.pcc_lock);	/* END Phase-I */
> +		up_read(&pcc_ss_data->pcc_lock);	/* END Phase-I */
>  	/*
>  	 * This is Phase-II where we transfer the ownership of PCC to Platform
>  	 *
> @@ -1191,15 +1202,15 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  	 * the write command before servicing the read command
>  	 */
>  	if (CPC_IN_PCC(desired_reg)) {
> -		if (down_write_trylock(&pcc_data.pcc_lock)) {	/* BEGIN Phase-II */
> +		if (down_write_trylock(&pcc_ss_data->pcc_lock)) {/* BEGIN Phase-II */
>  			/* Update only if there are pending write commands */
> -			if (pcc_data.pending_pcc_write_cmd)
> -				send_pcc_cmd(CMD_WRITE);
> -			up_write(&pcc_data.pcc_lock);		/* END Phase-II */
> +			if (pcc_ss_data->pending_pcc_write_cmd)
> +				send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> +			up_write(&pcc_ss_data->pcc_lock);	/* END Phase-II */
>  		} else
>  			/* Wait until pcc_write_cnt is updated by send_pcc_cmd */
> -			wait_event(pcc_data.pcc_write_wait_q,
> -				cpc_desc->write_cmd_id != pcc_data.pcc_write_cnt);
> +			wait_event(pcc_ss_data->pcc_write_wait_q,
> +				   cpc_desc->write_cmd_id != pcc_ss_data->pcc_write_cnt);
>  
>  		/* send_pcc_cmd updates the status in case of failure */
>  		ret = cpc_desc->write_cmd_status;
> @@ -1232,6 +1243,8 @@ unsigned int cppc_get_transition_latency(int cpu_num)
>  	unsigned int latency_ns = 0;
>  	struct cpc_desc *cpc_desc;
>  	struct cpc_register_resource *desired_reg;
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu_num);
> +	struct cppc_pcc_data *pcc_ss_data = &pcc_data[pcc_ss_id];
>  
>  	cpc_desc = per_cpu(cpc_desc_ptr, cpu_num);
>  	if (!cpc_desc)
> @@ -1241,11 +1254,11 @@ unsigned int cppc_get_transition_latency(int cpu_num)
>  	if (!CPC_IN_PCC(desired_reg))
>  		return CPUFREQ_ETERNAL;
>  
> -	if (pcc_data.pcc_mpar)
> -		latency_ns = 60 * (1000 * 1000 * 1000 / pcc_data.pcc_mpar);
> +	if (pcc_ss_data->pcc_mpar)
> +		latency_ns = 60 * (1000 * 1000 * 1000 / pcc_ss_data->pcc_mpar);
>  
> -	latency_ns = max(latency_ns, pcc_data.pcc_nominal * 1000);
> -	latency_ns = max(latency_ns, pcc_data.pcc_mrtt * 1000);
> +	latency_ns = max(latency_ns, pcc_ss_data->pcc_nominal * 1000);
> +	latency_ns = max(latency_ns, pcc_ss_data->pcc_mrtt * 1000);
>  
>  	return latency_ns;
>  }

When you send the next version with updates, can you please add a version
to the patches ex: [PATCH v2 2/2]? I think this series is v2, as it addresses some
of Alexey's  comments on the initial version.

--
Thanks,
Prashanth

