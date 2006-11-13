From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Comments about commit 'PCI: docking station: remove dock uevents'?
Date: Mon, 13 Nov 2006 19:50:25 +0000
Message-ID: <20061113195025.GA23091@srcf.ucam.org>
References: <20061112140737.GA21908@homac2.suse.de> <20061113121437.GA18369@srcf.ucam.org> <20061113194326.GD4646@homac2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:30850 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1755245AbWKMTuc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Nov 2006 14:50:32 -0500
Content-Disposition: inline
In-Reply-To: <20061113194326.GD4646@homac2>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com, fseidel@suse.de

On Mon, Nov 13, 2006 at 08:43:27PM +0100, Holger Macht wrote:

> What I'm doing at the moment (for about a week ;-) is to echo "- - -" to
> /sys/class/scsi_host/host*/scan for all unoccupied hosts on a dock
> event. And this works pretty good. But it's of course only a workaround if
> the scsi bus generates an event.

That's just about workable for adding a device, but it loses badly for 
removing one.

> With recent kernel I have to unregister from the drive from userspace to
> prevent confusion about if the drive is still there or not.

Right. And that doesn't help in the case where the user undocks without 
waiting for everything to stop flashing first. Of course, in that case 
it's probably reasonable to tell the user that they lose, but we can do 
better than leaving a random drive lying around and a partially wedged 
sata bus...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
