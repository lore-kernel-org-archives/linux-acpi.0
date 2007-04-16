From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: Unable to turn cooling device [hex ref] 'off'
Date: Mon, 16 Apr 2007 11:15:17 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DE16B687@pdsmsx414.ccr.corp.intel.com>
References: <58ecf16f0704141234p67bf5249n95274c8f46a93f24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43643 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754362AbXDPDPa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Apr 2007 23:15:30 -0400
Content-class: urn:content-classes:message
In-Reply-To: <58ecf16f0704141234p67bf5249n95274c8f46a93f24@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hoyle <hoyle.richard@googlemail.com>, linux-acpi@vger.kernel.org

Make sure CONFIG_ACPI_DEBUG is set first,
#echo 0x1f >/sys/module/acpi/parameters/debug_level
And then probe modules fan and thermal
to get more information.
Or you can file a bug report at bugzilla.kernel.org.

Best regards,
Zhang.Rui(Ray)

=20
-----Original Message-----
=46rom: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.=
kernel.org] On Behalf Of Richard Hoyle
Sent: 2007=C4=EA4=D4=C215=C8=D5 3:35
To: linux-acpi@vger.kernel.org
Subject: Unable to turn cooling device [hex ref] 'off'

Hi,

I'm getting many errors of the sort:

kernel: ACPI: Transitioning device [FAN0] to D3
kernel: ACPI: Transitioning device [FAN0] to D3
kernel: ACPI: Unable to turn cooling device [c18f9428] 'off'

every /proc/acpi/thermal_zone/THRM/polling_frequency seconds.

The machine does not seem to turn the fan off very much, if at all.

The machine is a 'whitebook' built by Stone Computers in the UK.  Its c=
hassis
was built by First International Computers it China.  The cpu is:

model name      : Intel(R) Core(TM)2 CPU         T7200  @ 2.00GHz
stepping        : 6
cache size      : 4096 KB

The kernel version is 2.6.20.3

Distro is a current as of writing Slackware-current (but I get the same=
 probs
under Knoppix 5.1.1).

These mods are loaded:

/sbin/modprobe thermal
/sbin/modprobe button
/sbin/modprobe ac
/sbin/modprobe battery
/sbin/modprobe processor
/sbin/modprobe container
/sbin/modprobe fan
/sbin/modprobe dock
/sbin/modprobe i2c_ec
/sbin/modprobe video
/sbin/modprobe sbs

# And these for speedstep:

/sbin/modprobe freq_table
/sbin/modprobe processor
/sbin/modprobe speedstep_lib
/sbin/modprobe acpi_cpufreq
/sbin/modprobe cpufreq_ondemand

This is for the obvious:

echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor

And I do this, as otherwise the fan stays off:
#Turn of thermal polling frequency to 30 secs
echo "30" > /proc/acpi/thermal_zone/THRM/polling_frequency

There seems to be two fans reported by the system:

/proc/acpi/fan
/proc/acpi/fan/FAN1
/proc/acpi/fan/FAN1/state
/proc/acpi/fan/FAN0
/proc/acpi/fan/FAN0/state

=46inally, the fan seems to work as and when needed under M$ XP.

More than happy to provide an acpidump listing if I'm not doing
anything obviously stupid.

Thanks for all your work on the kernel, and for any help you
might be able to give me.

All the best,

=3D=3D=3DRich
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
