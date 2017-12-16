From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / CPPC: Fix negative array index read in cppc_set_perf
Date: Sat, 16 Dec 2017 02:47:30 +0100
Message-ID: <1775451.pdUQMu89xf@aspire.rjw.lan>
References: <20171213224541.GA31477@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41958 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755868AbdLPBsR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Dec 2017 20:48:17 -0500
In-Reply-To: <20171213224541.GA31477@embeddedor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Len Brown <lenb@kernel.org>, George Cherian <george.cherian@cavium.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, December 13, 2017 11:45:41 PM CET Gustavo A. R. Silva wrote:
> If pcc_ss_id is less than 0, there is a negative array index read
> before verifying pcc_ss_id is not a negative value.
> 
> Fix this by removing the code that triggers this issue.
> 
> Notice that this code is already properly placed after the check
> on pcc_ss_id at line 1182: pcc_ss_data = pcc_data[pcc_ss_id];
> 
> Addresses-Coverity-ID: 1426090 ("Negative array index read")
> Fixes: 1ecbd7170d65 ("ACPI / CPPC: Fix KASAN global out of bounds warning")
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/acpi/cppc_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 30e84cc..06ea474 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1171,7 +1171,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>  	struct cpc_register_resource *desired_reg;
>  	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> -	struct cppc_pcc_data *pcc_ss_data = pcc_data[pcc_ss_id];
> +	struct cppc_pcc_data *pcc_ss_data;
>  	int ret = 0;
>  
>  	if (!cpc_desc || pcc_ss_id < 0) {
> 

I applied a patch from Coling Ian King that did the same thing and was
posted eaelier.

Thanks,
Rafael


