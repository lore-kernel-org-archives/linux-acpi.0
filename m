From: "Alon Keren" <alon.keren@gmail.com>
Subject: ACPI's 'thermal_zone' and 'fan' on XW6200, kernel 2.6.15
Date: Thu, 25 May 2006 15:25:04 +0300
Message-ID: <92c85b0e0605250525t2c66a81aqda2c498a2b9a3786@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.199]:10055 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965130AbWEYMZE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 May 2006 08:25:04 -0400
Received: by wx-out-0102.google.com with SMTP id s6so1292299wxc
        for <linux-acpi@vger.kernel.org>; Thu, 25 May 2006 05:25:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: haizaar@gmail.com

Hi,
my machine is HP's XW6200 desktop, running LFS with a 2.6.15 kernel.
When loading acpi's 'fan' and 'thermal' modules, the dircetories
'/proc/acpi/{fan,thermal_zone}' appear, but contain nothing. No
complaints appear on 'dmesg', and other modules ('button' and
'processor') seem to behave well.
I wish to find out whether the problem is due to hardware limitations,
software limitations, or perhaps software configuration, and I'm not
sure how to go about it. I write here as I failed to come up with much
elsewhere online.

Some further information that could be helpful:
> zgrep -i acpi /proc/config.gz

# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_IBM=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_CONTAINER=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_POWERNOW_K7_ACPI=y
CONFIG_X86_POWERNOW_K8_ACPI=y
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_PNPACPI=y
# CONFIG_SERIAL_8250_ACPI is not set

Thanks,
 Alon

P.S.
Please CC me, as I'm not subscribed to this list.
