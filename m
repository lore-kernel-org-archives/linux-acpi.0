From: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>
Subject: Re: Where do I send APIC victims?
Date: Wed, 3 Sep 2003 15:21:08 -0300 (BRT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0309031520380.6102-100000@logos.cnet>
References: <200309031710.49411.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200309031710.49411.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
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



On Wed, 3 Sep 2003, Andrew de Quincey wrote:

> 
> > >>I can't back that. At least on all my Serverworks boxes there are no
> > >>problems with ACPI. I got reports from VIA-bases SMP boards that they are
> > >>doing well, too. (all for 2.4.22)
> >
> > And I can say that my Soyo SY-KT600 Ultra (VIA KT600+8237) has ACPI
> > problems as well. pci=noacpi doesn't help but acpi=off does. It gives
> > lots of errors that the ACPI tables are buggy when booting claiming
> > my 8237 SATA controller has gotten IRQ -19 for instance.
> > Using acpi=off solves the problem. This is with or without the libata
> > VIA 8237 SATA driver. Without anything it recognizes the chip but
> > doesn't like using IRQ -19 and doesn't see any disks. With pci=noacpi
> > it sees the disks but bombs out when trying to get the partition table.
> > It gets IRQ -19 still there. acpi=off makes it all work.
> 
> The IRQ -19 thing is a bug in my nforce2 patch in 2.4.22. It didn't drop back 
> to using the PIC correctly. My latest acpi-picmode patch (posted to this list 
> a few days back) corrects this, among other things.

Can you please resend me the patch?

Have you got any feedback on it? 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
