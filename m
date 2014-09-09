From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi : Add container online uevent to acpi_bus_attach
Date: Tue, 09 Sep 2014 15:55:28 +0200
Message-ID: <2241473.9T8TmxONEN@vostro.rjw.lan>
References: <54095EE7.3080302@jp.fujitsu.com> <20140905121413.GG2225@linux-rxt1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56442 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756551AbaIINgB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2014 09:36:01 -0400
In-Reply-To: <20140905121413.GG2225@linux-rxt1.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org

On Friday, September 05, 2014 08:14:13 PM joeyli wrote:
> Hi Yasuaki, 
> 
> On Fri, Sep 05, 2014 at 03:57:43PM +0900, Yasuaki Ishimatsu wrote:
> > Container online uevent was deleted by "46394fd01 : ACPI / hotplug:
> > Move container-specific code out of the core" because container-
> > specific uevent is raised to udev by attaching container device.
> > But the container-specific uevent is not useful.
> > 
> > In my box, conainer device has CPU and memory devices. In this case,
> > when hot adding container device, the following uevets are raised to
> > udev.
> > 
> >   # udevadm monitor --kernel
> >   monitor will print the received events for:
> >   KERNEL - the kernel uevent
> > 
> >   KERNEL[...] add      /devices/system/container/ACPI0004:01 (container)
> >   <snip>
> >   KERNEL[...] add      /devices/system/memory/memory2048 (memory)
> >   KERNEL[...] add      /devices/system/memory/memory2049 (memory)
> >   <snip>
> >   KERNEL[...] add      /devices/system/memory/memory2063 (memory)
> >   <snip>
> >   KERNEL[...] add      /devices/system/cpu/cpu60 (cpu)
> >   <snip>
> >   KERNEL[...] add      /devices/system/cpu/cpu119 (cpu)
> > 
> > When udev catches the container add uevent in my box, udev executes
> > user land script for onlining all child's devices. But memory and CPU
> > devices have not been attached at this time. So user land script fails.
> > 
> > One of solutions is that user land script waits for all child's devices
> > to attach. But user land script has no way to know all child's devices
> > were attached.
> > 
> > So the patch adds container online uevent to acpi_bus_sttach(). By
> > applying
> > the patch, container online uevent is raised to udev after all child's
> > devices were attached as follows:
> > 
> >   # udevadm monitor --kernel
> >   monitor will print the received events for:
> >   KERNEL - the kernel uevent
> > 
> >   KERNEL[...] add      /devices/system/container/ACPI0004:01 (container)
> >   <snip>
> >   KERNEL[...] add      /devices/system/memory/memory2048 (memory)
> >   KERNEL[...] add      /devices/system/memory/memory2049 (memory)
> >   <snip>
> >   KERNEL[...] add      /devices/system/memory/memory2063 (memory)
> >   <snip>
> >   KERNEL[...] add      /devices/system/cpu/cpu60 (cpu)
> >   <snip>
> >   KERNEL[...] add      /devices/system/cpu/cpu119 (cpu)
> >   KERNEL[...] online   /devices/system/container/ACPI0004:01 (container)
> > 
> > So if user land script is executed after raising the container online
> > uevent, it guarantees that all child's devices were attached.
> > 
> > Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> 
> Your patch works on my side.
> 
> Tested-by: Lee, Chun-Yi <jlee@suse.com>

Can you please try this one too: https://patchwork.kernel.org/patch/4859321/

