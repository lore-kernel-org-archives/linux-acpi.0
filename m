From: Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>
Subject: Re: Applications & ACPI events
Date: Wed, 15 Oct 2003 18:07:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031015170735.GD1921@fairlite.demon.co.uk>
References: <20031014234538.GD1918@fairlite.demon.co.uk> <Pine.LNX.4.44.0310150907450.953-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310150907450.953-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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

On Wed, Oct 15, 2003 at 09:20:22AM -0700, Patrick Mochel wrote:
> 
> > > Well, it depends on what X (and in general userspace) needs to know on a 
> > > power-state transition. Alan, how does/will X behave differently for each 
> > > power state that we can enter? 
> >  
> > Not normally, but it can. X has two functions called EnterVT() and LeaveVT()
> > when switching VT's, but we can also define a function called PMEvent() in
> > each driver to do specific things based on the PM event type. Now back
> > in the days of APM we can handle various things, and the only driver that
> > implements the extended functionality of PMEvent() currently is the Intel
> > i830 driver. Traditionally though, during an APM event we'd normally just
> > called the drivers EnterVT()/LeaveVT() function.
> 
> Not quite what I was looking for, but thanks. 
 
Then, can you elaborate on what you are looking for ??

> What state would the i830 driver save? 

Driver specific stuff. Anything it wants to...
 
> What more would you expect to save with ACPI?

Nothing. I'm not sure what your asking here. The EnterVT/LeaveVT functions
do all the save and restoring of the driver specific state, so if the
kernel is doing a VT switch for us, then X should work out of the box.

> Do you expect XInput drivers to care? 
 
Possibly, it's not something I've considered yet. I'd like to get the
graphics driver doing the right thing first.

> > Currently I've got X opening /proc/acpi/events and acting upon them, but
> > obviously this race condition is with the kernel shutting us down before
> > X has a chance to catch up. This is where the stickling point is on
> > how to signal X from the kernel.
> 
> It's actually a lot cleaner, and a lot easier to use the hotplug interface 
> that I described before. We can extend the X API to include a PM event 
> signalling mechanism. The hotplug scripts can call some simple X app that 
> sends the message to the server and causes the graphics driver (and any 
> XInput drivers that need the message) to save state. 
> 
> This would also be portable across Linux platforms that used different 
> mechanisms for reading PM events from the kernel (acpid or some APM 
> daemon); and across OSes that have similar needs.

I know. I've now got to go off and plug up some solution for the hotplug
scripts to signal X.

Alan.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
