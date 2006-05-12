From: Brian Dunn <job17and9@sbcglobal.net>
Subject: Overheating on a Latitude C600
Date: Thu, 11 May 2006 19:11:15 -0500
Message-ID: <4463D2A3.3060409@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:59740 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750705AbWELALp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 May 2006 20:11:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

Hello all.
I'm working on getting acpi working correctly on my latitude C600.  All 
events work correctly, but the fan does not automaticaly come on when 
the processor gets hot.  ( Luckily I have the i8k module and i8kutils 
working, so I haven't melted my processor yet. and then the bios handles 
the fan alright when I use apm, too. )  Can anyone tell me what i may 
have broke?  When i jave PNPACPI enabled i get this:

brian@grace ~ $ sudo modprobe thermal
WARNING: Error inserting processor 
(/lib/modules/2.6.16-gentoo-r6/kernel/drivers/acpi/processor.ko): 
Invalid module format

I found this in my dmesg:
processor: exports duplicate symbol acpi_processor_set_thermal_limit 
(owned by kernel)

I have the kernel ( 2.6.16-gentoo-r6) configured like this:
brian@grace /usr/src/linux $ cat .config | grep ACPI
# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_CONTAINER is not set
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_PNPACPI=y
# CONFIG_SERIAL_8250_ACPI is not set

also i noticed that when i modprobe button, fan, or any of these modules 
i get duplicate directories in /proc/acpi.

without PNPACPI, the modules load fine, but the fans still don't ever 
seem to come on by themselves, and i'm afraid to let the processor go 
above 80C. 

/proc/acpi/thermal_zone/THM $ cat *
<setting not supported>
cooling mode:   critical
<polling disabled>
state:                   ok
temperature:             64 C
critical (S5):           98 C


so how can i get my automaic cooling back?
if someone just wants to point me to the right docs, I don't mind 
reading up on this stuff.

Thanks much,
brian

