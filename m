From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] ACPI / CPPC: FIX KASAN global out of bounds warning
Date: Wed, 13 Dec 2017 09:55:23 -0600
Message-ID: <20171213155523.GA182892@bhelgaas-glaptop.roam.corp.google.com>
References: <1512396414-1024-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753139AbdLMPz0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Dec 2017 10:55:26 -0500
Content-Disposition: inline
In-Reply-To: <1512396414-1024-1-git-send-email-george.cherian@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net, changbin.du@intel.com

On Mon, Dec 04, 2017 at 02:06:54PM +0000, George Cherian wrote:
> Default value of pcc_subspace_idx is -1.
> Make sure to check pcc_subspace_idx before using the same as array index.
> This will avoid following KASAN warnings too.

> @@ -1172,11 +1174,12 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  	struct cppc_pcc_data *pcc_ss_data = pcc_data[pcc_ss_id];

I think you forgot to remove this initialization.  Coverity reported this:

  *** CID 1426090:  Memory - illegal accesses  (REVERSE_NEGATIVE)
  /drivers/acpi/cppc_acpi.c: 1177 in cppc_set_perf()
  1171            struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
  1172            struct cpc_register_resource *desired_reg;
  1173            int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
  1174            struct cppc_pcc_data *pcc_ss_data = pcc_data[pcc_ss_id];
  1175            int ret = 0;
  1176
  >>>     CID 1426090:  Memory - illegal accesses  (REVERSE_NEGATIVE)
  >>>     You might be using variable "pcc_ss_id" before verifying that it is >= 0.
  1177            if (!cpc_desc || pcc_ss_id < 0) {
  1178                    pr_debug("No CPC descriptor for CPU:%d\n", cpu);
  1179                    return -ENODEV;
  1180            }
  1181
  1182            pcc_ss_data = pcc_data[pcc_ss_id];

>  	int ret = 0;
>  
> -	if (!cpc_desc) {
> +	if (!cpc_desc || pcc_ss_id < 0) {
>  		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>  		return -ENODEV;
>  	}
>  
> +	pcc_ss_data = pcc_data[pcc_ss_id];
>  	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>  
>  	/*
