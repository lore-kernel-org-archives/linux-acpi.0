From: Robert Vollmert <rvollmert-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Shuttle SB61G2 fan speed
Date: Wed, 8 Oct 2003 11:25:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031008092521.GA994@krikkit>
References: <E1A73Nv-0001M5-68@cell01.cell01.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1A73Nv-0001M5-68-6vcCkRnH9/iXl4vLVl4uKAC/G2K4zDHf@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: digitale-eFwX6J65rk/J8bqQQ1YlwQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

On Tue, Oct 07, 2003 at 09:45:03PM -0400, Eric Northup wrote:
> I have a Shuttle mini-PC currently running linux 2.6-test6 (but I have
> seen this issue w/all kernels I've tried, 2.4.x and 2.5.x).  It has a
> "smart" fan control, which regulates the speed of the system fan
> according to the temperature (a Thermal Zone in ACPI terms, yes?).  The
> problem is: as soon as Linux gets control from GRUB, the fan goes to
> full speed and stays there.

I assume you've enabled ACPI? To what extent does it work? I.e. are
there errors in dmesg (try compiling with debug support?), what parts
of /proc/acpi appear functional (temperature, fan)?

If it sort of works, it could be an issue with the DSDT. Check
acpi.sf.net for information on how to extract this.

There might also be some BIOS options that affect this. In particular,
a few sites seem to suggest problems with certain APIC options.

> I have flashed the BIOS to the latest (which claimed to fix a fan speed
> problem with Windows), but the problem persists.  So I don't know if it
> is a case of pilot error, a Linux bug, or a BIOS bug.  Any help sorting
> this out would be much appreciated :)

Shuttle seem to be quite supportive of Linux from what I can tell by
checking their web site. So if this turns out to be a BIOS/DSDT
problem, maybe you could get them to update it.

Cheers
Robert


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
