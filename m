From: Jonathan Nicklin <jnicklin@blockbridge.com>
Subject: Unable to use iTCO watchdog on Broadwell SOC:
Date: Wed, 16 Nov 2016 11:08:54 -0500
Message-ID: <CAHex0coy_mgDHi8N7UbAsWP5XLWhTAMK+JRkF1KMj7w=y5sbpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34813 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbcKPQJl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2016 11:09:41 -0500
Received: by mail-wm0-f46.google.com with SMTP id u144so33745711wmu.1
        for <linux-acpi@vger.kernel.org>; Wed, 16 Nov 2016 08:09:40 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi Everyone,

We have a number of systems that fail to initialize the iTCO watchdog
with =E2=80=9Cunable to reset NO_REBOOT flag, device disabled by
hardware/BIOS=E2=80=9D. The systems include Broadwell SOC, Haswell w/ C222,
and Ivy Bridge w/ C600/X79. These systems have different BIOS
vendors/versions. We have tested with a few different kernel versions
as recent as 4.4. We have only managed successfully configure the iTCO
watchdog on a Haswell w/ C610/X99 system.

Has anyone successfully used the iTCO watchdog on a Broadwell
Xeon-D/SOC system? Can anyone provide advice on how to debug this
issue?

Thanks,
-Jonathan

# uname -a
Linux soc 4.4.23-1.el7.elrepo.x86_64 #1 SMP Fri Sep 30 09:11:50 EDT
2016 x86_64 x86_64 x86_64 GNU/Linux

# dmesg | grep iTCO
[   18.544987] iTCO_vendor_support: vendor-support=3D0
[   18.549213] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   18.549245] iTCO_wdt: unable to reset NO_REBOOT flag, device
disabled by hardware/BIOS

# find /sys/devices | grep iTCO
/sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto
/sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/power
/sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/power/control
/sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/power/runtime_active_t=
ime
/sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/power/autosuspend_dela=
y_ms
/sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/power/runtime_status
/sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/power/runtime_suspende=
d_time
/sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/driver_override
/sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/modalias
/sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/subsystem
/sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/uevent
/sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/firmware_node
