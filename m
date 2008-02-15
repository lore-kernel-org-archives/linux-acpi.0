From: Greg KH <gregkh@suse.de>
Subject: Re: [2.6.25-rc1] System no longer powers off after shutdown
Date: Fri, 15 Feb 2008 13:00:08 -0800
Message-ID: <20080215210008.GD7583@suse.de>
References: <200802111623.38478.elendil@planet.nl> <200802131239.14305.elendil@planet.nl> <20080213165837.GA10129@suse.de> <200802131955.53821.rjw@sisk.pl> <20080215065952.GB8916@suse.de> <b6a2187b0802150052jcfd9c96k2a6abcd1c7fea399@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:55800 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758294AbYBOVFM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 16:05:12 -0500
Content-Disposition: inline
In-Reply-To: <b6a2187b0802150052jcfd9c96k2a6abcd1c7fea399@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Feb 15, 2008 at 04:52:18PM +0800, Jeff Chua wrote:
> On Fri, Feb 15, 2008 at 2:59 PM, Greg KH <gregkh@suse.de> wrote:
> >  I swear someone else sent this in, but my archives don't show it at all.
> >  I think the patch below should solve this, but I need someone to test it.
> 
> I tested but it doesn't fix the problem for me. May be my problem is
> different ... as my X60s just doesn't power-off on suspend-to-disk.
> 
> My .config says ...
>      # CONFIG_CPU_FREQ is not set
>      # CONFIG_CPU_IDLE is not set
> 
> 
> On Wed, Feb 13, 2008 at 3:54 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >  due to softlockup changes, and setting CONFIG_DETECT_SOFTLOCKUP=n ...
> 
> Also, I've tried CONFIG_DETECT_SOFTLOCKUP=n, but this doesn't fix it either.

Ok, this looks to be something else.

> Here's the last dmesg after suspend-to-disk and hang there...
> 
> CPU 1 is now offline
> SMP alternatives: switching to UP code
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> PM: Shrinking memory...  ^H-^Hdone (0 pages freed)
> PM: Freed 0 kbytes in 0.10 seconds (0.00 MB/s)
> ACPI: Preparing to enter system sleep state S4
> Suspending console(s)
> 
> [ ... it just hangs here ... press power-switch does the job, and
> system is able to resume upon powering on ]

Wait, this is a suspend-to-disk issue.  Totally different than the "will
not power off" issue.

Can you start a new thread on this, and add the suspend people to it?

thanks,

greg k-h
