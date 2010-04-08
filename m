From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: commit 9630bdd9 changes behavior of the poweroff - bug?
Date: Thu, 8 Apr 2010 22:43:18 +0200
Message-ID: <201004082243.18393.rjw@sisk.pl>
References: <20100401133923.GA4104@tiehlicka.suse.cz> <201004072149.23791.rjw@sisk.pl> <20100408094905.GA3948@tiehlicka.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41193 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758869Ab0DHUj6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Apr 2010 16:39:58 -0400
In-Reply-To: <20100408094905.GA3948@tiehlicka.suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Hocko <mhocko@suse.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Thursday 08 April 2010, Michal Hocko wrote:
> On Wed 07-04-10 21:49:23, Rafael J. Wysocki wrote:
> > On Wednesday 07 April 2010, Michal Hocko wrote:
> > > Sorry for late reply, but I was AFK during holiday.
> > > 
> > > On Fri 02-04-10 21:31:47, Rafael J. Wysocki wrote:
> > > > On Thursday 01 April 2010, Michal Hocko wrote:
> > > > > On Thu 01-04-10 14:45:35, Matthew Garrett wrote:
> > > > > > On Thu, Apr 01, 2010 at 03:39:23PM +0200, Michal Hocko wrote:
> > > > > > > Hi Rafael, Matthew,
> > > > > > > my laptop changed behavior during poweroff recently (after upgrading
> > > > > > > from .33 to .34-rc1). The system seems to be powered off (status display
> > > > > > > is off) at first glance but when I close the lid then I can hear a noise
> > > > > > > which sounds like HDD parking and when I open lid again it starts
> > > > > > > booting without poweroff button (same like when I suspend to RAM).
> > > > > > 
> > > > > > Hm. At a guess, we're somehow managing to leave the lid GPE enabled at 
> > > > > > poweroff. Can you send the output of the acpidump command?
> > > > > 
> > > > > Sure, see attached.
> > > > 
> > > > Thanks.
> > > > 
> > > > Please also send the contents of /proc/acpi/wakeup.
> > > 
> > > See attached. I have checked both kernels (with and without reverted
> > > 9630bdd) and the output looks pretty much same. 2.6.34-rc3, however,
> > > looks different a bit, so I am attaching it as well.
> > 
> > Well, I fail to see the possible failure scenario, so let's first try a blind
> > shot.
> > 
> > Please check if this patch helps:
> > https://patchwork.kernel.org/patch/86238/
> 
> No change, sorry. I have tried that on top of 0fdf867 which is not the
> most recent one (does it make sense to retest on the most recent one
> f5284e7?)

There were no other changes in that area I know of, but the current git
contains the above patch, so I'd recommend to use it for further testing.

I'll try to prepare a debug patch for this issue.

Rafael
