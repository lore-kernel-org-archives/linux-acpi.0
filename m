From: Alexander Malysh <a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] fix IRQ / GPEs restore on wake
Date: Tue, 20 Apr 2004 22:40:08 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404202240.14840.a.malysh@centrium.de>
References: <37F890616C995246BE76B3E6B2DBE05571648F@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_uqYhAGjOXGnaBMl";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE05571648F-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, eric.valette-GANU6spQydw@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-02=_uqYhAGjOXGnaBMl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Robert,

On Tuesday 20 April 2004 21:50, Moore, Robert wrote:
> Please explain the reasoning behind this change.
>
> It looks as though you want to enable the runtime GPEs before executing
> _SST, _BFS, and _WAK.  Is this correct?  Why?

because at least on my laptop after executing of _WAK irq's are enabled, so=
=20
stored gpe bits (before suspend) will be overwriten and not restored=20
correctly while resume...

>
> Bob
>
> > -----Original Message-----
> > From: Eric Valette [mailto:eric.valette-GANU6spQydw@public.gmane.org]
> > Sent: Sunday, April 18, 2004 5:30 AM
> > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Cc: Moore, Robert
> > Subject: Re: [ACPI] [PATCH] fix IRQ / GPEs restore on wake
> >
> >
> > --- a/drivers/acpi/hardware/hwsleep.c	2004-04-17 22:57:11.000000000
> > +0200
> > +++ b/drivers/acpi/hardware/hwsleep.c	2004-04-17 23:12:08.000000000
> > +0200
> > @@ -512,6 +512,16 @@ acpi_leave_sleep_state (
> >
> >   	acpi_gbl_sleep_type_a =3D ACPI_SLEEP_TYPE_INVALID;
> >
> > +	/*
> > +	 * Restore the GPEs:
> > +	 * 1) Disable all wakeup GPEs
> > +	 * 2) Enable all runtime GPEs
> > +	 */
> > +	status =3D acpi_hw_restore_gpes_on_wake ();
> > +	if (ACPI_FAILURE (status)) {
> > +		ACPI_REPORT_ERROR(("Could not enable non wakeup GPEs,
>
> %s\n",
>
> > acpi_format_exception (status)));
> > +	}
> > +
> >   	/* Setup parameter object */
> >
> >   	arg_list.count =3D 1;
> > @@ -538,16 +548,6 @@ acpi_leave_sleep_state (
> >   	}
> >   	/* TBD: _WAK "sometimes" returns stuff - do we want to look at
>
> it?
>
> > */
> >
> > -	/*
> > -	 * Restore the GPEs:
> > -	 * 1) Disable all wakeup GPEs
> > -	 * 2) Enable all runtime GPEs
> > -	 */
> > -	status =3D acpi_hw_restore_gpes_on_wake ();
> > -	if (ACPI_FAILURE (status)) {
> > -		return_ACPI_STATUS (status);
> > -	}
> > -
> >   	/* Enable power button */
>
> acpi_set_register(acpi_gbl_fixed_event_info[ACPI_EVENT_POWER_BUTTON].ena
> bl
>
> > e_register_id,
> > --- a/drivers/acpi/sleep/main.c	2004-04-17 22:55:12.000000000
>
> +0200
>
> > +++ b/drivers/acpi/sleep/main.c	2004-04-17 23:09:45.000000000
>
> +0200
>
> > @@ -107,7 +107,6 @@ static int acpi_pm_enter(u32 state)
> >   	default:
> >   		return -EINVAL;
> >   	}
> > -	local_irq_restore(flags);
> >   	printk(KERN_DEBUG "Back to C!\n");
> >
> >   	/* restore processor state
> > @@ -118,6 +117,8 @@ static int acpi_pm_enter(u32 state)
> >   	if (state > PM_SUSPEND_STANDBY)
> >   		acpi_restore_state_mem();
> >
> > +	acpi_leave_sleep_state(state);
> > +	local_irq_restore(flags);
> >
> >   	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
> >   }
> > @@ -133,8 +134,6 @@ static int acpi_pm_enter(u32 state)
> >
> >   static int acpi_pm_finish(u32 state)
> >   {
> > -	acpi_leave_sleep_state(state);
> > -
> >   	/* reset firmware waking vector */
> >   	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3DClick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

=2D-=20
Best regards / Mit besten Gr=FC=DFen aus D=FCsseldorf

Dipl.-Ing.
Alexander Malysh
___________________________________________

Centrium GmbH
Vogelsanger Weg 80
40470 D=FCsseldorf

=46on: +49 (0211) 74 84 51 80
=46ax: +49 (0211) 277 49 109

email: a.malysh (at) centrium.de
web: www.centrium.de
msn: a.malysh (at) centrium.de
icq: 98063111
___________________________________________

Please avoid sending me Word, Excel or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

--Boundary-02=_uqYhAGjOXGnaBMl
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAhYqunX3e5W+uJ0ERAu0gAJ9v/uGHQQmojRAqc1/Wn6whOLLmNgCdEPdE
GNOkS3t7ubeXviwWbkXBYxI=
=QV95
-----END PGP SIGNATURE-----

--Boundary-02=_uqYhAGjOXGnaBMl--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
