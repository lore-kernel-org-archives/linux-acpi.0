From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] More updates for 2.6.25
Date: Wed, 23 Jan 2008 16:05:39 +0100
Message-ID: <200801231605.39598.rjw@sisk.pl>
References: <200801110118.46106.rjw@sisk.pl> <200801161337.19070.rjw@sisk.pl> <20080123083010.GB11223@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35955 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934AbYAWPIA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jan 2008 10:08:00 -0500
In-Reply-To: <20080123083010.GB11223@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Wednesday, 23 of January 2008, Pavel Machek wrote:
> On Wed 2008-01-16 13:37:18, Rafael J. Wysocki wrote:
> > On Wednesday, 16 of January 2008, Pavel Machek wrote:
> > > On Tue 2008-01-15 23:22:33, Len Brown wrote:
> > > > On Thursday 10 January 2008 19:18, Rafael J. Wysocki wrote:
> > > > > Len,
> > > > > 
> > > > > Please add the following three patches to the suspend branch.
> > > > 
> > > > Applied (and suspend branch has been re-based to latest linus tree)
> > > 
> > > Was that "lets reorder notifications, old order was more logical, but
> > > it fixes apm?" series?
> > 
> > Yes, plus the docs update from Dave Brownell.
> 
> Can we stop that reordering? I do not think it is such a good idea.

In this particular case it's needed to unbreak the APM emulation and it
certainly is not a good idea to have two different orderings of the notifiers
vs the freezer (hence the second patch in the series).

Thanks,
Rafael
