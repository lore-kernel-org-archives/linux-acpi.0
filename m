From: Johan Lans <apansson@apspektakel.com>
Subject: acpid: can't open /proc/acpi/event: No such file or directory
Date: Mon, 14 Jan 2008 13:28:05 +0100
Message-ID: <478B5555.4060904@apspektakel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:46794 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750895AbYANM2L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jan 2008 07:28:11 -0500
Received: from c80-217-107-53.bredband.comhem.se ([80.217.107.53]:1307 helo=[192.168.2.103])
	by ch-smtp01.sth.basefarm.net with esmtp (Exim 4.68)
	(envelope-from <apansson@apspektakel.com>)
	id 1JEOQE-00023j-4E
	for linux-acpi@vger.kernel.org; Mon, 14 Jan 2008 13:28:10 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi
I'm trying to set up ACPI, on my gentoo system, so that I can use the 
power button to hibernate the system. I compiled the kernel (2.6.23) 
with the folowing ACPI options:

# Power management options (ACPI, APM)
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_PROCFS=y
CONFIG_ACPI_PROC_EVENT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_DEBUG_FUNC_TRACE is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_SBS is not set
CONFIG_PNPACPI=y
# CONFIG_THINKPAD_ACPI is not set
CONFIG_BLK_DEV_IDEACPI=y
CONFIG_ATA_ACPI=y

I've emerged ACPI and ACPID.
Now, when I boot into this kernel and try to start ACPID, I get this:

ellen linux # /etc/init.d/acpid start
 * Service acpid starting
acpid: can't open /proc/acpi/event: No such file or directory            
                                                                        
       [ !! ]
 * ERROR:  acpid failed to start

Any ideas? I thought the CONFIG_ACPI_PROC_EVENT=y option would fix this.

I don't know much about ACPI, but the dmesg gives a lot of output on 
acpi during boot, and there seems to be no error in that, so I think 
acpi is activated like it should. I can post that output too if it helps.

thanks for any help
/Johan
