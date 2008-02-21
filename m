From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [Suspend-devel] 2.6.25-rc2 System no longer powers off after suspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 10:34:21 -0800
Message-ID: <200802211034.22056.jesse.barnes@intel.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com> <b6a2187b0802201800n12f90b22x8cb0c2ad6e0c402@mail.gmail.com> <200802211727.21593.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:54110 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589AbYBUSse (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Feb 2008 13:48:34 -0500
In-Reply-To: <200802211727.21593.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>

On Thursday, February 21, 2008 8:27 am Rafael J. Wysocki wrote:
> On Thursday, 21 of February 2008, Jeff Chua wrote:
> > On Thu, Feb 21, 2008 at 8:39 AM, Jesse Barnes <jesse.barnes@intel.com> 
wrote:
> > > On Wednesday, February 20, 2008 4:35 pm Jeff Chua wrote:
> > >  > On Thu, Feb 21, 2008 at 5:37 AM, Jesse Barnes
> > >  > <jesse.barnes@intel.com>
> > >
> > >  wrote:
> > >  > >  Ok, can you give this patch a try with the 'platform' method?  It
> > >  > > should at least tell us what ACPI would like the device to do at
> > >  > > suspend time, but it probably won't fix the hang.
> >
> > It says "calling pci_set_power_state with 3". Then after all then it
> > still hangs, and then resume with Mr Green.
> >
> > PM: Syncing filesystems ... done.
> > Freezing user space processes ... (elapsed 0.00 seconds) done.
> > Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> > PM: Shrinking memory...  ^H-^Hdone (0 pages freed)
> > PM: Freed 0 kbytes in 0.20 seconds (0.00 MB/s)
> > ACPI: Preparing to enter system sleep state S4
> > Suspending console(s)
> > sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > drm_sysfs_suspend
> > ACPI: PCI interrupt for device 0000:00:02.0 disabled
> > calling pci_set_power_state with 3
>
> So it returns the right value.
>
> Jeff, Jesse, please check one thing for me.
>
> Please boot 2.6.25-rc2 (or better, the current head of the Linus' tree)
> with no_console_suspend and try to do the following:
>
> # echo 8 > /proc/sys/kernel/printk
> # echo core > /sys/power/pm_test
> # echo disk > /sys/power/state
>
> (that will run a test of the freeze/unfreeze code without creating the
> image) and then

That comes back for me, without creating the green screen.  There's a long 
delay between it saying "entering S4" and actually resuming back to my 
console though.

> # echo mem > /sys/power/state
>
> (that will run a test of the suspend/resume code without actually
> suspending).
>
> I'd like to know if that works.

This also works (after doing the echo disk > ...) above.  There's still a 
delay between "entering S3" and the resume to my console though.

Jesse
