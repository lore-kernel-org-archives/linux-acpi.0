From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: Re: Possible quick fix for ACPI routing problem on Nforce2
Date: Sun, 13 Jul 2003 14:11:40 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307131411.40832.adq_dvb@lidskialf.net>
References: <Pine.LNX.4.33.0307131118210.561-100000@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0307131118210.561-100000-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 13 July 2003 10:19, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> Salut Andrew,
>
> On Sun, 13 Jul 2003, Andrew de Quincey wrote:
> > Anyway, IRQs > 15 get set to Active low/Level Sensitive in the IO-APIC on
> > my board.
> >
> > The fix (No patch as this is NOT a proper fix):
> > Edit arch/i386/kernel/io_apic.c
> > Find the function io_apic_set_pci_routing() (its the last one in 2.5.74).
> > Change the line:
> > entry.polarity = 1;         /* Low active */
> >
> > To:
> > entry.polarity = 0;         /* High active */
> >
> > For me, this makes everything work fine. Originally, I also forced these
> > IRQs to be edge sensitive, but leaving them at level seems to work fine
> > as well.
>
> Only ISA-IRQs are edge ones. As PCI has interrup-sharing, they need to be
> level ones. I am pretty sure, that your irq > 15 are not for ISA
> devices...

OK, makes sense.

Interesting. I see the polarity is hardcoded to active low (1) in the code, 
which is correct for PCI isn't it?

BUT: this just does not work in my system. The onboard nforce2 devices are 
generating active high IRQs, yet are mapped to IRQs 20,21,22 in ACPI. I've 
checked in Windows: it works, and those devices are mapped to IRQs 20,21,22 
as well.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
