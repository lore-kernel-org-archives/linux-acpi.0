From: "Richard Hoyle" <hoyle.richard@googlemail.com>
Subject: Re: Unable to turn cooling device [hex ref] 'off'
Date: Tue, 17 Apr 2007 11:47:53 +0100
Message-ID: <58ecf16f0704170347i1ad152fcs482777b6a17bad86@mail.gmail.com>
References: <58ecf16f0704141234p67bf5249n95274c8f46a93f24@mail.gmail.com>
	 <823A93EED437D048963A3697DB0E35DE16B687@pdsmsx414.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_66299_19685774.1176806873082"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:40608 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbXDQKry (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Apr 2007 06:47:54 -0400
Received: by ug-out-1314.google.com with SMTP id 44so135242uga
        for <linux-acpi@vger.kernel.org>; Tue, 17 Apr 2007 03:47:53 -0700 (PDT)
In-Reply-To: <823A93EED437D048963A3697DB0E35DE16B687@pdsmsx414.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

------=_Part_66299_19685774.1176806873082
Content-Type: text/plain; charset=ISO-2022-JP; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Rui,

Setting the debug options seems to have changed the problems a
little.  With the debug options set, the fan can either stay on or
stay off.  Also, executing

cat /proc/acpi/thermal_zone/THRM/temperature

caused kacpid to hog almost all system resources at one point, and
cat became unkillable.  Though now, I can find no consisency with
the fan state issue.

Firstly, more info.

Your stanza:

echo 0x1f >/sys/module/acpi/parameters/debug_level

needed to be changed to echo 0x1f > /proc/acpi/debug_level.  No
acpi dir in my /sys/module.

###

Doing the whole dstd decompile, compile thing works fine with no
errors. The decompiled dsdt.dsl is attached below.

###

Doing this pretty much always give me status 'on' regardless of whether
I can hear the fan:

cat /proc/acpi/fan/FAN*/*
status:                  on
status:                  on


###cat /proc/acpi/thermal_zone/THRM/trip_points
critical (S5):           110 C
passive:                 86 C: tc1=3 tc2=1 tsp=336 devices=0xc18f3d74 0xc18f3d60

active[0]:               70 C: devices=0xc18f9428
active[1]:               60 C: devices=0xc18f93c4

###

Here's a snippet from syslog showing the messages associated with
not being able to turn the fan off.

These at 20 secs past the minute.

kernel: Execute Method: [\_TZ_.THRM._TMP] (Node c18f9b44)
kernel: exregion-0291 [16] ex_system_io_space_han: System-IO (width 8)
R/W 0 Address=000000000000006C
kernel: exregion-0291 [17] ex_system_io_space_han: System-IO (width 8)
R/W 1 Address=000000000000006C
kernel: exregion-0291 [16] ex_system_io_space_han: System-IO (width 8)
R/W 0 Address=000000000000006C
kernel: exregion-0291 [17] ex_system_io_space_han: System-IO (width 8)
R/W 1 Address=0000000000000068
kernel: exregion-0291 [16] ex_system_io_space_han: System-IO (width 8)
R/W 0 Address=000000000000006C
last message repeated 2 times
kernel: exregion-0291 [16] ex_system_io_space_han: System-IO (width 8)
R/W 0 Address=0000000000000068
kernel: acpi_utils-0287 [00] evaluate_integer      : Return value [3160]
kernel: acpi_thermal-0237 [00] thermal_get_temperatur: Temperature is 3160 dK
kernel: acpi_utils-0287 [00] evaluate_integer      : Return value [0]
kernel: acpi_bus-0172 [00] bus_get_power         : Device [FAN0] power
state is D0
kernel: Execute Method: [\_TZ_.PFN0._OFF] (Node c18f94a0)
kernel: exregion-0186 [17] ex_system_memory_space: System-Memory
(width 8) R/W 1 Address=000000003F6EDE5F
kernel: exregion-0186 [17] ex_system_memory_space: System-Memory
(width 8) R/W 1 Address=000000003F6EDE4F
kernel: exregion-0291 [17] ex_system_io_space_han: System-IO (width 8)
R/W 1 Address=0000000000000808
kernel: Execute Method: [\_TZ_.PFN0._STA] (Node c18f948c)
kernel: acpi_utils-0287 [00] evaluate_integer      : Return value [1]
kernel: acpi_power-0137 [00] power_get_state       : Resource [PFN0] is on
kernel: ACPI: Transitioning device [FAN0] to D3
kernel: ACPI: Transitioning device [FAN0] to D3
kernel: ACPI: Unable to turn cooling device [c18f9428] 'off'
kernel: acpi_thermal-0750 [00] thermal_check         : THRM:
temperature[3160] sleep[30000]

These at 50 secs past the min:
kernel: Execute Method: [\_TZ_.THRM._TMP] (Node c18f9b44)
kernel: exregion-0291 [16] ex_system_io_space_han: System-IO (width 8)
R/W 0 Address=000000000000006C
kernel: exregion-0291 [17] ex_system_io_space_han: System-IO (width 8)
R/W 1 Address=000000000000006C
kernel: exregion-0291 [16] ex_system_io_space_han: System-IO (width 8)
R/W 0 Address=000000000000006C
kernel: exregion-0291 [17] ex_system_io_space_han: System-IO (width 8)
R/W 1 Address=0000000000000068
kernel: exregion-0291 [16] ex_system_io_space_han: System-IO (width 8)
R/W 0 Address=000000000000006C
last message repeated 2 times
kernel: exregion-0291 [16] ex_system_io_space_han: System-IO (width 8)
R/W 0 Address=0000000000000068
kernel: acpi_utils-0287 [00] evaluate_integer      : Return value [3160]
kernel: acpi_thermal-0237 [00] thermal_get_temperatur: Temperature is 3160 dK
kernel: acpi_utils-0287 [00] evaluate_integer      : Return value [0]
kernel: acpi_bus-0172 [00] bus_get_power         : Device [FAN0] power
state is D0
kernel: Execute Method: [\_TZ_.PFN0._OFF] (Node c18f94a0)
kernel: exregion-0186 [17] ex_system_memory_space: System-Memory
(width 8) R/W 1 Address=000000003F6EDE5F
kernel: exregion-0186 [17] ex_system_memory_space: System-Memory
(width 8) R/W 1 Address=000000003F6EDE4F
kernel: exregion-0291 [17] ex_system_io_space_han: System-IO (width 8)
R/W 1 Address=0000000000000808
kernel: Execute Method: [\_TZ_.PFN0._STA] (Node c18f948c)
kernel: acpi_utils-0287 [00] evaluate_integer      : Return value [1]
kernel: acpi_power-0137 [00] power_get_state       : Resource [PFN0] is on
kernel: ACPI: Transitioning device [FAN0] to D3
kernel: ACPI: Transitioning device [FAN0] to D3
kernel: ACPI: Unable to turn cooling device [c18f9428] 'off'
kernel: acpi_thermal-0750 [00] thermal_check         : THRM:
temperature[3160] sleep[30000]


Attached, the dsdt for the machine.

Thanks again for your help.

Best wishes,

===Rich





On 4/16/07, Zhang, Rui <rui.zhang@intel.com> wrote:
> Make sure CONFIG_ACPI_DEBUG is set first,
> #echo 0x1f >/sys/module/acpi/parameters/debug_level
> And then probe modules fan and thermal
> to get more information.
> Or you can file a bug report at bugzilla.kernel.org.
>
> Best regards,
> Zhang.Rui(Ray)
>
>
> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Richard Hoyle
> Sent: 2007年4月15日 3:35
> To: linux-acpi@vger.kernel.org
> Subject: Unable to turn cooling device [hex ref] 'off'
>
> Hi,
>
> I'm getting many errors of the sort:
>
> kernel: ACPI: Transitioning device [FAN0] to D3
> kernel: ACPI: Transitioning device [FAN0] to D3
> kernel: ACPI: Unable to turn cooling device [c18f9428] 'off'
>
> every /proc/acpi/thermal_zone/THRM/polling_frequency seconds.
>
> The machine does not seem to turn the fan off very much, if at all.
>
> The machine is a 'whitebook' built by Stone Computers in the UK.  Its chassis
> was built by First International Computers it China.  The cpu is:
>
> model name      : Intel(R) Core(TM)2 CPU         T7200  @ 2.00GHz
> stepping        : 6
> cache size      : 4096 KB
>
> The kernel version is 2.6.20.3
>
> Distro is a current as of writing Slackware-current (but I get the same probs
> under Knoppix 5.1.1).
>
> These mods are loaded:
>
> /sbin/modprobe thermal
> /sbin/modprobe button
> /sbin/modprobe ac
> /sbin/modprobe battery
> /sbin/modprobe processor
> /sbin/modprobe container
> /sbin/modprobe fan
> /sbin/modprobe dock
> /sbin/modprobe i2c_ec
> /sbin/modprobe video
> /sbin/modprobe sbs
>
> # And these for speedstep:
>
> /sbin/modprobe freq_table
> /sbin/modprobe processor
> /sbin/modprobe speedstep_lib
> /sbin/modprobe acpi_cpufreq
> /sbin/modprobe cpufreq_ondemand
>
> This is for the obvious:
>
> echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
>
> And I do this, as otherwise the fan stays off:
> #Turn of thermal polling frequency to 30 secs
> echo "30" > /proc/acpi/thermal_zone/THRM/polling_frequency
>
> There seems to be two fans reported by the system:
>
> /proc/acpi/fan
> /proc/acpi/fan/FAN1
> /proc/acpi/fan/FAN1/state
> /proc/acpi/fan/FAN0
> /proc/acpi/fan/FAN0/state
>
> Finally, the fan seems to work as and when needed under M$ XP.
>
> More than happy to provide an acpidump listing if I'm not doing
> anything obviously stupid.
>
> Thanks for all your work on the kernel, and for any help you
> might be able to give me.
>
> All the best,
>
> ===Rich
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

------=_Part_66299_19685774.1176806873082
Content-Type: application/x-bzip2; name=dsdt.dsl.bz2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f0m8a4tw
Content-Disposition: attachment; filename="dsdt.dsl.bz2"

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
MJP/xdyRThQkBsZSzYA=
------=_Part_66299_19685774.1176806873082--
