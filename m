From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] acpi : remove latency_ticks from acpi_processor_cx structure
Date: Thu, 12 Jul 2012 22:34:12 +0200
Message-ID: <201207122234.12851.rjw@sisk.pl>
References: <1342107003-9811-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:38197 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755270Ab2GLU2k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jul 2012 16:28:40 -0400
In-Reply-To: <1342107003-9811-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Thursday, July 12, 2012, Daniel Lezcano wrote:
> Remove the latency_ticks field as it is not used.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for the patches, but can you please repost them to
linux-pm@vger.kernel.org so that they are included into the kernel.org
Patchwork?  They will be much easier to review and handle then.

And please CC linux-acpi@vger.kernel.org for all ACPI-related patches in the
future.

Thanks,
Rafael


> ---
>  drivers/acpi/processor_idle.c |    2 --
>  include/acpi/processor.h      |    1 -
>  2 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index b894627..9ef007d 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -583,7 +583,6 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
>  	 */
>  	cx->valid = 1;
>  
> -	cx->latency_ticks = cx->latency;
>  	/*
>  	 * On older chipsets, BM_RLD needs to be set
>  	 * in order for Bus Master activity to wake the
> @@ -616,7 +615,6 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
>  			if (!cx->address)
>  				break;
>  			cx->valid = 1; 
> -			cx->latency_ticks = cx->latency; /* Normalize latency */
>  			break;
>  
>  		case ACPI_STATE_C3:
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index ac3bff6..19423c3 100644
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

