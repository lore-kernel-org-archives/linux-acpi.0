From: John M Trostel <jtrostel-mn4gwa5WIIQysxA8WJXlww@public.gmane.org>
Subject: Re: Re: Can't Find PCI: primary perr bus 01 with ACPI on
Date: Mon, 09 Sep 2002 12:58:37 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1031590718.1942.1.camel@jtsdell>
References: <Pine.LNX.4.44.0209071328300.1021-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <Pine.LNX.4.44.0209071328300.1021-100000-yZQdDDOm3n9ZQn2sFP3R7eTW4wlIGRCZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: ACPI-list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The phrase I am not seeing is:

"PCI: Discovered primary peer bus 01 [IRQ]"

That appears to be coming from pirq_peer_trick in pci_irq.c

None of which is ACPI, but it sure doesn't show up when ACPI is
enabled.  Any other clues?

On Sat, 2002-09-07 at 16:30, Patrick Mochel wrote:
> 
> On Fri, 6 Sep 2002 jtrostel-mn4gwa5WIIQysxA8WJXlww@public.gmane.org wrote:
> 
> > I'm using 2.4.19... with patches from Sergio Basto at http://codecs.home.sapo.pt/acpi/
> 
> For some reason, pci_fixup_peer_bridges() is not getting called. 
> 
> Since it's 2.4.x, I'm ignorant as to why and to what the code looks like,
> and I would like to remain in my state of bliss. So, I'm deferring it.  
> Sorry...
> 
> 
> 	-pat
-- 
John M. Trostel
Atlanta GA USA
jtrostel-mn4gwa5WIIQysxA8WJXlww@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
