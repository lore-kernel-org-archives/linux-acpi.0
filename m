From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH] Handle disabled local apic better
Date: 24 Mar 2004 14:13:21 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080155600.18509.263.camel@dhcppc4>
References: <20040323213551.4789bbae.ak@suse.de>
	 <1080112373.18504.67.camel@dhcppc4>  <20040324052724.56e57709.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040324052724.56e57709.ak-l3A5Bk7waGM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


> BTW if that is all cleaned up I would suggest just to get rid of the CONFIGs
> and always use runtime defaults. This would make these parts more maintainable
> I think and is the right thing to do for distributions.

tempting.
I gues if nobody builds with !CONFIG_X86_LOCAL_APIC anyway, then
run-time check is the way to go.


> > Here we're disabling MPS with "nolapic" -- something that "maxcpus=0"
> > and "nosmp" never effectively did before...
> 
> MPS without local APIC is useless.

I agree, my point is that "nosmp" and "maxcpus=0" are broken in that
they didn't disable MPS this early.


> > >  /*
> > >   * This initializes the IO-APIC and APIC hardware if this is
> > > @@ -1009,12 +1010,14 @@
> > >  
> > >  static __init int setup_disableapic(char *str) 
> > >  { 
> > > +	enable_local_apic = -1;
> > >  	disable_apic = 1;
> > >  	return 0;
> > >  } 
> > >  
> > >  static __init int setup_nolapic(char *str) 
> > >  { 
> > > +	enable_local_apic = -1;
> > >  	disable_apic = 1;
> > >  	return 0;
> > >  } 
> > 
> > these routines should be deleted, since they duplicate the earlier
> > parse_cmdline_early().  the ambiguous "disable_lapic" should go also,
> > since "enable_local_apic" is on the scene, yes?
> 
> No, even when you parse in parse_cmdline_early() you need a __setup,
> otherwise the normal __setup parser will complain about unknown 
> options.

Huh?  So if I boot a kernel with an unknown parameter, say
"len=gone_fishing", where would I expect to see the complaint -- I don't
see it in my dmesg except where the entire commmand line is dumped out.

thanks,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
