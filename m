From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: S5 Powerdown problem on TX150 servers
Date: Tue, 16 Sep 2003 12:09:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309161209.35760.adq_dvb@lidskialf.net>
References: <200309160912.15060.adq_dvb@lidskialf.net> <20030916093032.GP11391@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030916093032.GP11391-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
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

On Tuesday 16 September 2003 10:30, Ducrot Bruno wrote:
> On Tue, Sep 16, 2003 at 09:12:15AM +0100, Andrew de Quincey wrote:
> > Hi, I have an issue with TX150 servers. Basically, they don't power down
> > in ACPI. I press the power button, and I can see the system shutting
> > down, but, although it clears the screen and kinda makes a clunking noise
> > as if the HDDs are being stopped, the fans stay running, and the power
> > light stays on.
> >
> > I want the system to enter S5 when I press the power button.
> >
> > I added some debug to the hwsleep.c/acpi_enter_sleep_state() function.
> > The last thing it executes is:
> >
> > status = acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK,
> > ACPI_REGISTER_PM1B_CONTROL, PM1Bcontrol);
> >
> > <-- DOES NOT GET HERE on button press.
> >
> >         if (ACPI_FAILURE (status)) {
> >                 return_ACPI_STATUS (status);
> >         }
> >
> > Which kinda makes sense as this is the write of the PM1B value that
> > completes powerdown.
>
> No.  The real stuff that will complete the powerdown is when you set
> SLP_EN. Try to remove the write to the PM1b.  Anyway, we already clear
> ARB_DIS early.

Ah, I realise I did not include enough context, sorry.

This _is_ in the code which sets SLP_EN:

        /* Insert SLP_ENABLE bit */

        PM1Acontrol |= sleep_enable_reg_info->access_bit_mask;
        PM1Bcontrol |= sleep_enable_reg_info->access_bit_mask;

        /* Write #2: SLP_TYP + SLP_EN */

        ACPI_FLUSH_CPU_CACHE ();

        status = acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK, 
ACPI_REGISTER_PM1A_CONTROL, PM1Acontrol);
        if (ACPI_FAILURE (status)) {
                return_ACPI_STATUS (status);
        }

        status = acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK, 
ACPI_REGISTER_PM1B_CONTROL, PM1Bcontrol);

<-- this is the point I highlighted before

        if (ACPI_FAILURE (status)) {
                ACPI_DEBUG_PRINT ((ACPI_DB_INIT, "X6failed\n"));
                return_ACPI_STATUS (status);
        }


In the light of this, is there anything you would like me to try?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
