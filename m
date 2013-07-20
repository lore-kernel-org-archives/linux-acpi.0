From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: udev: New default rule for autoloading kernel modules matching CPU modalias
Date: Sat, 20 Jul 2013 13:00:12 +0200
Message-ID: <59759957.oRusLgSSoH@vostro.rjw.lan>
References: <1623844.aKWlCHQqy1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62674 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753579Ab3GTKuO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Jul 2013 06:50:14 -0400
In-Reply-To: <1623844.aKWlCHQqy1@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kay Sievers <kay@vrfy.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tim Chen <tim.c.chen@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, systemd-devel@lists.freedesktop.org

On Saturday, July 20, 2013 12:56:54 PM Rafael J. Wysocki wrote:
> Hi Kay,
> 
> After a recent change present in 3.11-rc1 there is a driver, called processor,
> that can be bound to the CPU devices whose sysfs directories are located under
> /sys/devices/system/cpu/.  A side effect of this is that, after the driver has
> been bound to those devices, the kernel adds DRIVER=processor to ENV for CPU
> uevents and they don't match the default rule for autoloading modules matching
> MODALIAS:
> 
> DRIVER!="?*", ENV{MODALIAS}=="?*", IMPORT{builtin}="kmod load $env{MODALIAS}"
> 
> any more.  However, there are some modules whose module aliases match specific
> CPU features through the modalias string and those modules should be loaded
> automatically if a compatible CPU is present.  Yet, with the processor driver
> bound to the CPU devices the above rule is not sufficient for that, so we need
> a new default udev rule allowing those modules to be autoloaded even if the
> CPU devices have drivers.
> 
> On my test systems I added the following rule for that:
> 
> ACTION="add", SUBSYSTEM=="cpu", ENV{MODALIAS}=="?*", IMPORT{builtin}="kmod load $env{MODALIAS}"

That should have been:

ACTION=="add", SUBSYSTEM=="cpu", ENV{MODALIAS}=="?*", IMPORT{builtin}="kmod load $env{MODALIAS}"

sorry about the mistake.

> in a separate file, but I'm not a udev expert, so I guess it may be done in a
> better way.
> 
> Can you please consider adding such a rule to the default set of udev rules?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
