From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Re: [PATCH] Handle disabled local apic better
Date: Wed, 24 Mar 2004 20:28:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040324192800.GD20849@wotan.suse.de>
References: <20040323213551.4789bbae.ak@suse.de> <1080112373.18504.67.camel@dhcppc4> <20040324052724.56e57709.ak@suse.de> <1080155600.18509.263.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1080155600.18509.263.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> > > Here we're disabling MPS with "nolapic" -- something that "maxcpus=0"
> > > and "nosmp" never effectively did before...
> > 
> > MPS without local APIC is useless.
> 
> I agree, my point is that "nosmp" and "maxcpus=0" are broken in that
> they didn't disable MPS this early.

Sure, it's broken. Also when the APIC initialization fails and probably
some other cases.

> > No, even when you parse in parse_cmdline_early() you need a __setup,
> > otherwise the normal __setup parser will complain about unknown 
> > options.
> 
> Huh?  So if I boot a kernel with an unknown parameter, say
> "len=gone_fishing", where would I expect to see the complaint -- I don't
> see it in my dmesg except where the entire commmand line is dumped out.

That will result in a environment variable len in init's environment with
value gone_fishing and is not unknown. But nolapic doesn't have a = 

-Andi



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
