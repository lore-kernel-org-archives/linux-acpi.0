From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: S5 Powerdown problem on TX150 servers
Date: Tue, 16 Sep 2003 11:30:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030916093032.GP11391@poupinou.org>
References: <200309160912.15060.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200309160912.15060.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 16, 2003 at 09:12:15AM +0100, Andrew de Quincey wrote:
> Hi, I have an issue with TX150 servers. Basically, they don't power down in 
> ACPI. I press the power button, and I can see the system shutting down, but, 
> although it clears the screen and kinda makes a clunking noise as if the HDDs 
> are being stopped, the fans stay running, and the power light stays on.
> 
> I want the system to enter S5 when I press the power button.
> 
> I added some debug to the hwsleep.c/acpi_enter_sleep_state() function. The 
> last thing it executes is:
> 
> status = acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK, 
> ACPI_REGISTER_PM1B_CONTROL, PM1Bcontrol);
> 
> <-- DOES NOT GET HERE on button press.
> 
>         if (ACPI_FAILURE (status)) {
>                 return_ACPI_STATUS (status);
>         }
> 
> Which kinda makes sense as this is the write of the PM1B value that completes 
> powerdown.

No.  The real stuff that will complete the powerdown is when you set SLP_EN.
Try to remove the write to the PM1b.  Anyway, we already clear ARB_DIS
early. 

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
