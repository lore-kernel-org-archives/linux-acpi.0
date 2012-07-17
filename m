From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] acpi : remove latency_ticks from acpi_processor_cx structure
Date: Tue, 17 Jul 2012 22:32:59 +0200
Message-ID: <201207172232.59977.rjw@sisk.pl>
References: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:44973 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754813Ab2GQU1X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jul 2012 16:27:23 -0400
In-Reply-To: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, July 12, 2012, Daniel Lezcano wrote:
> Remove the latency_ticks field as it is not used.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied to the 'pm-cpuidle' branch of the linux-pm.git tree.

Thanks,
Rafael


> ---
>  drivers/acpi/processor_idle.c |    2 --
>  include/acpi/processor.h      |    1 -
>  2 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index f3decb3..da92c65 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -586,7 +586,6 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
>  	 */
>  	cx->valid = 1;
>  
> -	cx->latency_ticks = cx->latency;
>  	/*
>  	 * On older chipsets, BM_RLD needs to be set
>  	 * in order for Bus Master activity to wake the
> @@ -619,7 +618,6 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
>  			if (!cx->address)
>  				break;
>  			cx->valid = 1; 
> -			cx->latency_ticks = cx->latency; /* Normalize latency */
>  			break;
>  
>  		case ACPI_STATE_C3:
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 9d65047..a70cbcc 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -59,7 +59,6 @@ struct acpi_processor_cx {
>  	u8 entry_method;
>  	u8 index;
>  	u32 latency;
> -	u32 latency_ticks;
>  	u32 power;
>  	u32 usage;
>  	u64 time;
> 

