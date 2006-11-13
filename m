From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: Comments about commit 'PCI: docking station: remove dock
 uevents'?
Date: Mon, 13 Nov 2006 11:54:23 -0800
Message-ID: <20061113115423.f84adb22.kristen.c.accardi@intel.com>
References: <20061112140737.GA21908@homac2.suse.de>
	<20061113121437.GA18369@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:176 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S933044AbWKMTyg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Nov 2006 14:54:36 -0500
In-Reply-To: <20061113121437.GA18369@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, fseidel@suse.de

On Mon, 13 Nov 2006 12:14:37 +0000
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Sun, Nov 12, 2006 at 03:07:37PM +0100, Holger Macht wrote:
> 
> > I'm currently looking at docking station support for various
> > laptops/vendors and what can be done to get them working. At the moment,
> > userspace has to do some quirks to get support for them. For instance,
> > when docking an X60 into a docking station where a SATA DVD drive is
> > located, userland has to rescan the scsi host for the drive to show up.
> 
> Does the docking not generate a bus rescan event on the SATA bus? If it 
> does, it's just a special case of ACPI drive hotplugging. You can't do 
> it reliably from userspace, but I think Kirsten has been looking at 
> doing it properly in the kernel.

When you use the "bay" driver in addition to the "dock" driver (bay is 
in -mm right now) you would get a notification on dock/undock in the driver
which would then cause the bay driver to notify user space about the 
drive event.  I've not found any other devices that require user space
notification.

> 
> > Additionally, currently the dock driver automatically executes the _DCK
> > method when it detects a dock/undock event. Wouldn't it be good to have
> > common sysfs interface for docking so that userland can trigger the
> > dock/undock? This way userland would also be able to do 'something before'
> > docking/undocking, such as unregistering a device, showing a poput that it
> > is now save to physically undock, etc.
> 
> When the dock contains a drive, I think there's possibly an argument in 
> favour of this. Otherwise, the hardware should be able to deal with it - 
> every ACPI-based dock I've played with has had some indication to inform 
> the user that the device has disconnected.

I think there is an arguement in favor of this, but there are more arguments
in favor of not waiting for user space before executing the acpi _DCK to
undock - mainly because not all dock stations actually lock the laptop
in the dock, and so the user is going to just do it anyway.  by undocking
as soon as we get the hardware notification, we can at least clean up
after this activity.  Also, most people who have commented on my bay driver
(which does assume user space handles the actual eject) have complained
about the fact that I wait for user space.  they general feedback I've gotten
is that these activities should "just happen" and not require user intervention.


> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org
