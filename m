From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Several problems on a toshiba S3000-X11
Date: Fri, 27 Sep 2002 17:45:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020927154542.GH7904@poup.poupinou.org>
References: <20020927142320.GB2821@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020927142320.GB2821-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?=C9ric?= Brunet <ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mcelrath-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 27, 2002 at 04:23:20PM +0200, Éric Brunet wrote:
> Hi !
> 
> I am using acpi-20020829 with a 2.4.20pre5 kernel on a toshiba satellite
> 3000-X11, with the custom DSDT made by Bruno Ducrot. The previous acpi
> patch I used was acpi-20020503 (I think) with the native DSDT.
> I also use the toshiba_3000 module by Bruno.
> 
> I have one big problem: my computer shuts down without warning. I have
> also some minor problems, and I will begin with those.
> 
> 	MINOR PROBLEMS
> 	==============
> 
> When I read the battery state for the first couple of times, the
> /proc/acpi files claim that I have two batteries present, and that both
> batteries have a charge of 2040 mAh (capacity is 4000 mAh). After a
> couple of readings, I have the truth (only one battery and whatever
> capacity I have left.) That's annoying, and it didn't happen with my
> previous kernel. I don't now if it comes from the patched DSDT or from
> the new version of the acpi patch.

This is a trouble with the original AML, and I have not corrected it.

> 
> When ACPI assigns interrupts at boot, I get
> 	ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
> 	ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
> 	ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12 14 15)
> 	ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12 14 15)
> Now I am __nearly__ sure that there was a version of the ACPI patch where
> the interrupts were more evenly distributed. Did I dream that or was a
> patch reverted ?
> 
> In order to have S1 working, I have to apply this patch (originally by
> Bruno Ducrot)
> ----------------------------------------------------------------------------
> --- drivers/acpi/hardware/hwsleep.c.orig        Sun Sep  1 16:54:05 2002
> +++ drivers/acpi/hardware/hwsleep.c     Sun Sep  1 18:24:33 2002
> @@ -269,6 +269,9 @@
> 
>         ACPI_FLUSH_CPU_CACHE ();
> 
> +       /* Disable BM arbitration */
> +       acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1, ACPI_MTX_DO_NOT_LOCK);
> +
>         status = acpi_hw_register_write (ACPI_MTX_LOCK, ACPI_REGISTER_PM1A_CONTROL, PM1Acontrol);
>         if (ACPI_FAILURE (status)) {
>                 return_ACPI_STATUS (status);
> @@ -309,6 +312,9 @@
> 
>         } while (!in_value);
> 
> +       /* Restore BM arbitration */
> +       acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_DO_NOT_LOCK);
> +
>         return_ACPI_STATUS (AE_OK);
>  }

Only the restore should be made.  Actually, the
acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_DO_NOT_LOCK);
in acpi_leave_sleep_state() didn't work for me too.  Andy, could we
place acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_DO_NOT_LOCK);
in acpi_enter_sleep_state() instead?

> 
> 		MAJOR PROBLEM
> 		=============
> So the computer shuts down, without warning, while it is not particulary
> hot, with nothing written in the logs, while the user was just using vim
> in a xterm, at irregular times, and it can happen two or three times in
> an afternoon.
> 

Yes, I have this trouble with some version of ACPI now.  I think that I need
to incorporate now more smoothly with ACPI (that is, I need to use
the function acpi_ec_read() etc. instead of providing them in the module,
and so I avoid some possible races..)

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
