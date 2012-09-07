From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/6] acpi : remove pointless cpuidle device state_count init
Date: Fri, 7 Sep 2012 23:50:50 +0200
Message-ID: <201209072350.50389.rjw@sisk.pl>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org> <1347013172-12465-4-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42937 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab2IGVob (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Sep 2012 17:44:31 -0400
In-Reply-To: <1347013172-12465-4-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

On Friday, September 07, 2012, Daniel Lezcano wrote:
> The cpuidle core takes care of filling this field from drv->state_count.

I'm not quite sure this is always valid.  If dev has already been
initialized and dev->state_count is different from 0,
cpuidle_enable_device() doesn't actually change it.

Have you considered all of the possible scenarios?

Rafael


> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/acpi/processor_idle.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 084b1d2..fc4757e 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1035,8 +1035,6 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr)
>  			break;
>  	}
>  
> -	dev->state_count = count;
> -
>  	if (!count)
>  		return -EINVAL;
>  
> 

