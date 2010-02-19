From: lsz <oldherl@gmail.com>
Subject: ACPI Bug report: strange behavior of temperature on Intel Core
	i5-430M CPU
Date: Fri, 19 Feb 2010 20:44:30 +0800
Message-ID: <f7f930f1002190444u3649a9afhce768f6f57392f49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:56317 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab0BSMpA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 07:45:00 -0500
Received: by bwz1 with SMTP id 1so17066bwz.21
        for <linux-acpi@vger.kernel.org>; Fri, 19 Feb 2010 04:44:58 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello ACPI developers,
The ACPI temperature on my Dell laptop (Intel Core i5-430M CPU) is strange.
You can not see the temperature unless you perform a "suspend to ram" operation.
This is what it shows if it is just booted (i.e. not performed any suspending).

$ cat /sys/class/thermal/thermal_zone0/temp
26800
$ cat /sys/class/thermal/thermal_zone1/temp
0

And they never change, until you perform a "suspend to ram"
(pm-suspend) operation.
After suspending and recovering, it turns to:

$ cat /sys/class/thermal/thermal_zone0/temp
26800
$ cat /sys/class/thermal/thermal_zone1/temp
51000

And the value of zone1 keep changes every several seconds, which I
think is the right temperature (51C).
But I don't know what's zone0 about.
Please fix it so that:
  1 remove useless zone0, or tell what's that about.
  2 make zone1 usable before suspending.

Thanks.

My OS is Arch Linux x86_64 (regularly updated). Here are the version
numbers of some packages:
local/acpi 1.4-2
    Linux ACPI client providing battery, AC power, and thermal readings
local/acpid 1.0.10-3
    A daemon for delivering ACPI power management events
local/acpitool 0.5.1-1
    ACPI client - replacement for apm tool
local/pmtools 20071116-1
    A small collection of ACPI power management test and investigation tools
local/kernel26 2.6.32.8-1 (base)
    The Linux Kernel and modules
local/kernel26-firmware 2.6.32.8-1 (base)
    The included firmware files of the Linux Kernel
local/kernel26-headers 2.6.32.8-1
    Header files and scripts for building modules for kernel26
local/linux-api-headers 2.6.32.5-2 (base)
    Kernel headers sanitized for use in userspace

Sizhuang Liu
