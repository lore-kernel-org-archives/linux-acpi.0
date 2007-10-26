From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [2.624-rc1 regression] lost battery information
Date: Fri, 26 Oct 2007 22:12:03 +0400
Message-ID: <47222DF3.3040208@gmail.com>
References: <200710262024.06012.arvidjaar@mail.ru> <47221C67.9050502@gmail.com> <200710262120.22536.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:39327 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbXJZSMV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Oct 2007 14:12:21 -0400
Received: by ug-out-1314.google.com with SMTP id z38so724357ugc
        for <linux-acpi@vger.kernel.org>; Fri, 26 Oct 2007 11:12:20 -0700 (PDT)
In-Reply-To: <200710262120.22536.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
> On Friday 26 October 2007, Alexey Starikovskiy wrote:
>> Andrey Borzenkov wrote:
>>> I have lost battery in 2.6.24-rc1. Without CONFIG_ACPI_PROCFS I have
>>> no /proc/acpi/battery and cannot test netlink interface because right now
>>> there is no consumer of this.
>> for /sysfs interface you need to enable power_supply driver.
>> or you could apply this patch and power_supply will be selected by battery
>> itself.
>>
> 
> I already have power_supply module, battery depends on it and it is autloaded. 
> But I fail to see where I can get battery info in /sys
Intent was to put into /sysfs same information:
aystarik@samsung:~/client_conf$ ls /sys/class/power_supply/BAT1/
alarm  charge_full  charge_full_design  charge_now  current_now  device  manufacturer  model_name  present  status  subsystem  technology  type  uevent  voltage_min_design  voltage_now

aystarik@samsung:~/client_conf$ cat /sys/class/power_supply/BAT1/*
0
4172000
4300000
4172000
0
cat: /sys/class/power_supply/BAT1/device: Is a directory
Pacifi
Bat1
1
Full
cat: /sys/class/power_supply/BAT1/subsystem: Is a directory
Li-ion
Battery
PHYSDEVPATH=/devices/LNXSYSTM:00/device:00/PNP0C0A:00
PHYSDEVBUS=acpi
PHYSDEVDRIVER=battery
POWER_SUPPLY_NAME=BAT1
POWER_SUPPLY_TYPE=Battery
POWER_SUPPLY_STATUS=Full
POWER_SUPPLY_PRESENT=1
POWER_SUPPLY_TECHNOLOGY=Li-ion
POWER_SUPPLY_VOLTAGE_MIN_DESIGN=14800000
POWER_SUPPLY_VOLTAGE_NOW=16522000
POWER_SUPPLY_CURRENT_NOW=0
POWER_SUPPLY_CHARGE_FULL_DESIGN=4300000
POWER_SUPPLY_CHARGE_FULL=4172000
POWER_SUPPLY_CHARGE_NOW=4172000
POWER_SUPPLY_MODEL_NAME=Bat1
POWER_SUPPLY_MANUFACTURER=Pacifi
14800000
16522000

aystarik@samsung:~/client_conf$ cat /proc/acpi/battery/BAT1/*
alarm:                   unsupported
present:                 yes
design capacity:         4300 mAh
last full capacity:      4172 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 208 mAh
design capacity low:     41 mAh
capacity granularity 1:  41 mAh
capacity granularity 2:  41 mAh
model number:            Bat1
serial number:           001
battery type:            LION
OEM info:                Pacifi
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mA
remaining capacity:      4172 mAh
present voltage:         16518 mV
