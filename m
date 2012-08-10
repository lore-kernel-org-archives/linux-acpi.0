From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 5/5][RFC] cpuidle : add cpuidle_register_states function
Date: Fri, 10 Aug 2012 18:17:36 +0100
Message-ID: <20120810171736.GA12151@e102568-lin.cambridge.arm.com>
References: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org>
 <1343213162-8064-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59231 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab2HJRRl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Aug 2012 13:17:41 -0400
In-Reply-To: <1343213162-8064-6-git-send-email-daniel.lezcano@linaro.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

Hi Daniel,

thanks for this patchset.

On Wed, Jul 25, 2012 at 11:46:02AM +0100, Daniel Lezcano wrote:
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

Is this function supposed to be called after cpuidle_device registration ?
I think so since at registration time the dev->states pointers are all
initialized to point to the driver state array, which is global and not
really what we want.

Unless this function is called on the cpu that requires swapping the state
pointer, I think it is unsafe to register a different state pointer
without a minimal level of locking (or disabling idle and renabling idle)
since the update of dev->states and dev->state_count is not atomic.
Maybe it is implicit but it should be documented somehow to define
cpuidle_register_states(...) proper usage.

Thanks,
Lorenzo

