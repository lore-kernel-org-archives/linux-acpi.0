From: David G Hamblen <dave-RfZrpLcwWZ/QT0dZR+AlfA@public.gmane.org>
Subject: Re: S3 wakeup code
Date: Fri, 25 Jul 2003 14:04:02 -0400 (EDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0307251356530.1520-100000@puppy.afrinc.com>
References: <20030725175625.GC1526@hell.org.pl>
Reply-To: dave-wr1Qx4d9ef7QT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030725175625.GC1526-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 25 Jul 2003, Karol Kozimor wrote:

> Thus wrote David G Hamblen:
> > standby properly; so I assume that the ACPI tables can be driven by the
> > OS.  Perhaps something along the lines of the asus_acpi code?
>
> The asus_acpi module uses the ASUS-specific DSDT methods to handle the
> backlight switching. I have quite the same problem with S1 on my machine,
> but I get around it by doing echo 0 > /proc/acpi/asus/lcd; echo 1 >
> /proc/acpi/sleep; echo 1 > /proc/acpi/asus/lcd. You may want to look for
> the relevant methods in your DSDT and write a kernel interface to call
> them, so that you could then activate it prior to suspending. I suppose
> that's exactly what the Windows drivers do. You may also try something
> video-specific, i.e. radeontool.
>
> BTW: Pavel: will there be a place in the new PM interface for functions
> that drivers could bind onto, i.e. something like a generic
> disable_backlight(), assigned to
> {asus,dell,toshiba,nvidia,radeon,etc.}_disable_backlight()? I think this
> could solve some important problems.

The /linux/drivers/skeletonfb.c file has some potential sample hooks for
this kind of thing.  Several of the drivers in that directory have code
drive the various power states.  When I get a chance, I might try hacking
the vesafb driver.  I don't know if I can get any hints out of the nv
driver for XF86.


Dave




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
