From: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Subject: Re: [rfc] generic testing ACPI module
Date: Fri, 12 Mar 2004 07:30:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079069435.5429.92.camel@t40>
References: <1079038411.18351.25.camel@t40>
	 <20040311211005.GM2148@parcelfarce.linux.theplanet.co.uk>
	 <1079041694.5429.58.camel@t40>  <20040311225032.GN28592@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040311225032.GN28592-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Bruno,

Yes, from programing point of view, it may be a little ugly, but it is
easy to use without an aditional program, and you see in that hierarchy
what methods you have on a specific hardware.
In the ioctl case, we need at least an aditional program to send the
ioctl's to the desired device/method, something like hdparm for sending
HD* ioctls, and that is not going to appear over night.
This could be in the future, but to get things started, and have people
testing various platforms, we need something easy to use, and available
a.s.a.p.
For instance, I was playing with your video acpi driver, and I wished I
could run some specific methods to test the brigthness and other
functions on my T40 laptop which does not implement them as per ACPI
2.0c.
I was unable to do that without reading/understanding video.c and
various other acpi stuff, and modifying the module, recompiling, and
only then I could test some methods if they work.
This takes time, and not everybody is willing nor able to make/modify an
acpi module just to test some acpi methods.

The main reason of proposing this, was to let people test easily various
platforms, and this was supposed to be enabled when compiled with debug
or a separate option in the kernel anyway.

Your suggestion is good, but it is for general/sane use of acpi, more
like for future support for userspace acpi drivers, which is good too.
If the burden/manpower to make it as you suggest is not very much
different than in my proposal, then yours is better.
If the difference is big, then IMHO we sould consider first the quickest
one.

Best regards,
Paul




On Fri, 2004-03-12 at 00:50, Bruno Ducrot wrote:
> > Yes, your remark is good.
> > I was thinking of that too, but I thought it is more difficult to
> > implement it than a single separate module which can be disabled if
> > neccessary(or buggy).
> > Now that you mentioned it, I preffer your approach, because is more
> > logical and streamlined than the dirty hack I proposed, and I came with
> > the following additions:
> > 
> > Each object/device should have his methods as files in
> > /sys/firmware/acpi/ hierarchy.
> > To access a method, we should first "echo <arg1> ... <argn> > METHOD" to
> > set the arguments for that method, and when we "cat" the method, it
> > actually executes the method with our arguments, and return the result.
> 
> Ugly.  Better I guess is to implement an ioctl in order to execute method.
> At least, that will give you atomic access to that method.
> 
> > Each event capable object/device should have 2 additional files:
> > "system" and "device", and echo-ing 0 or 1 in this files should
> > install/deinstall a handler for this device for system or device events.
> > 
> 
> No opinion (yet).
> 
> Cheers,



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
