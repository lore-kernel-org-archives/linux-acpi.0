From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] fix IRQ / GPEs restore on wake
Date: Tue, 20 Apr 2004 12:50:08 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05571648F@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: eric.valette-GANU6spQydw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Please explain the reasoning behind this change.

It looks as though you want to enable the runtime GPEs before executing
_SST, _BFS, and _WAK.  Is this correct?  Why?

Bob


> -----Original Message-----
> From: Eric Valette [mailto:eric.valette-GANU6spQydw@public.gmane.org]
> Sent: Sunday, April 18, 2004 5:30 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: Moore, Robert
> Subject: Re: [ACPI] [PATCH] fix IRQ / GPEs restore on wake
>=20
>=20
> --- a/drivers/acpi/hardware/hwsleep.c	2004-04-17 22:57:11.000000000
> +0200
> +++ b/drivers/acpi/hardware/hwsleep.c	2004-04-17 23:12:08.000000000
> +0200
> @@ -512,6 +512,16 @@ acpi_leave_sleep_state (
>=20
>   	acpi_gbl_sleep_type_a =3D ACPI_SLEEP_TYPE_INVALID;
>=20
> +	/*
> +	 * Restore the GPEs:
> +	 * 1) Disable all wakeup GPEs
> +	 * 2) Enable all runtime GPEs
> +	 */
> +	status =3D acpi_hw_restore_gpes_on_wake ();
> +	if (ACPI_FAILURE (status)) {
> +		ACPI_REPORT_ERROR(("Could not enable non wakeup GPEs,
%s\n",
> acpi_format_exception (status)));
> +	}
> +
>   	/* Setup parameter object */
>=20
>   	arg_list.count =3D 1;
> @@ -538,16 +548,6 @@ acpi_leave_sleep_state (
>   	}
>   	/* TBD: _WAK "sometimes" returns stuff - do we want to look at
it?
> */
>=20
> -	/*
> -	 * Restore the GPEs:
> -	 * 1) Disable all wakeup GPEs
> -	 * 2) Enable all runtime GPEs
> -	 */
> -	status =3D acpi_hw_restore_gpes_on_wake ();
> -	if (ACPI_FAILURE (status)) {
> -		return_ACPI_STATUS (status);
> -	}
> -
>   	/* Enable power button */
>=20
>=20
>
acpi_set_register(acpi_gbl_fixed_event_info[ACPI_EVENT_POWER_BUTTON].ena
bl
> e_register_id,
> --- a/drivers/acpi/sleep/main.c	2004-04-17 22:55:12.000000000
+0200
> +++ b/drivers/acpi/sleep/main.c	2004-04-17 23:09:45.000000000
+0200
> @@ -107,7 +107,6 @@ static int acpi_pm_enter(u32 state)
>   	default:
>   		return -EINVAL;
>   	}
> -	local_irq_restore(flags);
>   	printk(KERN_DEBUG "Back to C!\n");
>=20
>   	/* restore processor state
> @@ -118,6 +117,8 @@ static int acpi_pm_enter(u32 state)
>   	if (state > PM_SUSPEND_STANDBY)
>   		acpi_restore_state_mem();
>=20
> +	acpi_leave_sleep_state(state);
> +	local_irq_restore(flags);
>=20
>   	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
>   }
> @@ -133,8 +134,6 @@ static int acpi_pm_enter(u32 state)
>=20
>   static int acpi_pm_finish(u32 state)
>   {
> -	acpi_leave_sleep_state(state);
> -
>   	/* reset firmware waking vector */
>   	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
>=20



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
