From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: Multiple video backlight devices on Dell laptop
Date: Tue, 14 Jan 2014 10:49:40 +0800
Message-ID: <52D4A5C4.5000405@intel.com>
References: <CAJrk0Bv5w25vipp8vTmoZEegb-7Va+FLvek=QnTvSfHDFjvroA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40229 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbaANCtX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Jan 2014 21:49:23 -0500
In-Reply-To: <CAJrk0Bv5w25vipp8vTmoZEegb-7Va+FLvek=QnTvSfHDFjvroA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bradley Baetz <bbaetz@gmail.com>, linux-acpi@vger.kernel.org

On 01/11/2014 11:22 AM, Bradley Baetz wrote:
> Hi,
> 
> I have a Dell Vostro 3560 laptop, with hybrid graphics (intel + radeon).
> 
> This exposes 3 backlight devices - acpi_video0, acpi_video1, and
> intel_backlight. Only the intel_backlight/brightness file actually
> changes the backlight. Is this a kernel bug, or should userspace
> 'know' which backlight file to use based on which graphics device is
> active? XFCE picks the first one it finds (acpi_video0), which doesn't
> work.

Solving it from userspace:
You can specify which backlight interface to use by editing /etc/xorg.conf:
 Section "Device"
    Identifier  "Intel Graphics"
    Driver      "intel"
    Option      "AccelMethod"     "sna"
    Option      "Backlight"       "intel_backlight" # use your backlight that works here
    Driver      "intel"
    BusID       "PCI:0:2:0"
 EndSection

See https://wiki.archlinux.org/index.php/Backlight

solving it from kernel space:
Since the firmware claims support of win8, you can forget the
acpi_backlight=vendor cmdline option and just use video.use_native_backlight=1.

Hope it helps.
-Aaron
