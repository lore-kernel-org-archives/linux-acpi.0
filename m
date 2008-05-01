From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI: re-name acpi_pm_ops to acpi_suspend_ops
Date: Thu, 1 May 2008 18:14:36 +0200
Message-ID: <20080501161436.GF26085@elf.ucw.cz>
References: <200804291020.33068.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54734 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbYEAQOQ (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 1 May 2008 12:14:16 -0400
Content-Disposition: inline
In-Reply-To: <200804291020.33068.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-acpi@vger.kernel.org

Hi!

> Pavel, Rafael,
> I re-named the acpi_pm_* ops to be acpi_suspend_* below.
> 
> I think also that main.c isn't the best name for this file,
> how about acpi_platform_suspend.c, or maybe just acpi_suspend.c?

sleep/main.c sounds quite sensible, but I guess acpi_suspend.c would
be okay, too.

> commit 2c6e33c366bff2f839df60d9235ff09143e28dd9
> Author: Len Brown <len.brown@intel.com>
> Date:   Wed Apr 23 18:02:52 2008 -0400
> 
>     ACPI: re-name acpi_pm_ops to acpi_suspend_ops
>     
>     ... as they are platform_suspend_ops after all.
>     
>     cosmetic re-name only, no functional change.
>     
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
> index 71183ee..c3b0cd8 100644
> --- a/drivers/acpi/sleep/main.c
> +++ b/drivers/acpi/sleep/main.c
> @@ -51,7 +51,7 @@ static int acpi_sleep_prepare(u32 acpi_state)
>  }
>  
>  #ifdef CONFIG_SUSPEND
> -static struct platform_suspend_ops acpi_pm_ops;
> +static struct platform_suspend_ops acpi_suspend_ops;
>  

ACK.

>  extern void do_suspend_lowlevel(void);
>  
> @@ -65,11 +65,11 @@ static u32 acpi_suspend_states[] = {
>  static int init_8259A_after_S1;
>  
>  /**
> - *	acpi_pm_begin - Set the target system sleep state to the state
> + *	acpi_suspend_begin - Set the target system sleep state to the state
>   *		associated with given @pm_state, if supported.
>   */
>  
> -static int acpi_pm_begin(suspend_state_t pm_state)
> +static int acpi_suspend_begin(suspend_state_t pm_state)

And yes, this means it is very good idea.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
