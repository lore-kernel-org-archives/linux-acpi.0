From: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Subject: RE: ACPI's 'thermal_zone' and 'fan' on XW6200, kernel 2.6.15
Date: Mon, 29 May 2006 16:42:54 +0400
Message-ID: <E124AAE027DA384D8B919F93E4D8C70801F3FB68@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52256 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750779AbWE2Mm5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 May 2006 08:42:57 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

>My question now is: what's my next step, if any? Am I strictly at the
>mercy of the vendor - HP - or is there something that could be done?

Not sure. Actually, you need to know how to get the temperature to
define 'ThermalZone' object and how to control the fan to define fan
device for active cooling. But I don't know how to find out whether
these features are available or not.

Regards.
Konstantin.

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Alon Keren
>Sent: Sunday, May 28, 2006 3:18 PM
>To: linux-acpi@vger.kernel.org
>Cc: haizaar@gmail.com
>Subject: Re: ACPI's 'thermal_zone' and 'fan' on XW6200, kernel 2.6.15
>
>(Please CC me any replies, since I'm not subscribed to this list)
>
>> Hi,
>>
>> >When loading acpi's 'fan' and 'thermal' modules, the dircetories
>> >'/proc/acpi/{fan,thermal_zone}' appear, but contain nothing. No
>>
>> It looks like fan and thermal not present in DSDT on your system.
>> To make sure you should check for '_TZ' (thermal zone definition) and
>> 'PNP0C0B' (fan device h/w ID) entries in your DSDT.
>> Look here for reference: http://acpi.sourceforge.net/dsdt/index.php
>>
>> Regards.
>> Konstantin.
>
>Thanks. Indeed, neither '_TZ' nor 'PNP0C0B' were present in the
>decompiled DSDT. I upgraded my BIOS to the latest version but nothing
>changed in those departments.
>My question now is: what's my next step, if any? Am I strictly at the
>mercy of the vendor - HP - or is there something that could be done?
>
>Alon
>
>
>On 5/25/06, Alon Keren <alon.keren@gmail.com> wrote:
>> Hi,
>> my machine is HP's XW6200 desktop, running LFS with a 2.6.15 kernel.
>> When loading acpi's 'fan' and 'thermal' modules, the dircetories
>> '/proc/acpi/{fan,thermal_zone}' appear, but contain nothing. No
>> complaints appear on 'dmesg', and other modules ('button' and
>> 'processor') seem to behave well.
>> I wish to find out whether the problem is due to hardware
limitations,
>> software limitations, or perhaps software configuration, and I'm not
>> sure how to go about it. I write here as I failed to come up with
much
>> elsewhere online.
>>
>> Some further information that could be helpful:
>> > zgrep -i acpi /proc/config.gz
>>
>> # Power management options (ACPI, APM)
>> # ACPI (Advanced Configuration and Power Interface) Support
>> CONFIG_ACPI=y
>> CONFIG_ACPI_SLEEP=y
>> CONFIG_ACPI_SLEEP_PROC_FS=y
>> # CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
>> CONFIG_ACPI_AC=m
>> CONFIG_ACPI_BATTERY=m
>> CONFIG_ACPI_BUTTON=m
>> CONFIG_ACPI_VIDEO=m
>> CONFIG_ACPI_HOTKEY=m
>> CONFIG_ACPI_FAN=m
>> CONFIG_ACPI_PROCESSOR=m
>> CONFIG_ACPI_HOTPLUG_CPU=y
>> CONFIG_ACPI_THERMAL=m
>> CONFIG_ACPI_ASUS=m
>> CONFIG_ACPI_IBM=m
>> CONFIG_ACPI_TOSHIBA=m
>> CONFIG_ACPI_BLACKLIST_YEAR=0
>> CONFIG_ACPI_DEBUG=y
>> CONFIG_ACPI_EC=y
>> CONFIG_ACPI_POWER=y
>> CONFIG_ACPI_SYSTEM=y
>> CONFIG_ACPI_CONTAINER=m
>> CONFIG_X86_ACPI_CPUFREQ=m
>> CONFIG_X86_POWERNOW_K7_ACPI=y
>> CONFIG_X86_POWERNOW_K8_ACPI=y
>> CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
>> # CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
>> CONFIG_HOTPLUG_PCI_ACPI=m
>> CONFIG_HOTPLUG_PCI_ACPI_IBM=m
>> CONFIG_PNPACPI=y
>> # CONFIG_SERIAL_8250_ACPI is not set
>>
>> Thanks,
>>  Alon
>>
>> P.S.
>> Please CC me, as I'm not subscribed to this list.
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
