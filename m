From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: ACPI Thermal zone passive cooling trigger problem
Date: Fri, 23 Aug 2002 10:37:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020823093728.GB13092@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I think I've got a handle on what is happening now.

The processor is hot (about 65 degrees).  This is the temperature that
is in the thermal zone for passive cooling (switch the processor state
slow to reduce temperature).

Now my problem is that I'm not exactly sure what's delivering what
messages where.

What I do know is that /proc/acpi/events is being flooded by
processor 0x80 events which I think is a request to change state.
The processor isn't changing state, and you can't make it change
state when this is happening, I assume because of some mutex on
the embedded controller which the event scheduler almost
always has lock on.

Should the kernel be handling the processor change-state event,
switching the speedstep to slow/cooler mode and then solving the problem
(yay) or should there be a user mode program receiving the event and
changing the state - it won't work because it can't get a schedule in
whilst the mutex is released.

Is it a problem with the kernel acpi code that the event is being
delivered so often?  Is it something the kernel is doing - execute code
to check temperature, find it over passive limit, send notify. which
is doing it every time the temperature is checked rather than just when
the boundary changes.

I looked through the dsdt and couldn't find anything wrong, the thermal
zone configuration is pretty standard.

So many questions and so few answers.  Would removing the thermal zone
support from the kernel provide a workaround in the meantime?  I'd
rather run at 65 degrees than the 85 that the spinning non-blocking
events cause at full clock and full fan.

If I remove power at boot time, the CPU is started at 800Mhz and if I
leave the speedstep daemon unloaded the laptop remains at 50 degrees
on passive cooling.



-- 
Faye Pearson,
Software Development Manager,
ClaraNET Ltd.       Tel 020 7903 3000

So this is it.  We're going to die.


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
