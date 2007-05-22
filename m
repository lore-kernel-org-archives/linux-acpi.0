From: "Paa Paa" <paapaa125@hotmail.com>
Subject: Core 2 Duo and power states
Date: Tue, 22 May 2007 20:34:14 +0000
Message-ID: <BAY20-F69C884E2742B1B312C8F7F9360@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bay0-omc3-s3.bay0.hotmail.com ([65.54.246.203]:40695 "EHLO
	bay0-omc3-s3.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756523AbXEVUsY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 May 2007 16:48:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

For some reason I'm not able to enable processor power states (c1, c2 etc.)
for my Core 2 Duo. This is what I get::

cat /proc/acpi/processor/CPU1/info
processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no

cat /proc/acpi/processor/CPU1/power
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000 usec
states:

"dmesg | grep -i power" also gives nothing. I have ACPI enabled in BIOS and
in kernel I have these set ("grep -i acpi .config | grep =y"):

CONFIG_ACPI=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_PNPACPI=y
CONFIG_SATA_ACPI=y

I'm probably missing something crucial here. So how do I enable power
states or how do I debug the cause of them missing?

Kernel: 2.6.21.1
CPU: Intel E6400
Mobo: Asus P5B Deluxe (latest BIOS)
Distro: 64-bit Gentoo
I have EIST and ACPI2 enabled in BIOS.

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar - get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/

