From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] acpi : Add container online uevent to acpi_bus_attach
Date: Thu, 11 Sep 2014 15:17:17 +0800
Message-ID: <20140911071717.GB4622@linux-rxt1.site>
References: <54095EE7.3080302@jp.fujitsu.com>
 <6346979.uGFiy3j9K2@vostro.rjw.lan>
 <540FC29B.7010808@jp.fujitsu.com>
 <3131715.Lrb4tsKR2m@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:60841 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaIKHRc (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
	Thu, 11 Sep 2014 03:17:32 -0400
Content-Disposition: inline
In-Reply-To: <3131715.Lrb4tsKR2m@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org

Hi Rafael, 

On Thu, Sep 11, 2014 at 01:38:37AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, September 10, 2014 12:16:43 PM Yasuaki Ishimatsu wrote:
> > (2014/09/08 6:34), Rafael J. Wysocki wrote:
> > > On Friday, September 05, 2014 03:57:43 PM Yasuaki Ishimatsu wrote:
> > >> Container online uevent was deleted by "46394fd01 : ACPI / hotplug:
> > >> Move container-specific code out of the core" because container-
> > >> specific uevent is raised to udev by attaching container device.
> > >> But the container-specific uevent is not useful.
> > >>
> > >> In my box, conainer device has CPU and memory devices. In this case,
> > >> when hot adding container device, the following uevets are raised to
> > >> udev.
> > >>
> > >>    # udevadm monitor --kernel
> > >>    monitor will print the received events for:
> > >>    KERNEL - the kernel uevent
> > >>
> > >>    KERNEL[...] add      /devices/system/container/ACPI0004:01 (container)
> > >>    <snip>
> > >>    KERNEL[...] add      /devices/system/memory/memory2048 (memory)
> > >>    KERNEL[...] add      /devices/system/memory/memory2049 (memory)
> > >>    <snip>
> > >>    KERNEL[...] add      /devices/system/memory/memory2063 (memory)
> > >>    <snip>
> > >>    KERNEL[...] add      /devices/system/cpu/cpu60 (cpu)
> > >>    <snip>
> > >>    KERNEL[...] add      /devices/system/cpu/cpu119 (cpu)
> > >>
> > >> When udev catches the container add uevent in my box, udev executes
> > >> user land script for onlining all child's devices. But memory and CPU
> > >> devices have not been attached at this time. So user land script fails.
> > >>
> > >> One of solutions is that user land script waits for all child's devices
> > >> to attach. But user land script has no way to know all child's devices
> > >> were attached.
> > >>
> > >> So the patch adds container online uevent to acpi_bus_sttach(). By
> > >> applying
> > >> the patch, container online uevent is raised to udev after all child's
> > >> devices were attached as follows:
> > >>
> > >>    # udevadm monitor --kernel
> > >>    monitor will print the received events for:
> > >>    KERNEL - the kernel uevent
> > >>
> > >>    KERNEL[...] add      /devices/system/container/ACPI0004:01 (container)
> > >>    <snip>
> > >>    KERNEL[...] add      /devices/system/memory/memory2048 (memory)
> > >>    KERNEL[...] add      /devices/system/memory/memory2049 (memory)
> > >>    <snip>
> > >>    KERNEL[...] add      /devices/system/memory/memory2063 (memory)
> > >>    <snip>
> > >>    KERNEL[...] add      /devices/system/cpu/cpu60 (cpu)
> > >>    <snip>
> > >>    KERNEL[...] add      /devices/system/cpu/cpu119 (cpu)
> > >>    KERNEL[...] online   /devices/system/container/ACPI0004:01 (container)
> > >>
> > >> So if user land script is executed after raising the container online
> > >> uevent, it guarantees that all child's devices were attached.
> > >
> > > I see the problem, but I don't like the patch.
> > >
> > > For example, we don't need to match the container's name again, we can use
> > > the fact that we've already matched the container scan handler to it.
> > >
> > > Does the one below work too?
> > 
> > Hi Rafael,
> > 
> > Thank you for posting your patch. I confirmed that your patch fixed my issue
> > as folloes:
> > 
> > # udevadm monitor --kernel
> > monitor will print the received events for:
> > KERNEL - the kernel uevent
> > 
> > KERNEL[...] add      /devices/system/container/ACPI0004:01 (container)
> > <snip>
> > KERNEL[...] add      /devices/system/memory/memory2048 (memory)
> > <snip>
> > KERNEL[...] add      /devices/system/memory/memory2063 (memory)
> > <snip>
> > KERNEL[...] add      /devices/system/cpu/cpu60 (cpu)
> > <snip>
> > KERNEL[...] add      /devices/system/cpu/cpu119 (cpu)
> > KERNEL[...] online   /devices/system/container/ACPI0004:01 (container)
> > 
> > So feel free to  add "Tested-by : Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>"
> > to the patch.
> 
> Thanks!
>

I just tested your new patch, it works on my side as Yasuaki's patch. 

Tested-by: Lee, Chun-Yi <jlee@suse.com>


Thanks a lot!
Joey Lee 
