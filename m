From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI PCI routing problem
Date: Fri, 11 Jul 2003 14:51:26 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030711125126.GA22636@poupinou.org>
References: <200307110022.29512.adq_dvb@lidskialf.net> <20030711101441.GO7796@poupinou.org> <200307111243.34695.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200307111243.34695.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
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

On Fri, Jul 11, 2003 at 12:43:34PM +0100, Andrew de Quincey wrote:
> On Friday 11 July 2003 11:14, Ducrot Bruno wrote:
> > On Fri, Jul 11, 2003 at 12:22:29AM +0100, Andrew de Quincey wrote:
> > > Hi, I have an Epox 8RDA+ NForce2-based motherboard (uniprocessor, Athlon
> > > XP). This board has an IO-APIC with 0x17 pins. I can't tell you much more
> > > specific about it, as it is in the nforce2 chipset to which I do not have
> > > docs. I'm using kernel 2.5.74, with APIC, IO-APIC, ACPI turned on.
> > >
> > > First of all, here are the symptoms:
> > >
> > > Kernel boots OK, devices with IRQs <=15 are fine. However, the system
> > > attempts to allocate some devices (e.g. USB) to IRQs 20 and 21, as told
> > > by the AML code in my BIOS (more on this later).
> >
> > How look /proc/interrupts with IO-APIC, but without ACPI (I mean, no
> > acpi at all at compile time)?
> 
> Hi, here you go. ACPI disabled, but APIC/IO-APIC left in. Interesting, 
> everything is set to XT-PIC.... 
> 
> During boot it says: Found and enabled local APIC!
> But does not have any mention of the IO-APIC.
> 
>            CPU0
>   0:      50946          XT-PIC  timer
>   1:         16          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>  11:         13          XT-PIC  ohci-hcd
>  12:        346          XT-PIC  ohci-hcd
>  14:       1024          XT-PIC  ide0
>  15:         18          XT-PIC  ide1
> NMI:          0
> LOC:      50874
> ERR:         91
> MIS:          0
> 
> 

Then perhaps you may turn off IO-APIC.  I know there are troubles
with some SiS based system.  Though, it may be problematic with
NForce2 as well?

A Guru of that kind of stuff should help more than me (Alan perhaps?).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
