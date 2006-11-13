From: Holger Macht <hmacht@suse.de>
Subject: Re: Comments about commit 'PCI: docking station: remove dock uevents'?
Date: Mon, 13 Nov 2006 20:57:40 +0100
Message-ID: <20061113195740.GA6465@homac2>
References: <20061112140737.GA21908@homac2.suse.de> <20061113121437.GA18369@srcf.ucam.org> <20061113194326.GD4646@homac2> <20061113195025.GA23091@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:42437 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933052AbWKMT60 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Nov 2006 14:58:26 -0500
Content-Disposition: inline
In-Reply-To: <20061113195025.GA23091@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com, fseidel@suse.de

On Mon 13. Nov - 19:50:25, Matthew Garrett wrote:
> On Mon, Nov 13, 2006 at 08:43:27PM +0100, Holger Macht wrote:
> 
> > What I'm doing at the moment (for about a week ;-) is to echo "- - -" to
> > /sys/class/scsi_host/host*/scan for all unoccupied hosts on a dock
> > event. And this works pretty good. But it's of course only a workaround if
> > the scsi bus generates an event.
> 
> That's just about workable for adding a device, but it loses badly for 
> removing one.

On before physically removing the laptop I did an echo 1 >
/sys/.../device/delete . That's actually the reason why I need a undock
event in userspace for now.


> > With recent kernel I have to unregister from the drive from userspace to
> > prevent confusion about if the drive is still there or not.
> 
> Right. And that doesn't help in the case where the user undocks without 
> waiting for everything to stop flashing first. Of course, in that case 
> it's probably reasonable to tell the user that they lose, but we can do 
> better than leaving a random drive lying around and a partially wedged 
> sata bus...

User presses lever on dock station or presses Fn+F9 on a thinkpad
generates a undock acpi event, then I'm unregistering the device, then I
trigger the undock from userspace and at this point the indicator on the
dock station turns green so the user knows that he can remove the laptop.

Regards,
	Holger
