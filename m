From: Holger Macht <hmacht@suse.de>
Subject: Re: Comments about commit 'PCI: docking station: remove dock uevents'?
Date: Mon, 13 Nov 2006 20:43:27 +0100
Message-ID: <20061113194326.GD4646@homac2>
References: <20061112140737.GA21908@homac2.suse.de> <20061113121437.GA18369@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42637 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1755237AbWKMToO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Nov 2006 14:44:14 -0500
Content-Disposition: inline
In-Reply-To: <20061113121437.GA18369@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com, fseidel@suse.de

On Mon 13. Nov - 12:14:37, Matthew Garrett wrote:
> On Sun, Nov 12, 2006 at 03:07:37PM +0100, Holger Macht wrote:
> 
> > I'm currently looking at docking station support for various
> > laptops/vendors and what can be done to get them working. At the moment,
> > userspace has to do some quirks to get support for them. For instance,
> > when docking an X60 into a docking station where a SATA DVD drive is
> > located, userland has to rescan the scsi host for the drive to show up.
> 
> Does the docking not generate a bus rescan event on the SATA bus? If it 

Maybe it does, I'll have to recheck.

> does, it's just a special case of ACPI drive hotplugging. You can't do 
> it reliably from userspace, but I think Kirsten has been looking at 
> doing it properly in the kernel.

What I'm doing at the moment (for about a week ;-) is to echo "- - -" to
/sys/class/scsi_host/host*/scan for all unoccupied hosts on a dock
event. And this works pretty good. But it's of course only a workaround if
the scsi bus generates an event.

> 
> > Additionally, currently the dock driver automatically executes the _DCK
> > method when it detects a dock/undock event. Wouldn't it be good to have
> > common sysfs interface for docking so that userland can trigger the
> > dock/undock? This way userland would also be able to do 'something before'
> > docking/undocking, such as unregistering a device, showing a poput that it
> > is now save to physically undock, etc.

With recent kernel I have to unregister from the drive from userspace to
prevent confusion about if the drive is still there or not.

> When the dock contains a drive, I think there's possibly an argument in 
> favour of this. Otherwise, the hardware should be able to deal with it - 
> every ACPI-based dock I've played with has had some indication to inform 
> the user that the device has disconnected.

Yes, this one has such an indicator, too. I just thought notifying
userspace could be helpful for other cases, that's why I'm asking for
comments.

Thanks,
	Holger
