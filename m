From: David G Hamblen <dave-RfZrpLcwWZ/QT0dZR+AlfA@public.gmane.org>
Subject: Re: S3 wakeup code
Date: Fri, 25 Jul 2003 08:14:50 -0400 (EDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0307250755460.2827-100000@puppy.afrinc.com>
References: <20030723162423.GD9013@atrey.karlin.mff.cuni.cz>
Reply-To: dave-wr1Qx4d9ef7QT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030723162423.GD9013-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

My problem is the backlight on a Dell Inspiron 8100 with the nVidia VGA
controller. Everything seems to work as expected in all modes detected
(S0, S1, S3, S4bios, S4, S5), except that the backlight stays on after
"echo [1,3] > /proc/acpi/sleep".  S1 just refrigerates everything, and
leaves the display on, resume works fine.

S3 refrigerates everything and suspends, leaving the display white.
Resuming turns the backlight off.  I can retrieve the backlight with the
LCD/CRT button.

Both S4's behave properly (full power off/restore with the power button).

What part of the code should I look at to attack this problem (ACPI
tables, linux/arch/i386/kernel/acpi/*, or linux/drivers/acpi/*)?  DSDT
compiles ok with the iasl assembler/disassembler, and Windows XP goes into
standby properly; so I assume that the ACPI tables can be driven by the
OS.  Perhaps something along the lines of the asus_acpi code?

	dave


On Wed, 23 Jul 2003, Pavel Machek wrote:

> Hi!
>
> > i just tried 2.6.0-test1 and to my expectation the S3 resume stuff still
> > does not work on the Sony Vaio PCG-C1MHP aka Picturebook. It turns on -
> > Bios set the powerled correct but then - nothing - Nothing on the
> > screen, no backlight, no disk activity.
> >
> > Is there any way to dump the Windows wakeup code ?
> > Is that machine specific ?
>
> Wakeup code should *not* be machine-specific, but video card
> save/restore is obviously video-card specific (and you basically can't
> get docs). Write beeping code in 8086 assembly and start debuggin'
> ;-))).
>
> 								Pavel



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
