From: George Cherian <gcherian@caviumnetworks.com>
Subject: Re: [PATCH] ACPI / CPPC: Fix negative array index read in
 cppc_set_perf
Date: Fri, 15 Dec 2017 23:48:31 +0530
Message-ID: <af3b5407-065c-51b2-6161-398bdf5af765@caviumnetworks.com>
References: <20171213224541.GA31477@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-dm3nam03on0079.outbound.protection.outlook.com ([104.47.41.79]:8416
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755419AbdLOSSh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Dec 2017 13:18:37 -0500
In-Reply-To: <20171213224541.GA31477@embeddedor.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, George Cherian <george.cherian@cavium.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org



On Thursday 14 December 2017 04:15 AM, Gustavo A. R. Silva wrote:
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

Reviewed-by: George Cherian <george.cherian@cavium.com>


> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>   drivers/acpi/cppc_acpi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 30e84cc..06ea474 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1171,7 +1171,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>   	struct cpc_register_resource *desired_reg;
>   	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> -	struct cppc_pcc_data *pcc_ss_data = pcc_data[pcc_ss_id];
> +	struct cppc_pcc_data *pcc_ss_data;
>   	int ret = 0;
>   
>   	if (!cpc_desc || pcc_ss_id < 0) {

