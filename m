From: gozdal-qgjm33LpC3Eiq3RsQ1AnAw@public.gmane.org (Marcin Gozdalik)
Subject: Problems with S3 on Thinkpad R31
Date: Sat, 27 Mar 2004 20:31:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040327193100.GA22149@gozdal.eu.org>
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

Hello

I'm trying to get ACPI S3 sleep to work on my IBM ThinkPad R31 (Celeron
1.06Ghz, Intel 830 chipset). So far I am able to suspend it using "echo 3 >
/proc/acpi/sleep", but closing/opening the LID or pressing the Fn button
turns the power LED on (but it doesn't disable the "moon" LED indicating
sleep) and nothing more (hard disk doesn't seem to spin up - i.e. I
can't hear it) - the screen is completely blank and it doesn't respond
to any keyboard input. I have to reboot using 5-sec press of Power
button.
To suspend the laptop I have to manually remove CD-ROM drive from the
bay (laptop powered off of course during the operation). With CD-ROM
plugged in it displays "hdc: drive not ready for command", "hdc: DMA
disabled", some more error codes and hangs indefinetely.
I have tried 2.6.5-rc2-mm4 and 2.6.5-rc2-aa4 - both exhibit the same
behavior. I booted clean in single user mode (no hotplug running, no X,
no AGP modules, no USB modules). As a side note - the USB mouse I'm
using was connected to the computer all the time during experiments and
even when the laptop was suspended the mouse was powered on. I have no
idea if this is an expected behavior (haven't checked under Windows XP
though).
How can I debug this issue? Is ACPI S3 of any use under 2.6?
Please Cc me all the answers as I am not subscribed to acpi-devel.

Cheers,
Marcin


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
