From: <jtrostel-mn4gwa5WIIQysxA8WJXlww@public.gmane.org>
Subject: Re: Re: Can't Find PCI: primary perr bus 01 with ACPI on
Date: Fri, 6 Sep 2002 20:26:14 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E17nTRe-0002pN-00@hall.mail.mindspring.net>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: mochel-3NddpPZAyC0@public.gmane.org
Cc: John M Trostel <john.trostel-+vhbC7un7QRBDgjK7y7TUQ@public.gmane.org>, ACPI-list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I'm using 2.4.19... with patches from Sergio Basto at http://codecs.home.sapo.pt/acpi/

> 
> 
> On Fri, 6 Sep 2002, John M Trostel wrote:
> 
> > I'm stymied (again).  Perhaps it is the crappy ACPI that's in my BIOS. 
> > If I turn off acpi (acpi=off on boot prompt), then my PCI bus 01 is
> > detected (and consequently my promise chips, and my hard drives).
> > 
> > ... I get:
> > 	PCI: Discovered primary perr bus 01 [IRQ]
> > 
> >    in the boot messages
> > 
> > If I turn on acpi, then I never see the 'PCI: Discovered...' message
> > shown above.
> > 
> > Is there someway to _force_ that bus to be detected (regardless of
> > ACPI)? Is there somewhere in the DSDT I can poke around to make the bus
> > reappear?
> 
> What kernel are you using?
> 
> 	-pat


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
