From: "Richard Hoyle" <hoyle.richard@googlemail.com>
Subject: Unable to turn cooling device [hex ref] 'off'
Date: Sat, 14 Apr 2007 20:34:51 +0100
Message-ID: <58ecf16f0704141234p67bf5249n95274c8f46a93f24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:11931 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbXDNTex (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Apr 2007 15:34:53 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1203173wxd
        for <linux-acpi@vger.kernel.org>; Sat, 14 Apr 2007 12:34:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I'm getting many errors of the sort:

kernel: ACPI: Transitioning device [FAN0] to D3
kernel: ACPI: Transitioning device [FAN0] to D3
kernel: ACPI: Unable to turn cooling device [c18f9428] 'off'

every /proc/acpi/thermal_zone/THRM/polling_frequency seconds.

The machine does not seem to turn the fan off very much, if at all.

The machine is a 'whitebook' built by Stone Computers in the UK.  Its chassis
was built by First International Computers it China.  The cpu is:

model name      : Intel(R) Core(TM)2 CPU         T7200  @ 2.00GHz
stepping        : 6
cache size      : 4096 KB

The kernel version is 2.6.20.3

Distro is a current as of writing Slackware-current (but I get the same probs
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

Finally, the fan seems to work as and when needed under M$ XP.

More than happy to provide an acpidump listing if I'm not doing
anything obviously stupid.

Thanks for all your work on the kernel, and for any help you
might be able to give me.

All the best,

===Rich
