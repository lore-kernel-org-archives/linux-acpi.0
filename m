From: Dan <vxltage@gmail.com>
Subject: PROBLEM: Acer D255E Backlight out for 10 seconds with ACPI
Date: Wed, 26 Sep 2012 16:48:53 -0400
Message-ID: <CALKZjMKcCA68XLWADb+EmU+a3VTQuOGr1dqNywGCCMj8DWNsiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41961 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab2IZUsz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Sep 2012 16:48:55 -0400
Received: by bkcjk13 with SMTP id jk13so629732bkc.19
        for <linux-acpi@vger.kernel.org>; Wed, 26 Sep 2012 13:48:54 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

Apologies if this was sent to the wrong place.

With an Acer AOD255E netbook, the backlight goes out for exactly 10
seconds before returning while booting.

This is a backlight issue and not KMS, as I can shine a flashlight at
the screen and still see boot text scrolling.

With "acpi=off" appended to the kernel line, this no longer occurs (Fn
key backlight controls still work with this appended). With every
other acpi option I have tried, this still occurs though. This
includes "acpi_backlight" and "acpi_display_output". With
"acpi_backlight=vendor" the entry in /sys/class/backlight changes from
acpi_video0 to acer_wmi, but backlight still goes out.

Otherwise backlight works correctly.

Kernel version (I have reproduced it with several other older kernels
as well on different distributions):
Linux version 3.5.4-1-ARCH (tobias@T-POWA-LX) (gcc version 4.7.1
20120721 (prerelease) (GCC) ) #1 SMP PREEMPT Sat Sep 15 08:12:04 CEST
2012

I compiled the system information from /proc and lspci here (You can
also find a dmesg comparision between a regular boot and one with acpi
disabled here):
http://pastebin.com/u/vxl

I'll also point you to the Ubuntu bug report I filed awhile back while
using that. It contains information on the exact same system (running
Ubuntu rather than Arch Linux):
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1034222

Thanks for your time.
