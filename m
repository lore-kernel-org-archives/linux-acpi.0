From: "Geoffrey Hausheer" <iw3r96f6j1h-jEt0PViQLFVB+phRjrLsidBPR1lH4CV8@public.gmane.org>
Subject: can't trigger sleep modes.
Date: Thu, 15 Aug 2002 05:16:12 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <A5974D8E5F98D511BB910002A50A664704303C4A@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

I'm quite new to the whole ACPI thing, so perhaps I'm going about this
completely wrong.

I'm trying to put my laptop to sleep using ACPI, but to no avail.

Using a clean 2.4.19 tree, doing 'echo -n 1 > /proc/acpi/sleep' hangs the
machine.
doing 'echo -n 4 > /proc/acpi/sleep' shutdown the machine immediately
I've tried this with and without acpid running.

So I pulled the latest code from the bk repository (linux-2.4-acpi), and now
doing 'echo -n $i > /proc/acpi/sleep' does nothing (just returns the
prompt).
where $i is any of 0,1,4,or 5

cat /proc/acpi/sleep yields:
S0 S1 S4 S5

with acpid disabled, when I cat /proc/acpi/events, I can see events being
detected.  The sleep button, power button, and lid-close all seem to get
detected correctly, as does inserting and removing the battery.

the battery, ac_adapter, and processor subdirectories all contain useful and
correct looking info.
/var/log/syslog shows the following on startup:
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery absent) <--this is correct (I took out
the
battery)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LIDD]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1, C2, 8 throttling states)

monitoring /proc/acpi/events for each button yields:
SLPB 00000080 00000001
LIDD 00000080 00000001  <---close
LIDD 00000080 00000002  <---open
PWRF 00000080 00000001

I could try installing the swsusp patch, but it is my understanding that
this
just fakes hibernation (suspend to disk), while I am trying to get suspend
to
ram working (also getting the hardware suspend working would be nice too)

I have compiled in the extra debugging messages, but am not seeing anything
 in /var/log/syslog (or any other log directory).  I do see debug_layer and
 debug_level in /proc/acpi but I have no idea what to do with these.

By the way, the laptop is a twinhead n2380 which uses the sis630st chipset,
and has a PIII (tualatin) mobile processor.

Am I doing something wrong?  Is there something I can do to provide more
information?

Thanks,
Geoff


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
