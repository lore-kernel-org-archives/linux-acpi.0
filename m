From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: Can't Find PCI: primary perr bus 01 with ACPI on
Date: Fri, 6 Sep 2002 14:42:45 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0209061442370.1021-100000@cherise.pdx.osdl.net>
References: <1031335333.1891.14.camel@jtsdell>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1031335333.1891.14.camel-gH4hS+xkl8U@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: John M Trostel <john.trostel-+vhbC7un7QRBDgjK7y7TUQ@public.gmane.org>
Cc: ACPI-list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


On Fri, 6 Sep 2002, John M Trostel wrote:

> I'm stymied (again).  Perhaps it is the crappy ACPI that's in my BIOS. 
> If I turn off acpi (acpi=off on boot prompt), then my PCI bus 01 is
> detected (and consequently my promise chips, and my hard drives).
> 
> ... I get:
> 	PCI: Discovered primary perr bus 01 [IRQ]
> 
>    in the boot messages
> 
> If I turn on acpi, then I never see the 'PCI: Discovered...' message
> shown above.
> 
> Is there someway to _force_ that bus to be detected (regardless of
> ACPI)? Is there somewhere in the DSDT I can poke around to make the bus
> reappear?

What kernel are you using?

	-pat



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
