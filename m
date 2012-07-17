From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/5] acpi : remove time from acpi_processor_cx structure
Date: Tue, 17 Jul 2012 22:35:24 +0200
Message-ID: <201207172235.24469.rjw@sisk.pl>
References: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org> <1342127026-1526-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:44991 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756628Ab2GQU3q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jul 2012 16:29:46 -0400
In-Reply-To: <1342127026-1526-5-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, July 12, 2012, Daniel Lezcano wrote:
> Remove the time field as it is not used.
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
> index 99ba58f..bc1ce58 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -861,7 +861,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
>  		current_thread_info()->status |= TS_POLLING;
>  
>  	lapic_timer_state_broadcast(pr, cx, 0);
> -	cx->time += idle_time;
>  	return index;
>  }
>  
> @@ -979,7 +978,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
>  		current_thread_info()->status |= TS_POLLING;
>  
>  	lapic_timer_state_broadcast(pr, cx, 0);
> -	cx->time += idle_time;
>  	return index;
>  }
>  
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 87bb9d7..3998334 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -58,7 +58,6 @@ struct acpi_processor_cx {
>  	u32 address;
>  	u8 entry_method;
>  	u32 latency;
> -	u64 time;
>  	u8 bm_sts_skip;
>  	char desc[ACPI_CX_DESC_LEN];
>  };
> 

