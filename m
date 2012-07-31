From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] ACPI processor: Fix a typo error in commit 99b725084
Date: Tue, 31 Jul 2012 22:48:25 +0530
Message-ID: <50181361.2030905@linux.vnet.ibm.com>
References: <1343709883-16801-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:42817 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789Ab2GaRSd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jul 2012 13:18:33 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <deepthi@linux.vnet.ibm.com>;
	Wed, 1 Aug 2012 03:18:09 +1000
In-Reply-To: <1343709883-16801-1-git-send-email-feng.tang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, Thomas Renninger <trenn@suse.de>

On 07/31/2012 10:14 AM, Feng Tang wrote:

> In commit 99b725084 "ACPI processor hotplug: Delay acpi_processor_start()
> call for hotplugged cores", acpi_processor_hotplug(pr) was wrongly replaced
> by acpi_processor_cst_has_changed() inside the acpi_cpu_soft_notify(). This
> patch will restore it back, which also fixes a tick_broadcast_mask regression:
> 	https://lkml.org/lkml/2012/7/30/169

Reviewed-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

> [Resend to ACPI mail list and Cc stable kernel]
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Cc: Thomas Renninger <trenn@suse.de>
> Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
> Cc: <stable@vger.kernel.org> # 3.3+
> ---
>  drivers/acpi/processor_driver.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index ff8e04f..bfc31cb 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -437,7 +437,7 @@ static int acpi_cpu_soft_notify(struct notifier_block *nfb,
>  		/* Normal CPU soft online event */
>  		} else {
>  			acpi_processor_ppc_has_changed(pr, 0);
> -			acpi_processor_cst_has_changed(pr);
> +			acpi_processor_hotplug(pr);
>  			acpi_processor_reevaluate_tstate(pr, action);
>  			acpi_processor_tstate_has_changed(pr);
>  		}


Cheers,
Deepthi

