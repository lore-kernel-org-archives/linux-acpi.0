From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: Re: ACPI sleep: check error values and disable it on SMP
Date: Tue, 10 Jun 2003 14:33:53 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030610043633.4C3F02C05E@lists.samba.org>
References: <20030608203823.GA9415@elf.ucw.cz>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: Your message of "Sun, 08 Jun 2003 22:38:23 +0200."
             <20030608203823.GA9415-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

In message <20030608203823.GA9415-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org> you write:
> Hi!
> 
> Wakeup is hard to do on SMP, and freezer_processes is just not ready
> to work on SMP machine. As I have no SMP (hint hint ;-), it is better
> to disable it.
> 
> ACPI should really really check if freezing processes worked, and
> handle failure. Please apply,

Gcc doesn't give any warnings about unreachable code?

> --- linux-cvs.clean/drivers/acpi/sleep/main.c	2003-02-28 10:23:47.000000000 -0800
> +++ linux-cvs/drivers/acpi/sleep/main.c	2003-06-08 14:39:03.000000000 -0700
> @@ -214,6 +214,11 @@
>  {
>  	acpi_status status;
>  
> +#ifdef CONFIG_SMP
> +	/* Suspend is hard to get right on SMP. */
> +	return AE_ERROR;
> +#endif
> +
>  	/* get out if state is invalid */
>  	if (state < ACPI_STATE_S1 || state > ACPI_STATE_S5)
>  		return AE_ERROR;
> @@ -226,7 +231,10 @@
>  	 * TBD: S1 can be done without device_suspend.  Make a CONFIG_XX
>  	 * to handle however when S1 failed without device_suspend.
>  	 */
> -	freeze_processes();		/* device_suspend needs processes to be stopped */
> +	if (freeze_processes()) {
> +		thaw_processes();
> +		return AE_ERROR;		/* device_suspend needs processes to be stopped */
> +	}
>  
>  	/* do we have a wakeup address for S2 and S3? */
>  	/* Here, we support only S4BIOS, those we set the wakeup address */
> 

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
