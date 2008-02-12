From: Frans Pop <elendil@planet.nl>
Subject: Re: [2.6.25-rc1] System no longer powers off after shutdown
Date: Tue, 12 Feb 2008 22:45:09 +0100
Message-ID: <200802122245.09444.elendil@planet.nl>
References: <200802111623.38478.elendil@planet.nl> <200802122139.14840.elendil@planet.nl> <20080212205622.GA21986@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml12.KPNXCHANGE.COM ([213.75.38.112]:40780 "EHLO
	hpsmtp-eml12.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750979AbYBLVpO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Feb 2008 16:45:14 -0500
In-Reply-To: <20080212205622.GA21986@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday 12 February 2008, Greg KH wrote:
> On Tue, Feb 12, 2008 at 09:39:14PM +0100, Frans Pop wrote:
> > On Monday 11 February 2008, Frans Pop wrote:
> > > In general 2.6.25 if looking quite good on my desktop, but there's
> > > one important issue: the system no longer powers off after shutdown.
> > > This works fine with 2.6.24.
> >
> > Don't ask me why, but bisection shows this commit to be the cause of
> > the failure to power off:
> > commit c10997f6575f476ff38442fa18fd4a0d80345f9d
> > Author: Greg Kroah-Hartman <gregkh@suse.de>
> > Date:   Thu Dec 20 08:13:05 2007 -0800
> >
> >     Kobject: convert drivers/* from kobject_unregister() to
> > kobject_put()
> >
> > Because it seemed somewhat unlikely, I have double checked this by
> > doing an extra compilation for this commit and its predecessor.
>
> What is the symptom of not powering off?

Symptom is that the system shuts down normally and completely, it just does 
not power off. Here are the last messages on the console:
Will now halt.
sd 1:0:0:0: [sdb] Synchronizing SCSI cache
sd 1:0:0:0: [sdb] Stopping disk
sd 0:0:0:0: [sda] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Stopping disk
ACPI: PCI interrupt for device 0000:01:00.0 disabled
Disabling non-boot CPUs ...

> Can you press SysRq-T and see a task list running and waiting when
> things should be shut down?

The system does not respond to that anymore.

> Do you happen to have a USB storage stick plugged into the system?

Nothing. Only USB kbd/mouse.


Note that I've had this issue before with this box:
http://bugzilla.kernel.org/show_bug.cgi?id=6879

Somehow it disappeared when I pulled the extra video card that came with the 
system (no decent driver for it, so no loss). Since then the system has 
always powered off completely reliably.
This time it is a clear and reproducible regression. If we can solve this 
one we might get a better handle on #6879 too.

Cheers,
FJP
