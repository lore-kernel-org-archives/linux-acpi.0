From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Questions about DSDT
Date: Fri, 6 Feb 2004 23:53:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040206225347.GI13262@poupinou.org>
References: <20040206205500.GA16431@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040206205500.GA16431-sTXFmx6KbOnUXq0IF5SVAZ4oGUkBHcCu@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 06, 2004 at 09:55:00PM +0100, Luca wrote:
> Hi,
> I have some questions about DSDT:
> 
> 1) My notebook [1] has a broken DSDT:
> 
> ACPI: AC Adapter [AC] (on-line)
> ACPI: Battery Slot [BAT0] (battery present)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Sleep Button (CM) [SLPB]
> ACPI: Lid Switch [LID]
> ACPI: Fan [FAN0] (on)
> acpi_processor-1626 [38] acpi_processor_get_inf: Invalid PBLK length [5]
> ACPI: Processor [CPU0] (supports C1)
> ACPI: Thermal Zone [THRM] (56 C)
> Asus Laptop ACPI Extras version 0.26
>   L3D model detected, supported
> 

...

> ACPI: Subsystem revision 20040116
>    tbget-0291: *** Info: Table [DSDT] replaced by host OS
>  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
> [...]
> ACPI: AC Adapter [AC] (on-line)
> ACPI: Battery Slot [BAT0] (battery present)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Sleep Button (CM) [SLPB]
> ACPI: Lid Switch [LID]
> ACPI: Fan [FAN0] (on)
> ACPI: Processor [CPU0] (supports C1 C2)
> ACPI: Thermal Zone [THRM] (32 C)
> Asus Laptop ACPI Extras version 0.26
>   L3D model detected, supported

Even though the ACPI Spec do not allow a value other than 0 or 6, I
think than one may be relaxed somehow (as I remember, there where
trouble though with olds laptops).

> 2) In the DSDTs repository I see a custom DSDT for my laptop, but for an
> older version of  the BIOS (I does work though). The  only difference is
> that it adds Linux to the list  of know OS. What are the effects of this
> change?

Probably you can get the same kind of functionality via
acpi_os_name='Win...' option...

> 3) Should I upload original and hacked DSDT to acpi.sf.net?

Still don't know.  It's up to you to decide.  I think anyway
that it is better to upload diffs instead.

Anyway, perhaps the correct things to do is to have a kind of
sysctl for it so that there is no need to upload a DSDT just for
that.

> 4) How do I send the patch to ASUS? I just send an email to the support
> explaining the problem or...?

I don't know.  At least, say them that the ASL that was generated break:
ACPI 1.0b 15.2.3.3.15 Processor - Declare Processor

But then this indicate much more likely a bug in the AML assembler
that produced that code (the assembler produce byte-codes upon
*invalide* sources).

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
