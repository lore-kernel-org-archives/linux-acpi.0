From: <joerg.beyer-htSm2yLGOjU@public.gmane.org>
Subject: fan
Date: Sun, 1 Sep 2002 23:33:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209012133.g81LXbX31417@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpilist <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I am unsure if the fan handling on my laptop works, so I made
a experiment. I wanted to switch the fan on and off via
echo -n 0 > /proc/acpi/fan/FAN/state
to switch the fan off and echo -n 1 >.../state to switch the fan on.
That did not work. First of all: cat /proc/acpi/fan/FAN/state
always said that "status:     on" - but the fan some times
on, some times off.

For better debugging, I added a printk in fan.c:acpi_fan_write_state,
as you can see below. I echo'd the values you can see. The fan
began to work when I said "echo -n 3> /proc/a/f/F/state".


from var log messages:
Sep  1 23:05:03 wally kernel: fan_write 0, state_string '0'
Sep  1 23:05:22 wally kernel: fan_write 1, state_string '1'
Sep  1 23:05:22 wally kernel: acpi_bus-0472 [06] acpi_bus_set_power    : Device does not support D1
Sep  1 23:06:27 wally kernel: fan_write 3, state_string '3'
Sep  1 23:06:27 wally kernel: acpi_power-0363 [07] acpi_power_transition : Error transitioning device [FAN] to D3
Sep  1 23:06:27 wally kernel: acpi_bus-0521 [06] acpi_bus_set_power    : Error transitioning device [FAN] to D3
Sep  1 23:06:42 wally kernel: fan_write 1, state_string '1'
Sep  1 23:06:42 wally kernel: acpi_bus-0472 [06] acpi_bus_set_power    : Device does not support D1
Sep  1 23:06:50 wally kernel: fan_write 3, state_string '3'
Sep  1 23:06:55 wally kernel: fan_write 0, state_string '0'

I am using linux-2.4.20-pre5 with latest apci patch, everthing enabled,
on a laptop. If you need more input, please ask.

Here my questions:

is echo -n 0 >/proc/acpi/fan/FAN/state
ment to stop the fan and
is echo -n 1 >/proc/acpi/fan/FAN/state
ment to start the fan?

What does the "Error transitioning device [FAN] to D3" mean?

    TIA
    Joerg




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
