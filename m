From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: [PATCH] 2.6.0-test4 Fix mpparse properly
Date: Mon, 8 Sep 2003 11:02:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309081102.46779.adq_dvb@lidskialf.net>
References: <200309072130.40200.adq_dvb@lidskialf.net> <20030908042548.3bbfcf7d.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030908042548.3bbfcf7d.ak-l3A5Bk7waGM@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 08 Sep 2003 3:25 am, Andi Kleen wrote:
> On Sun, 7 Sep 2003 21:30:40 +0100
>
> Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org> wrote:
> > --- linux-2.6.0-test4.null_crs/arch/i386/kernel/mpparse.c	2003-09-06
> > 00:23:10.000000000 +0100 +++
> > linux-2.6.0-test4.es7000fix/arch/i386/kernel/mpparse.c	2003-09-07
> > 15:53:41.369717552 +0100 @@ -1129,8 +1129,10 @@
> >  			continue;
> >  		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
> >
> > +#ifdef CONFIG_X86_ES7000
> >  		if (!ioapic && (irq < 16))
> >  			irq += 16;
> > +#endif
>
> That won't work for an "generic" subarch kernel that supports the ES7000
> and other boxes too. You should test es7000_plat instead (that's currently
> a static in the es7000 code, needs to be unstatic'ed).

Hmm, yeah, thats a good point. However, I don't think checking for es7000_plat 
will work. The file defining it is only included if es7000 is targetted as a 
platform directly.  Theres no code which checks for an es7000 platform by 
looking at the hardware or anything; it just sets the variable if the es7000 
architecture is targetted... 

Any ideas?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
