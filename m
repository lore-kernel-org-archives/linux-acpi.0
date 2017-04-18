From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 1/2] ACPI / CPPC: Read lowest non linear perf in cppc_get_perf_caps
Date: Tue, 18 Apr 2017 16:28:49 +0200
Message-ID: <1509183.UhELQJrXFv@aspire.rjw.lan>
References: <1490817000-13876-1-git-send-email-pprakash@codeaurora.org> <1490817000-13876-2-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59967 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753767AbdDROey (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 10:34:54 -0400
In-Reply-To: <1490817000-13876-2-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, hotran@apm.com, ahs3@redhat.com

On Wednesday, March 29, 2017 01:49:59 PM Prashanth Prakash wrote:
> Read lowest non linear perf in cppc_get_perf_caps so that it can be exposed
> via sysfs to the usespace. Lowest non linear perf is the lowest performance
> level at which nonlinear power savings are achieved.
> 
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>

Except that I would spell "nonlinear" as one word which appears to be a common
practice, it looks OK to me.

> ---
>  drivers/acpi/cppc_acpi.c | 19 +++++++++++--------
>  include/acpi/cppc_acpi.h |  1 +
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 3ca0729..f5f3c29 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -972,9 +972,9 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>  int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  {
>  	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> -	struct cpc_register_resource *highest_reg, *lowest_reg, *ref_perf,
> -								 *nom_perf;
> -	u64 high, low, nom;
> +	struct cpc_register_resource *highest_reg, *lowest_reg,
> +		*lowest_non_linear_reg, *nominal_reg;
> +	u64 high, low, nom, low_non_linear;

min_nonlinear here?

>  	int ret = 0, regs_in_pcc = 0;
>  
>  	if (!cpc_desc) {
> @@ -984,12 +984,12 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  
>  	highest_reg = &cpc_desc->cpc_regs[HIGHEST_PERF];
>  	lowest_reg = &cpc_desc->cpc_regs[LOWEST_PERF];
> -	ref_perf = &cpc_desc->cpc_regs[REFERENCE_PERF];
> -	nom_perf = &cpc_desc->cpc_regs[NOMINAL_PERF];
> +	lowest_non_linear_reg = &cpc_desc->cpc_regs[LOW_NON_LINEAR_PERF];
> +	nominal_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
>  
>  	/* Are any of the regs PCC ?*/
>  	if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
> -		CPC_IN_PCC(ref_perf) || CPC_IN_PCC(nom_perf)) {
> +		CPC_IN_PCC(lowest_non_linear_reg) || CPC_IN_PCC(nominal_reg)) {
>  		regs_in_pcc = 1;
>  		down_write(&pcc_data.pcc_lock);
>  		/* Ring doorbell once to update PCC subspace */
> @@ -1005,10 +1005,13 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  	cpc_read(cpunum, lowest_reg, &low);
>  	perf_caps->lowest_perf = low;
>  
> -	cpc_read(cpunum, nom_perf, &nom);
> +	cpc_read(cpunum, nominal_reg, &nom);
>  	perf_caps->nominal_perf = nom;
>  
> -	if (!high || !low || !nom)
> +	cpc_read(cpunum, lowest_non_linear_reg, &low_non_linear);
> +	perf_caps->lowest_non_linear_perf = low_non_linear;
> +
> +	if (!high || !low || !nom || !low_non_linear)
>  		ret = -EFAULT;
>  
>  out_err:
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 427a7c3..3f64660 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -103,6 +103,7 @@ struct cppc_perf_caps {
>  	u32 highest_perf;
>  	u32 nominal_perf;
>  	u32 lowest_perf;
> +	u32 lowest_non_linear_perf;
>  };
>  
>  struct cppc_perf_ctrls {
> 

I can make the above changes for you if you agree. :-)

Thanks,
Rafael

