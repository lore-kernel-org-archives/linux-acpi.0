From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 5/5][RFC] cpuidle : add cpuidle_register_states function
Date: Mon, 3 Sep 2012 16:22:45 +0300
Message-ID: <20120903132245.GK3589@tbergstrom-lnx.Nvidia.com>
References: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org>
 <1343213162-8064-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:1835 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab2ICNXf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Sep 2012 09:23:35 -0400
Content-Disposition: inline
In-Reply-To: <1343213162-8064-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On Wed, Jul 25, 2012 at 12:46:02PM +0200, Daniel Lezcano wrote:
> The tegra3 and big.LITTLE architecture have different cpu latencies.
> This API allows to specify a different cpu latency for a specific cpu.
> 
> With the previous patches, we use the per cpuidle device states pointer,
> this function overrides this pointer.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle.c |   17 +++++++++++++++++
>  include/linux/cpuidle.h   |   10 +++++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 199878a..3b21b68 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -456,6 +456,23 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
>  
>  EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
>  
> +int cpuidle_register_states(struct cpuidle_device *dev,
> +			    struct cpuidle_state *states,
> +			    int state_count)
> +{
> +	if (!dev || !states)
> +		return -EINVAL;
> +
> +	if (state_count <= 0)
> +		return -EINVAL;
> +
> +	dev->states = states;
> +	dev->state_count = state_count;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cpuidle_register_state);
> +
>  #ifdef CONFIG_SMP
>  

Looks good... apart from the fact that the function definition says
cpuidle_register_stateS and the exported symbol is cpuidle_register_state...

Cheers,

Peter.
