From: Robin Holt <holt@sgi.com>
Subject: Sony laptop battery has odd behavior with 2.6.26-rc3ish build.
Date: Wed, 21 May 2008 06:57:24 -0500
Message-ID: <20080521115723.GF4287@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.171.30]:50854 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755334AbYEUL5Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 May 2008 07:57:25 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: astarikovskiy@suse.de, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


A couple days ago, I updated my test build to commit
8033c6e9736c29cce5f0d0abbca9a44dffb20c39 and noticed an odd behavior
with the battery.  If I unplug the power, the battery discharges and
that is reflected in /proc/acpi/battery/BAT0/state.  I am not certain
the discharge is continuous and uniform or if it goes in steps.  When I
plug the power back in, the level stays at a constant value (+-1mAh)
for a considerable period of time.  It then does a single step back to
the fully charged value.

I have not done any searching to see when this began.  I had been running
the ubuntu 2.6.22-14 kernel before this and the behavior was normal.

I am not certain what information you will need.  Commit is above.

$ cat /proc/acpi/battery/BAT0/alarm
alarm:                   unsupported
$ cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         4800 mAh
last full capacity:      4096 mAh
battery technology:      non-rechargeable
design voltage:          12588 mV
design capacity warning: 1000 mAh
design capacity low:     400 mAh
capacity granularity 1:  100 mAh
capacity granularity 2:  100 mAh
model number:            
serial number:           
battery type:            LiOn
OEM info:                Sony Corp.
$ cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          charging
present rate:            unknown
remaining capacity:      4096 mAh
present voltage:         unknown

What I think is relevant .config information:
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_PROCFS=y
CONFIG_ACPI_PROCFS_POWER=y
CONFIG_ACPI_SYSFS_POWER=y
CONFIG_ACPI_PROC_EVENT=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_DOCK=m
CONFIG_ACPI_BAY=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_WMI=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=2000
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_CONTAINER=m
CONFIG_ACPI_SBS=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_POWERNOW_K7_ACPI=y
CONFIG_X86_POWERNOW_K8_ACPI=y
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_PNPACPI=y
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUG is not set
CONFIG_THINKPAD_ACPI_BAY=y
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_BLK_DEV_IDEACPI=y
CONFIG_ATA_ACPI=y
CONFIG_PATA_ACPI=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_SONYPI=m

Thanks,
Robin Holt
