From: Alexey Klimov <alexey.klimov@arm.com>
Subject: Re: [PATCH 2/2] ACPI / CPPC: Make cppc acpi driver aware of pcc
 subspace ids
Date: Mon, 3 Apr 2017 18:37:46 +0100
Message-ID: <20170403173746.GA27057@arm.com>
References: <1490941442-11954-1-git-send-email-george.cherian@cavium.com>
 <1490941442-11954-3-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753321AbdDCRh5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 3 Apr 2017 13:37:57 -0400
Content-Disposition: inline
In-Reply-To: <1490941442-11954-3-git-send-email-george.cherian@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org, ashwin.chaugule@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, jassisinghbrar@gmail.com, robert.moore@intel.com, lv.zheng@intel.com, pprakash@codeaurora.org

(adding Prashanth to c/c)

Hi George,

On Fri, Mar 31, 2017 at 06:24:02AM +0000, George Cherian wrote:
> Based on Section 14.1 of ACPI specification, it is possible to have a
> maximum of 256 PCC subspace ids. Add support of multiple PCC subspace id
> instead of using a single global pcc_data structure.
> 
> While at that fix the time_delta check in send_pcc_cmd() so that last_mpar_reset
> and mpar_count is initialized properly. Also maintain a global total_mpar_count
> which is a sum of per subspace id mpar value.

Could you please provide clarification on why sum of total_mpar_count is
required? Do you assume that there always will be only one single firmware CPU
that handles PCC commands on another side?

Theoretically different PCC channels can be connected to different platform CPUs
on other end (imagine NUMA systems in case of CPPC) so it's not clear why transport
layer of PCC should use that global count. Also, ACPI spec 6.1 (page 701) in
in description of MPAR states "The maximum number of periodic requests that the subspace
channel can support".



> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>  drivers/acpi/cppc_acpi.c | 189 ++++++++++++++++++++++++++---------------------
>  1 file changed, 105 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 3ca0729..7ba05ac 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -77,12 +77,16 @@ struct cppc_pcc_data {
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
> +/*
> + * It is quiet possible that multiple CPU's can share
> + * same subspace ids. The cpu_pcc_subspace_idx maintains
> + * the cpu to pcc subspace id map.
> + */
> +static DEFINE_PER_CPU(int, cpu_pcc_subspace_idx);
>  
> +static int total_mpar_count;
>  /*
>   * The cpc_desc structure contains the ACPI register details
>   * as described in the per CPU _CPC tables. The details
> @@ -93,7 +97,8 @@ static struct cppc_pcc_data pcc_data = {
>  static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>  
>  /* pcc mapped address + header size + offset within PCC subspace */
> -#define GET_PCC_VADDR(offs) (pcc_data.pcc_comm_addr + 0x8 + (offs))
> +#define GET_PCC_VADDR(offs, pcc_ss_id) (pcc_data[pcc_ss_id].pcc_comm_addr + \
> +						0x8 + (offs))
>  
>  /* Check if a CPC regsiter is in PCC */
>  #define CPC_IN_PCC(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&		\
> @@ -183,13 +188,17 @@ static struct kobj_type cppc_ktype = {
>  	.default_attrs = cppc_attrs,
>  };
>  
> -static int check_pcc_chan(bool chk_err_bit)
> +static int check_pcc_chan(int cpunum, bool chk_err_bit)
>  {
>  	int ret = -EIO, status = 0;
> -	struct acpi_pcct_shared_memory __iomem *generic_comm_base = pcc_data.pcc_comm_addr;
> -	ktime_t next_deadline = ktime_add(ktime_get(), pcc_data.deadline);
> -
> -	if (!pcc_data.platform_owns_pcc)
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> +	struct cppc_pcc_data *pcc_ss_data = &pcc_data[pcc_ss_id];
> +	struct acpi_pcct_shared_memory __iomem *generic_comm_base =
> +		pcc_ss_data->pcc_comm_addr;
> +	ktime_t next_deadline = ktime_add(ktime_get(),
> +					  pcc_ss_data->deadline);
> +
> +	if (!pcc_ss_data->platform_owns_pcc)
>  		return 0;
>  
>  	/* Retry in case the remote processor was too slow to catch up. */
> @@ -214,7 +223,7 @@ static int check_pcc_chan(bool chk_err_bit)
>  	}
>  
>  	if (likely(!ret))
> -		pcc_data.platform_owns_pcc = false;
> +		pcc_ss_data->platform_owns_pcc = false;
>  	else
>  		pr_err("PCC check channel failed. Status=%x\n", status);
>  
> @@ -225,11 +234,13 @@ static int check_pcc_chan(bool chk_err_bit)
>   * This function transfers the ownership of the PCC to the platform
>   * So it must be called while holding write_lock(pcc_lock)
>   */
> -static int send_pcc_cmd(u16 cmd)
> +static int send_pcc_cmd(int cpunum, u16 cmd)


I don't like the direction of where it's going.

To send commands through PCC channel you don't need to know CPU number.
Ideally, send_pcc_cmd() shouldn't care a lot about software entity that uses
it (CPPC, RASF, MPST, etc) and passing some CPU number to this function you
bind it to CPPC interfaces while it shouldn't depend on it.
Maybe you can pass subspace it here instead.

BTW, is it possible to make separate mailbox PCC client and move it out from
CPPC code?


[...]


Best regards,
Alexey Klimov.


