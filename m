From: Alexey Klimov <alexey.klimov@arm.com>
Subject: Re: [PATCH V2 4/5] ACPI/CPPC: set a non-zero value for
 transition_latency
Date: Mon, 8 Aug 2016 12:01:53 +0100
Message-ID: <20160808110153.GA27382@arm.com>
References: <1469562328-10201-1-git-send-email-pprakash@codeaurora.org>
 <1469562328-10201-5-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35239 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014AbcHHLCZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Aug 2016 07:02:25 -0400
Content-Disposition: inline
In-Reply-To: <1469562328-10201-5-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, hotran@apm.com, cov@codeaurora.org

On Tue, Jul 26, 2016 at 01:45:27PM -0600, Prashanth Prakash wrote:
> Compute the expected transition latency for frequency transitions
> using the values from the PCCT tables when the desired perf
> register is in PCC.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>


Reviewed-by: Alexey Klimov <alexey.klimov@arm.com>


> ---
>  drivers/acpi/cppc_acpi.c       | 46 ++++++++++++++++++++++++++++++++++++++++--
>  drivers/cpufreq/cppc_cpufreq.c |  1 +
>  include/acpi/cppc_acpi.h       |  1 +
>  3 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 4a887d4..93abaec 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -85,7 +85,7 @@ static void __iomem *pcc_comm_addr;
>  static int pcc_subspace_idx = -1;
>  static bool pcc_channel_acquired;
>  static ktime_t deadline;
> -static unsigned int pcc_mpar, pcc_mrtt;
> +static unsigned int pcc_mpar, pcc_mrtt, pcc_nominal;
>  
>  /* pcc mapped address + header size + offset within PCC subspace */
>  #define GET_PCC_VADDR(offs) (pcc_comm_addr + 0x8 + (offs))
> @@ -462,7 +462,6 @@ static int register_pcc_channel(int pcc_subspace_idx)
>  			return -ENODEV;
>  		}
>  
> -
>  		/*
>  		 * cppc_ss->latency is just a Nominal value. In reality
>  		 * the remote processor could be much slower to reply.
> @@ -472,6 +471,7 @@ static int register_pcc_channel(int pcc_subspace_idx)

