From: Sebastian Seifert <lathander-Mmb7MZpHnFY@public.gmane.org>
Subject: race during power transition?
Date: Sat, 6 Mar 2004 11:29:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040306102933.GA4701@ergo.gotdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

every now and then I have an entry in my log file that looks like:

Mar  5 02:46:37 tenshi kernel:  acpi_bus-0262 [4159] acpi_bus_set_power    : Error transitioning device [FAN1] to D0
Mar  5 02:46:37 tenshi kernel: acpi_thermal-0612 [4158] acpi_thermal_active   : Unable to turn cooling device [dff5fb68] 'on'

I can sometimes provoke it by doing an "echo 0 > /proc/acpi/fan/FAN1/state".
With some debugging outputs (printks inserted by me), it looks like this:

Mar  5 02:46:37 tenshi kernel: Trying to transition FAN1 from D3 to D0
Mar  5 02:46:37 tenshi kernel: setting ACPI_STATE_UNKNOWN in acpi_power_transition.
Mar  5 02:46:37 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 3 (3)
Mar  5 02:46:37 tenshi kernel: AML_RELEASE_OP on [MUT1] by thread 3 (3)
Mar  5 02:46:37 tenshi kernel: Trying to transition FAN1 from D255 to D0
Mar  5 02:46:37 tenshi kernel:  device-power.state == 255
Mar  5 02:46:37 tenshi kernel: bus case 1: result -19
Mar  5 02:46:37 tenshi kernel:  acpi_bus-0262 [4159] acpi_bus_set_power    : Error transitioning device [FAN1] to D0
Mar  5 02:46:37 tenshi kernel: acpi_thermal-0612 [4158] acpi_thermal_active   : Unable to turn cooling device [dff5fb68] 'on'

What seems to happen is that during the first transition from D3 to D0 (in
acpi_power_transition), device->power.state is set to ACPI_STATE_UNKNOWN. Then,
before the first transition is finished and before the state is set to D3, the
second transition takes place. It then fails with -ENODEV (-19) , because of
the undefined power state.

This seems like a bug to me... should I file it somewhere? The second
transition should wait until the first is completed, shouldn't it? If the first
is different from the second (e.g. the first transition turns the fan off, but
the second turns it back on for thermal reasons), the second must not get lost.

Benq Joybook 5000, Kernel 2.6.3-mm4, preemption enabled.

Sebastian

-- 
The first law of Engineering Mathematics: All infinite series converge,
and moreover converge to the first term.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
