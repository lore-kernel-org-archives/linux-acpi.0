From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: boot hanging
Date: 11 Mar 2004 02:05:19 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078988718.2557.91.camel@dhcppc4>
References: <1078970905.4761.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1078970905.4761.6.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Wesley T Allen <wezlo-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

pci=noacpi helps?

if so, it is an ACPI interrupt configuration bug (which you're
encouraged to file on bugzilla.kernel.org;-)

thanks,
-Len

On Wed, 2004-03-10 at 21:08, Wesley T Allen wrote:
> Hi,
> 	Sorry if this is the wrong place to ask this question; if I'm off-base
> could someone point me in the right direction?
> 
> 	I have an hp pavilion laptop (an n5000 series, build-to-order) and have
> had problems with acpi under linux.  in the 2.4.x series the system
> would hang with an error "keventd not started" every now and again.  I
> would let it sit for a couple of seconds (making sure the hd had spun
> down), and then I'd reboot.  Sometimes I would have to do this a couple
> of times, but it was no big deal.
> 	I compiled 2.6.0 on my own when it came out (because the acpi support
> was better), and I could NEVER get it to boot.  So I gave up for a
> while, until I got Mandrake 10.0 community installed on my laptop.  The
> kernel is 2.6.3 and I just can't get the thing to boot with acpi enabled
> at all (well, once in about 50 attempts I think).  This is a bit of a
> bummer, considering that I can't get usb devices to work with my laptop
> w/o acpi enabled!  Does anyone have a workaround?  And what other
> information would be helpful in troubleshooting?
> 
> Thanks gang,  one of the things I love about OSS is that the developers
> are people you can talk to, and I end up learning how to help the
> development process AND other users.
> 
> Wes
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
