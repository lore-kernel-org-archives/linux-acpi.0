From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 3/5][RFC] cpuidle : add a pointer for cpuidle_state in
 the cpuidle_device
Date: Mon, 3 Sep 2012 18:16:39 +0300
Message-ID: <20120903151639.GL3589@tbergstrom-lnx.Nvidia.com>
References: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org>
 <1343213162-8064-4-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:8156 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab2ICPQq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Sep 2012 11:16:46 -0400
Content-Disposition: inline
In-Reply-To: <1343213162-8064-4-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On Wed, Jul 25, 2012 at 12:46:00PM +0200, Daniel Lezcano wrote:
> This patch adds a pointer to the cpuidle_state array in the cpuidle_device
> structure. When the cpuidle_device is initialized, the pointer is assigned
> from the driver's cpuidle states array.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle.c |    1 +
>  include/linux/cpuidle.h   |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index d6a533e..42b1a8a 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -305,6 +305,7 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
>  		return -EIO;
>  	if (!dev->state_count)
>  		dev->state_count = drv->state_count;
> +	dev->states = drv->states;

This should only be done when dev->state_count == 0 no?

Cheers,

Peter.
