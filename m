From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / CPPC: remove initial assignment of pcc_ss_data
Date: Sat, 16 Dec 2017 02:49:02 +0100
Message-ID: <3514960.SrIDOzrZqR@aspire.rjw.lan>
References: <20171208235949.15713-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63262 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755884AbdLPBts (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Dec 2017 20:49:48 -0500
In-Reply-To: <20171208235949.15713-1-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, December 9, 2017 12:59:49 AM CET Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The initialization of pcc_ss_data from pcc_data[pcc_ss_id] before
> pcc_ss_id is being range checked could lead to an out-of-bounds array
> read.  This very same initialization is also being performed after
> the range check on pcc_ss_id, so we can just remove this problematic
> and also redundant assignment to fix the issue.
> 
> Detected by cppcheck:
> warning: Value stored to 'pcc_ss_data' during its initialization is never
> read
> 
> Fixes: commit 85b1407bf6d2 ("ACPI / CPPC: Make CPPC ACPI driver aware of PCC subspace IDs")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/acpi/cppc_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 30e84cc600ae..06ea4749ebd9 100644
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

Applied, thanks!

