From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [ACPI] S4bios support for 2.5.63
Date: Thu, 27 Feb 2003 15:13:22 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030227141322.GV13404@poup.poupinou.org>
References: <20030226211347.GA14903@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030226211347.GA14903-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 26, 2003 at 10:13:47PM +0100, Pavel Machek wrote:
> Hi!
> 
> This is S4bios support for 2.5.63. I'd like to see it in since it is
> easier to understand and more foolproof. Please apply,
> 
> 							Pavel
> +/******************************************************************************
> + *
> + * FUNCTION:    acpi_enter_sleep_state_s4bios
> + *
> + * PARAMETERS:  None
> + *
> + * RETURN:      Status
> + *
> + * DESCRIPTION: Perform a s4 bios request.
> + *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
> + *
> + ******************************************************************************/
> +
> +acpi_status
> +acpi_enter_sleep_state_s4bios (
> +	void)
> +{
> +	u32                     in_value;
> +	acpi_status             status;
> +
> +
> +	ACPI_FUNCTION_TRACE ("Acpi_enter_sleep_state_s4bios");
> +
> +	acpi_set_register (ACPI_BITREG_WAKE_STATUS, 1, ACPI_MTX_LOCK);
> +	acpi_hw_clear_acpi_status();
> +
> +	acpi_hw_disable_non_wakeup_gpes();
> +
> +	ACPI_FLUSH_CPU_CACHE();
> +
> +	status = acpi_os_write_port (acpi_gbl_FADT->smi_cmd, (acpi_integer) acpi_gbl_FADT->S4bios_req, 8);
> +
> +	do {
> +		acpi_os_stall(1000);
> +		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_LOCK);

Please use ACPI_MTX_DO_NOT_LOCK flags.

1- all others user land are no more scheduled, and irqs are disabled.
2- the saved memory image is the one that appar 'randomly' when the suspension
   happen, it is then possible that that we enter acpi_get_register()
3- acpi_get_register() touch one semaphore (a mutex) if you pass ACPI_MTX_LOCK,
   then it is possible that this mutex is not released:
   we are supposed to go to 'ret_point' in arch/i386/kernel/acpi/wakeup.S

4- after resuming, any try to acquire this mutex will deadlock (this will happen early
   in acpi_leave_sleep_state()).

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
