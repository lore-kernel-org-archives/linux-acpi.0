From: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Subject: Re: [RFC] filling in ACPI files in sysfs
Date: Thu, 08 Apr 2004 08:56:20 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081403779.23178.49.camel@t40>
References: <1081373781.23176.30.camel@t40>
	 <1081376023.2748.15.camel@patsy.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1081376023.2748.15.camel-Wmjt7DDUnIVxnVILBQAtiA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Alex,

Boy, you are fast.
I compiled the second patch in kernel 2.6.5 and booted the laptop.
The first thing I've noticed is that now we have all devices in
/sys/firmware/acpi/... even if they are initialized or not (present or
not) which IMHO is good. So, your fix works.
I still don't have /proc/acpi/battery/BAT1 if I hot plug the second
battery after loading the kernel. I don't really know if is because of
your patch or this is how new kernel behave (I have to test it with
vanilla 2.6.5 later)

I will get back with more details after more testing/playing.

Thanks,
Paul

On Thu, 2004-04-08 at 01:13, Alex Williamson wrote:
> On Wed, 2004-04-07 at 15:36, Paul Ionescu wrote:
> > Hi Alex,
> > 
> > I patch-ed a 2.6.5 kernel, and boot-ed an IBM T30 Thinkpad Laptop.
> > It looks nice at first sight, and now I want _Qxx methods in /EC to play
> > with :)
> > 
> > What I found strange is the following behaviour:
> > If I boot with my second battery inserted, I have the corresponding
> > entries for BAT1 in /proc/acpi/battery and /sys/.../EC/BAT1
> > If I boot without my second battery inserted, and I insert it later on,
> > I don't have the corresponding BAT1 directory for it in /proc/acpi and
> > /sys/.../EC/.
> > And this is true for other acpi devices too.
> > I think that the problem is that it does not (yet) update the list of
> > active devices in real time, but uses the list with devices detected at
> > boot time.
> 
>    Yeah, we were only filling in devices that the _STA method claimed
> were present at boot.  I've fixed that now.
> 
> > Anyway, this is a good start, and I am waiting for more patches to test.
> 
>    Here you go, a second iteration.  I haven't looked at the _Qxx
> methods yet, but we're up to over 30 methods exported now.  I've added
> several writable methods so you can do more than query status.  I've
> been able to undock my omnibook 500 laptop (electromechanical eject) and
> switch between a CRT and LCD using only the sysfs interface.  I thought
> about parsing some of the more complicated data structures, but that
> turned into way too much code too quickly.  So you'll find there are
> several entries that return a binary dump of the data structures.  these
> include _CRS, _PRS, _PRT, and _MAT.  Some of the methods look like they
> should work, but I don't have a box w/ firmware that exports them, so
> let me know if the output is broken.  Thanks,
> 
> 	Alex



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
