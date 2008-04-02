From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Suspend and hibernation patchset against -rc8
Date: Wed, 2 Apr 2008 02:27:11 +0200
Message-ID: <200804020227.12943.rjw@sisk.pl>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl> <200803270051.31778.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49391 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516AbYDBA1P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Apr 2008 20:27:15 -0400
In-Reply-To: <200803270051.31778.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shaohua Li <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>

On Thursday, 27 of March 2008, Rafael J. Wysocki wrote:
> On Monday, 17 of March 2008, Rafael J. Wysocki wrote:
> > On Wednesday, 12 of March 2008, Rafael J. Wysocki wrote:
> > >
> > > For everyone interested, I have put together a patchset containing some "fresh"
> > > patches related to suspend and hibernation, on top of 2.6.25-rc5, located at:
> > > 
> > > http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.25-rc5/patches/
> > 
> > There's a new patchset against 2.6.25-rc6 at:
> > 
> > http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.25-rc6/patches/
> 
> There's a new patchset against 2.6.25-rc7 at:
> 
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.25-rc7/patches/

There's a new patchset against 2.6.25-rc8 at:
 
http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.25-rc8/patches/

It contains some changes with respect to the previous one.  Most importantly,
dropped ACPI-force-acpi_new_pts_ordering-for-ASUS-A6VC-laptop.patch (not needed
any more) and added patch 14, which is experimental.

I still have not decided what to do with patches 01-03.  Patch 03 will probably
be sent upstream soon, as well as patches 12 and 14.
 
Patch 04 is currently in the "test" branch of the ACPI tree and has been
tested already for some time in -mm and linux-next.
 
Patches 05-11 are in the Greg's tree and have been tested in -mm and
linux-next.
 
Patch 13 is in -mm.

Patches 15-17 are the 4th revision of the patches to introduce new suspend and
hibernation callbacks for drivers.

The series has been compiled and (lightly) tested on HP nx6325 (64-bit).

Thanks,
Rafael
