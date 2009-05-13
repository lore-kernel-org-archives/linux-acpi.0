From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC] why do we need run disk sync before entering S3
Date: Wed, 13 May 2009 10:53:38 +0200
Message-ID: <200905131053.39271.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0905122155550.7989-100000@netrider.rowland.org> <200905131003.15199.rjw@sisk.pl> <20090513084555.GA27261@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45930 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312AbZEMIx4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 May 2009 04:53:56 -0400
In-Reply-To: <20090513084555.GA27261@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wednesday 13 May 2009, Pavel Machek wrote:
> On Wed 2009-05-13 10:03:14, Rafael J. Wysocki wrote:
> > On Wednesday 13 May 2009, Alan Stern wrote:
> > > On Wed, 13 May 2009, Zhang Rui wrote:
> > > 
> > > > Hi, all,
> > > > 
> > > > I did some S3 tests on an eeepc901, the total suspend time(from issue
> > > > the suspend command to power down) is about 2.5s~3s.
> > > > something interesting is that kernel runs disk sync before entering S3
> > > > state, and this takes about 0.7~1.2s.
> > > > my question is that, why do we need this for s2ram?
> > > > can we remove this and run sys_sync for S4 only?
> > > 
> > > At the risk of sounding foolish, I'd guess that a system in S3 (or more
> > > generally, suspend-to-RAM) is a lot more at risk of losing power or
> > > failing to restore than a normally running system.  (A normally running
> > > system is trivially not at risk of failing to restore!)  Consequently
> > > it makes sense to flush the I/O buffers before entering this state, to
> > > minimize the potential for loss of data.
> > > 
> > > When you think about it, a system in S4 is actually _less_ likely to 
> > > run into trouble than one in S3, since it can't fail because of loss of 
> > > power.  So if anything, we should remove the disk sync from hibernation 
> > > and leave it in system suspend.
> > 
> > I generally agree, but I think we may also leave the syncing to the user space,
> > in both cases.
> 
> Well...
> 
> Normally kernel writes dirty data to disk each 30
> seconds. s2ram/s2disk breaks that promise, so it seems fair to add
> explicit sync to keep the "promise".
> 
> OTOH, I agree it would be more flexible if we left sync to
> userspace. In uswsusp case, it actually makes sense. In s2ram
> case... if we can do it while keeping compatibility with old
> behaviour... why not.

That really depends on the distrubution.  (open)SUSE always syncs before
suspend/hibernation AFAICS, but I don't know about the other distros.

Thanks,
Rafael
