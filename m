From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: Instability without ACPI and quirks
Date: Sat, 12 Jul 2003 13:39:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307121339.39930.adq_dvb@lidskialf.net>
References: <200307110022.29512.adq_dvb@lidskialf.net> <20030711184648.GN22636@poupinou.org> <1057980324.1470.61.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1057980324.1470.61.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?q?S=E9rgio=20Monteiro=20Basto?= <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


> I am testing (in my laptop) the first two removing quirks
> quirk_via_acpi
> quirk_vt82c686_acpi
> this two applied are applied to 00:07.4 Apollo Super ACPI
> after 4 days, nothing happens (everything works fine).
> And now I am going for next two
> this are applied to 00:07.5 VT82C686 AC97 Audio Controller and 00:07.2
> USB Controller and is the same function in drivers/pci/quirks.c where
> you can read :
>  * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
>  * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
>  * when written, it makes an internal connection to the PIC.
>  * For these devices, this register is defined to be 4 bits wide.
>  * Normally this is fine.  However for IO-APIC motherboards, or
>  * non-x86 architectures (yes Via exists on PPC among other places),
>  * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
>  * interrupts delivered properly.
>  *
>  * TODO: When we have device-specific interrupt routers,
>  * quirk_via_irqpic will go away from quirks.

Now that IS interesting. The nvidia/nvidia2 chipset has parts of the hardware 
bought from VIA.. e.g. lspci shows that I have a:

00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia 
audio [Via VT82C686B] (rev a2)

But the manufacturer's ID is different (set to nvidia), so the quirks will not 
be applied. I will try the opposite of you: turning selected appropriate 
quirks on.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
