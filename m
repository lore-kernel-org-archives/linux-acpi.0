From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Desktop and S3 suspend the Holy Grail of ACPI?
Date: 25 Feb 2004 00:17:08 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077686228.5911.93.camel@dhcppc4>
References: <4038F499.2060302@verizon.net>
	 <1077517907.12673.43.camel@dhcppc4>  <403ADBCC.9060108@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <403ADBCC.9060108-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nick Lidakis <nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> > ...D875PBZ...

On this box S1 works for me, but S3 doesn't resume (below)

Note that you need to enable S3 in the BIOS SETUP to try S3.

Note that neither S1 nor S3 will do anything on the SMP kernel.
(and unfortunately, they will not even tell you that when you try)

-Len

BIOS SETUP: Power/ACPI
ACPI Suspend State [S3 State] (default is S1)

boot FC2-test1 UP kernel

# cat /proc/acpi/sleep
S0 S1 S3 S4 S5

# /etc/init.d/acpid stop
(to make power button resume event not initiate a shut-down)

# echo 1 >/proc/acpi/sleep
Stopping tasks: ================================|
psmouse.c: bad data from KBC - timeout bad parity
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
psmouse.c: bad data from KBC - timeout bad parity
psmouse.c: bad data from KBC - timeout bad parity
PM: Entering state.
i8042.c: Can't restore CTR.


<press power button here to resume>


Back to C!
i8042.c: Can't read CTR while initializing i8042.
i8042: resume failed
PM: Finishing up.
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.3 to 64
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex
blk: queue f7dcb5c0, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks... done
#

system running normally here.

now try S3:

# echo 3 >/proc/acpi/sleep
Stopping tasks: =================================|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Entering state.

<power is off, press power button here to wake up system>

here a bunch of garbled junk comes out my serial console.
But video is not restored to my matrox mystique FB.
ping doesn't work.

Curiously CTRL-ALT-DEL results in the following on the serial console:

quotaoff: numerical sysctl 5 16 8 is obsolete.
md: stopping all md devices.
md: md0 switched to read-only mode.
Restarting system.

<and the system reboots here>

So it seems that the system did resume and talk to the keyboard at
least...





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
