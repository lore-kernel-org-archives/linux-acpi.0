From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: acpi_tolerant (Re: ACPI patch status (2.6))
Date: Tue, 30 Sep 2003 20:11:06 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030930181106.GE15853@wotan.suse.de>
References: <1064902694.2535.159.camel@dhcppc4> <20030930070706.GB8827@wotan.suse.de> <1064943934.2583.100.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1064943934.2583.100.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 30, 2003 at 01:45:34PM -0400, Brown, Len wrote:
> > > If you seen any regressions, please let me know.
> > 
> > My ACPI tolerant patch is not included. Without this it will not boot
> > on many HP servers and some other multiprocessor boxes.
> 
> Thanks Andi,
> I've included your "PIC fallback and SMP boxes" note below to give
> others background if they haven't seen it yet.
> 
> My  understanding was that the acpi_tolerant patch is in response to
> Andrew de Quincy's "Full dropback to PIC mode" patch -- the one that
> creates pic.c.  That change is in the mm tree, but not yet in 2.4, 2.6,
> or the acpi 2.4 or 2.6 trees.

Yep. But that tree needs acpi-tolerant too


> If I'm confused and you believe that the acpi_tolerant patch is needed
> for the current acpi tree to boot on some SMP servers, please straighten
> me out.

No, you're right. It only makes sense with PIC fallback. But PIC 
fallback is included in your test tree, right? If yes then you
should merge acpi-tolerant too.

BTW IMHO you should merge both (PIC mode and the other fixes including
acpi-tolerant) ASAP to mainline. There are tons of ACPI bug reports for 
2.6 all the time that would be fixed by them. It would be much better to
test there than in some test tree that nobody uses anyways. That would
also give the patches a much better test.

-Andi


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
