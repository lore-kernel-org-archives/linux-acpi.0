From: "Richard B. Johnson" <root-KUYkVxoy1ibZ8u7sGK6rWdBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: Tue, 30 Mar 2004 10:33:50 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0403301019570.6451@chaos>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
 <1080535754.16221.188.camel@dhcppc4> <20040329052238.GD1276@alpha.home.local>
 <1080598062.983.3.camel@dhcppc4> <1080651370.25228.1.camel@dhcp23.swansea.linux.org.uk>
 <Pine.LNX.4.53.0403300814350.5311@chaos> <20040330142215.GA21931@alpha.home.local>
 <Pine.LNX.4.53.0403300943520.6151@chaos> <20040330150949.GA22073@alpha.home.local>
Reply-To: root-KUYkVxoy1ibZ8u7sGK6rWdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040330150949.GA22073-HkMpAodKYdnXX8ko2wsARw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arkadiusz Miskiewicz <arekm-k0Z414SquRyhPH1hqNUYSQ@public.gmane.org>, Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 30 Mar 2004, Willy Tarreau wrote:

>
> > > OK, so why not compile the cmpxchg instruction even on i386 targets
> > > to let generic kernels stay compatible with everything, but disable
> > > ACPI at boot if the processor does not feature cmpxchg ? This could
> > > be helpful for boot/install kernels which try to support a wide
> > > range of platforms, and may need ACPI to correctly enable interrupts
> > > on others.
> > >
> > > Cheers,
> > > Willy
> > >
> >
> > Because it would get used (by the compiler) in other code as well!
> > As soon as the 386 sees it, you get an "invalid instruction trap"
> > and you are dead.
>
> That's not what I meant. I only meant to declare the cmpxchg() function.

It's not a function. It is actual op-codes. If you compile with
'486 or higher, the C compiler is free to spew out these op-codes
any time it thinks it's a viable instruction sequence. Since
it basically replaces two other op-codes, gcc might certainly use
if for optimization.

This is independent of the macro that is defined in a header to
use this sequence .


[SNIPPED...]


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
