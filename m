From: Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>
Subject: Re: Re: Hardware state saving & X
Date: Thu, 16 Oct 2003 01:10:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031016001001.GH1921@fairlite.demon.co.uk>
References: <20031014235240.GD20789@elf.ucw.cz> <Pine.LNX.4.44.0310150924400.953-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310150924400.953-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 15, 2003 at 09:32:18AM -0700, Patrick Mochel wrote:
> The fact that different behavior exists is completely obvious (refer to 
> the question and documentation). The question was *how* it was different 
> from a userpsace perspective. I.e. what exactly is saved, and what isn't. 
> 
> Under APM, the BIOS handles the state transition, but it does not know 
> each device initimately, so the OS still has to handle some of the device 
> state. 
> 
> Video devices have an int10 call to save/restore state, which is what the 
> APM BIOS uses. Alan, would it suffice to call that from the kernel, in 
> either vm86 mode or real mode to handle all the saving/restoring. If we 
> were able to call that, what more would you have to do? 

I'm not sure you can call int10 from kernel space. But think about
other architectures too that don't have int10/x86 available to them.
XFree86 already has an x86 emulator to do the softbooting via int10 in
userspace, but I appreciate if people are not running X, then the kernel
needs to restore some sort of text mode too from the last session.

It's never been an issue of what to save/restore for X - that's the drivers
responsibility in X. And if it doesn't do it properly now, I'd consider it
a bug in the driver and should be fixed.

The main question was how to get events from suspend/resume so that we
can do this saving and restoring.

If the /sbin/hotplug & DBUS is the recommended route, then I really
need to go look at these two pieces of software and craft something up for X.

Alan.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
