From: "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>
Subject: s3 crashes Dell X200 on 2.6.0-test9/ACPI 20031002
Date: Sun, 02 Nov 2003 14:34:37 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1067812477.4087.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'm trying to use S3 on my Dell X200.  I have tried both

echo 3 > /proc/acpi/sleep
and
echo -n mem > /sys/power/state

It shuts down appropriately (I think), but refuses to come back. 
Pressing the power button does nothing.  Holding the power button down
does nothing.  In fact, the only way I can use my computer again is to
unplug the power and battery, wait 5+ minutes, and then plug it back in.

If I do this with the battery plugged in, usually the battery charging
light comes on and stays on.

If I do this in text mode, I can see it print 3 lines and then vanish. 
The first line looks like it has a bunch of '+' and/or '-'; I have no
idea what the other two lines look like.

Something tells me this is a bug in the DSDT, but I honestly have no
idea.  And debugging is obviously quite difficult.  Any idea what I'm
doing wrong, or what I should look for?

My configuration is:

Dell X200 (Pentium M3), with the A09 bios (latest on Dell's website; had
the same effect with the older BIOS I was running before)

2.6.0-test9 kernel with Andrew Morton patches (as delivered by Gentoo;
includes ACPI 20031002)

ACPI patch for custom DSDT (tried with and without the custom DSDT, same
effect)

/proc/acpi/sleep: S0 S3 S4 S5 

egrep "ACPI|APIC|MCE" /etc/kernels/config-2.6.0-test9-mm1 
CONFIG_X86_GOOD_APIC=y
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_MCE is not set
# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set

ACPI is not compiled as a module (duh)


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
