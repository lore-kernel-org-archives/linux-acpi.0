From: Marcel Meckel <acpi-X2Xph2rMQzhn68oJJulU0Q@public.gmane.org>
Subject: Re: All 2.4.22 patches after 09-16 broken?
Date: Thu, 20 Nov 2003 22:44:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031120224407.35fbcec2.acpi@thermoman.de>
References: <Pine.LNX.4.44.0311200838380.17057-100000@v8.miniserver.de>
	<20031120163200.GK30485@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031120163200.GK30485-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > Error in Tcl Script
> > Error: can't read "CONFIG_SCSI": no such variable
> > 
> > ERROR - Attempting to write value for unconfigured variable 
> > (CONFIG_PARPORT_PC_CML1).
> 
> Maybe the tk program is having trouble parsing this:
> 
> +  else if [ "$CONFIG_SMP" = "y" ]; then
> 
> Can you try changing that line in drivers/acpi/Config.in by putting a
> new line between the `else' and the `if'?  ie make it look like:
>   else
>     if [ "$CONFIG_SMP" = "y" ]; then

Thanks, that's it! Please correct the patches after 09-16 or
release a new one :)

Greetings from germany,
Marcel.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
