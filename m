From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: Comments about commit 'PCI: docking station: remove dock
 uevents'?
Date: Mon, 13 Nov 2006 12:18:33 -0800
Message-ID: <20061113121833.12c4d1fd.kristen.c.accardi@intel.com>
References: <20061112140737.GA21908@homac2.suse.de>
	<20061113121437.GA18369@srcf.ucam.org>
	<20061113194326.GD4646@homac2>
	<20061113195025.GA23091@srcf.ucam.org>
	<20061113195740.GA6465@homac2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:57723 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1755255AbWKMUSs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Nov 2006 15:18:48 -0500
In-Reply-To: <20061113195740.GA6465@homac2>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Holger Macht <hmacht@suse.de>, brandon@ifup.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, fseidel@suse.de

On Mon, 13 Nov 2006 20:57:40 +0100
Holger Macht <hmacht@suse.de> wrote:

> On Mon 13. Nov - 19:50:25, Matthew Garrett wrote:
> > On Mon, Nov 13, 2006 at 08:43:27PM +0100, Holger Macht wrote:
> > 
> > > What I'm doing at the moment (for about a week ;-) is to echo "- - -" to
> > > /sys/class/scsi_host/host*/scan for all unoccupied hosts on a dock
> > > event. And this works pretty good. But it's of course only a workaround if
> > > the scsi bus generates an event.
> > 
> > That's just about workable for adding a device, but it loses badly for 
> > removing one.
> 
> On before physically removing the laptop I did an echo 1 >
> /sys/.../device/delete . That's actually the reason why I need a undock
> event in userspace for now.
> 
> 
> > > With recent kernel I have to unregister from the drive from userspace to
> > > prevent confusion about if the drive is still there or not.
> > 
> > Right. And that doesn't help in the case where the user undocks without 
> > waiting for everything to stop flashing first. Of course, in that case 
> > it's probably reasonable to tell the user that they lose, but we can do 
> > better than leaving a random drive lying around and a partially wedged 
> > sata bus...
> 
> User presses lever on dock station or presses Fn+F9 on a thinkpad
> generates a undock acpi event, then I'm unregistering the device, then I
> trigger the undock from userspace and at this point the indicator on the
> dock station turns green so the user knows that he can remove the laptop.
> 
> Regards,
> 	Holger

Brandon is working on adding a sysfs interface to the dock driver right
now.  We have so far only added a read only parameter that will display
the dock status, however, it is possible to add a sysfs entry that would
allow the user to undock by writing to it.  

Brandon, can you add this to your sysfs patch?

Thanks,
Kristen
