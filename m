From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: 2.6.0-test9 regression: panic on Fn+F7 hotkey
Date: Tue, 28 Oct 2003 14:57:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031028135746.GZ28351@poupinou.org>
References: <571ACEFD467F7749BC50E0A98C17CDD8D5FDC1@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <571ACEFD467F7749BC50E0A98C17CDD8D5FDC1-4yWAQGcml64gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: =?iso-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 28, 2003 at 08:33:16PM +0800, Li, Shaohua wrote:
> 
> > -----Original Message-----
> > From: Ducrot Bruno [mailto:ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org]
> > Sent: 2003??10??28?? 18:04
> > To: Li, Shaohua
> > Cc: Sérgio Monteiro Basto; Karol Kozimor; acpi-devel
> > Subject: Re: [ACPI] 2.6.0-test9 regression: panic on Fn+F7 hotkey
> > 
> > On Tue, Oct 28, 2003 at 04:14:56PM +0800, Li, Shaohua wrote:
> > > Hi,
> > >
> > > I missed non-ECDT situation. Try this one.
> > >
> > 
> > Please don't apply.  This is not OK.  You missed the
> > point that an interrupt handler can not sleep.  Anyway,
> > from my point-of-view, ec.c is not buggy, but
> > events/exviface.c::acpi_remove_.*().
> > 
> > IMHO, we should have our own acpi workqueue, at first, and
> > then wait for completion when removing any events handlers.
> > Those, the correct fix should be in osl.c, and in events/evxface.c
> > calling this wait for completition implemented in osl.c.
> 
>    yes, I know it's a bad idea to execute GPE query in interrupt handler. I do such thing is because this situation is rare. The interrupts seldom occur before EC device is initialized. 
> 
>    But even though acpi has own workqueue, When replace ECDT with EC, we still have a wrong context. 

Yes, there is still a little window where unlikely this may happens (that why
I think that should go in osl.c, because anyway this is more generic than
the EC problem, and have to be done in OS fashion).

> 
>    I think a better solution is when replace ECDT with EC, we can change the context in the event queue. Or we can use indirectly accessed context. Like this:
> 
> --- ec.c	2003-10-09 03:24:07.000000000 +0800
> +++ ec.c.new	2003-10-28 20:17:05.643232728 +0800
> @@ -93,7 +93,7 @@
>  
>  /* External interfaces use first EC only, so remember */
>  static struct acpi_device *first_ec;
> -
> +static struct acpi_device *ec_context = NULL;
>  /* --------------------------------------------------------------------------
>                               Transaction Management
>     -------------------------------------------------------------------------- */
> @@ -386,7 +386,7 @@
>  	void			*data)
>  {
>  	acpi_status		status = AE_OK;
> -	struct acpi_ec		*ec = (struct acpi_ec *) data;
> +	struct acpi_ec		*ec = ec_context;
>  
>  	if (!ec)
>  		return;

...

What happens if you have more than one EC?  Toshiba Satellite 190x
series have 2 EC IIRC, and only one will have an interrupt handler.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
