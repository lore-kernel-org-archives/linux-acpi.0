From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Applications & ACPI events
Date: Wed, 15 Oct 2003 01:55:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031014235550.GE20789@elf.ucw.cz>
References: <20031013171704.GH15441@elf.ucw.cz> <Pine.LNX.4.44.0310141556320.803-100000@cherise> <20031014234538.GD1918@fairlite.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031014234538.GD1918-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>
Cc: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > Patch looks reasonable, but:
> > > 
> > > STATE= should really be more finegrained. ACPI s3 is really differnent
> > > from apm -s, and it looks to me like you'll only tell userspace 'mem'.
> > 
> > Well, it depends on what X (and in general userspace) needs to know on a 
> > power-state transition. Alan, how does/will X behave differently for each 
> > power state that we can enter? 
>  
> Not normally, but it can. X has two functions called EnterVT() and LeaveVT()
> when switching VT's, but we can also define a function called PMEvent() in
> each driver to do specific things based on the PM event type. Now back
> in the days of APM we can handle various things, and the only driver that
> implements the extended functionality of PMEvent() currently is the Intel
> i830 driver. Traditionally though, during an APM event we'd normally just
> called the drivers EnterVT()/LeaveVT() function.
> 
> So with APM we could open /proc/apm & /dev/apm_bios and X could get
> events itself and deal with them in different ways.
> 
> Currently I've got X opening /proc/acpi/events and acting upon them, but
> obviously this race condition is with the kernel shutting us down before
> X has a chance to catch up. This is where the stickling point is on
> how to signal X from the kernel.
> 
> I'm keen to hear anymore opinions on this.

Kernel really should call LeaveVT() before suspend, and EnterVT()
after suspend [And it does now, with exception of apm.]. That should
get rid of 99% of problems... The rest of them can be handled by
Patrick's hotplug patch. (Ouch, it makes X depend on
/sbin/hotplug... :-( )



								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
