From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] ACPI power-down in Linux 2.5.59
Date: Tue, 21 Jan 2003 18:42:08 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030121174207.GA4049@elf.ucw.cz>
References: <Pine.LNX.4.44.0301202353530.21175-200000@boris.prodako.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301202353530.21175-200000-CWfOIYxxj7kInT2dYjKYhA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tobias Ringstrom <tori-cF8t/dA0MSs0DrVG+m1MRYdd74u8MsAO@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I noticed that Linux 2.5.59 did not power-down when using ACPI. The reason 
> is that you need CONFIG_ACPI_SLEEP which needs CONFIG_SOFTWARE_SUSPEND.  
> Both are described as a bit dangerous in the config help.
> 
> As an experiment, I moved the power-down code from sleep.c to bus.c (which
> seemed like a top-level file) and it seems to work well.  I've attached
> the patch to this email.  Perhaps something like this can be considered
> for future updates?  What do you think?

Yes, this seems like good idea.
								Pavel

> /Tobias

> diff -ru linux-2.5.59.orig/drivers/acpi/bus.c linux-2.5.59/drivers/acpi/bus.c
> --- linux-2.5.59.orig/drivers/acpi/bus.c	2003-01-11 11:50:23.000000000 +0100
> +++ linux-2.5.59/drivers/acpi/bus.c	2003-01-19 17:42:01.000000000 +0100
> @@ -29,6 +29,7 @@
>  #include <linux/pm.h>
>  #include <linux/device.h>
>  #include <linux/proc_fs.h>
> +#include <linux/sysrq.h>
>  #ifdef CONFIG_X86
>  #include <asm/mpspec.h>
>  #endif
> @@ -676,11 +677,38 @@
>  	return_VALUE(-ENODEV);
>  }
>  
> +static void
> +acpi_power_off (void)
> +{
> +	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
> +	ACPI_DISABLE_IRQS();
> +	acpi_enter_sleep_state(ACPI_STATE_S5);
> +}
> +
> +#if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_PM)
> +
> +/* Simple wrapper calling power down function. */
> +static void acpi_sysrq_power_off(int key, struct pt_regs *pt_regs,
> +	struct tty_struct *tty)
> +{
> +	acpi_power_off();
> +}
> +
> +struct sysrq_key_op sysrq_acpi_poweroff_op = {
> +	.handler =	&acpi_sysrq_power_off,
> +	.help_msg =	"Off",
> +	.action_msg =	"Power Off\n"
> +};
> +
> +#endif  /* CONFIG_MAGIC_SYSRQ */
> +
>  decl_subsys(acpi,NULL);
>  
>  static int __init acpi_init (void)
>  {
>  	int			result = 0;
> +	acpi_status		status;
> +	u8			type_a, type_b;
>  
>  	ACPI_FUNCTION_TRACE("acpi_init");
>  
> @@ -712,6 +740,13 @@
>  	} else
>  		acpi_disabled = 1;
>  
> +	/* Install the soft-off (S5) handler. */
> +	status = acpi_get_sleep_type_data(ACPI_STATE_S5, &type_a, &type_b);
> +	if (ACPI_SUCCESS(status)) {
> +		pm_power_off = acpi_power_off;
> +		register_sysrq_key('o', &sysrq_acpi_poweroff_op);
> +	}
> +
>  	return_VALUE(result);
>  }
>  
> diff -ru linux-2.5.59.orig/drivers/acpi/sleep.c linux-2.5.59/drivers/acpi/sleep.c
> --- linux-2.5.59.orig/drivers/acpi/sleep.c	2003-01-06 23:26:51.000000000 +0100
> +++ linux-2.5.59/drivers/acpi/sleep.c	2003-01-19 17:41:14.000000000 +0100
> @@ -9,7 +9,6 @@
>   */
>  
>  #include <linux/proc_fs.h>
> -#include <linux/sysrq.h>
>  #include <linux/delay.h>
>  #include <linux/irq.h>
>  #include <linux/pm.h>
> @@ -53,14 +52,6 @@
>  	.release	= single_release,
>  };
>  
> -static void
> -acpi_power_off (void)
> -{
> -	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
> -	ACPI_DISABLE_IRQS();
> -	acpi_enter_sleep_state(ACPI_STATE_S5);
> -}
> -
>  /**
>   * acpi_system_restore_state - OS-specific restoration of state
>   * @state:	sleep state we're exiting
> @@ -625,24 +616,6 @@
>  	return_VALUE(result ? result : count);
>  }
>  
> -
> -#if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_PM)
> -
> -/* Simple wrapper calling power down function. */
> -static void acpi_sysrq_power_off(int key, struct pt_regs *pt_regs,
> -	struct tty_struct *tty)
> -{
> -	acpi_power_off();
> -}
> -
> -struct sysrq_key_op sysrq_acpi_poweroff_op = {
> -	.handler =	&acpi_sysrq_power_off,
> -	.help_msg =	"Off",
> -	.action_msg =	"Power Off\n"
> -};
> -
> -#endif  /* CONFIG_MAGIC_SYSRQ */
> -
>  static int __init acpi_sleep_init(void)
>  {
>  	struct proc_dir_entry	*entry = NULL;
> @@ -690,11 +663,7 @@
>  		entry->proc_fops->write = acpi_system_write_alarm;
>  	}
>  
> -	/* Install the soft-off (S5) handler. */
>  	if (sleep_states[ACPI_STATE_S5]) {
> -		pm_power_off = acpi_power_off;
> -		register_sysrq_key('o', &sysrq_acpi_poweroff_op);
> -
>  		/* workaround: some systems don't claim S4 support, but they
>                     do support S5 (power-down). That is all we need, so
>  		   indicate support. */


-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
