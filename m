From: Adam Kessel <adam-/J5p37YCQWYytDrLOV7HaA@public.gmane.org>
Subject: Re: ACPI Poweroff fails on HP OmniBook 500
Date: Fri, 31 Oct 2003 12:27:33 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031031202732.GA676@joehill.bostoncoop.net>
References: <20031029020636.GF29465@bostoncoop.net> <20031031110905.GA21970@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031031110905.GA21970-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 31, 2003 at 12:09:05PM +0100, Ducrot Bruno wrote:
> > I am using force=acpi as required since I have an older BIOS.  Apparently
> You mean acpi=force, correct?

Yes, typo.

> Could you please test this patch?
> The problem being that we power down some devices twice.

Yes, this patch fixes the problem 100%.  Thanks.

> --- linux-2.4.23-pre9/drivers/acpi/system.c	2003/10/31 08:09:10	1.1
> +++ linux-2.4.23-pre9/drivers/acpi/system.c	2003/10/31 10:36:35
> @@ -31,6 +31,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/poll.h>
>  #include <linux/delay.h>
> +#include <linux/interrupt.h>
>  #include <linux/sysrq.h>
>  #include <linux/compatmac.h>
>  #include <linux/proc_fs.h>
> @@ -92,7 +93,13 @@
>  static void
>  acpi_power_off (void)
>  {
> -	acpi_suspend(ACPI_STATE_S5);
> +	if (unlikely(in_interrupt())) 
> +		BUG();
> +	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
> +	ACPI_DISABLE_IRQS();
> +	acpi_enter_sleep_state(ACPI_STATE_S5);
> +
> +	printk(KERN_EMERG "ACPI: can not power off machine\n");
>  }
>  
>  #endif /*CONFIG_PM*/
-- 
Adam Kessel
http://bostoncoop.net/adam


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
