From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: Applications & ACPI events
Date: Wed, 15 Oct 2003 09:20:22 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0310150907450.953-100000@localhost.localdomain>
References: <20031014234538.GD1918@fairlite.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


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

Not quite what I was looking for, but thanks. 

What state would the i830 driver save? 

What more would you expect to save with ACPI?

Do you expect XInput drivers to care? 

> Currently I've got X opening /proc/acpi/events and acting upon them, but
> obviously this race condition is with the kernel shutting us down before
> X has a chance to catch up. This is where the stickling point is on
> how to signal X from the kernel.

It's actually a lot cleaner, and a lot easier to use the hotplug interface 
that I described before. We can extend the X API to include a PM event 
signalling mechanism. The hotplug scripts can call some simple X app that 
sends the message to the server and causes the graphics driver (and any 
XInput drivers that need the message) to save state. 

This would also be portable across Linux platforms that used different 
mechanisms for reading PM events from the kernel (acpid or some APM 
daemon); and across OSes that have similar needs.


	Pat




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
