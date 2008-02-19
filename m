From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Tue, 19 Feb 2008 10:24:22 -0300
Message-ID: <20080219132422.GA15883@khazad-dum.debian.net>
References: <20080119120830.GA16308@khazad-dum.debian.net> <20080119141727.GJ28387@mit.edu> <20080119153304.GA27060@khazad-dum.debian.net> <20080119154328.GA11024@srcf.ucam.org> <20080119231916.GK28387@mit.edu> <20080120194919.GE19295@khazad-dum.debian.net> <1203353902.6019.119.camel@queen.suse.de> <20080218191729.GB9724@khazad-dum.debian.net> <1203379259.3971.90.camel@linux-2bdv.site> <20080219002657.GO25098@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:49760 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751746AbYBSNY3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Feb 2008 08:24:29 -0500
Content-Disposition: inline
In-Reply-To: <20080219002657.GO25098@mit.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, 18 Feb 2008, Theodore Tso wrote:
> On Tue, Feb 19, 2008 at 01:00:59AM +0100, Thomas Renninger wrote:
> > Most stuff that gets fixed by these workarounds would make no sense to
> > backport, because backports are much too intrusive, e.g.:
> 
> Many of the workarounds really aren't that hard to backport, and the

Agreed.

Not only that, but one of the corrent things that OSI(Linux) changes in a
certain vendor platform in the real world is actually something we will want
to modify depending on the *X.org* server evolution (and, if we ever get
around to it, our in-kernel framebuffer capabilities, too).

That's a clean-cut, real-world example of something that any sort of "kernel
version" OSI(Linux) solution would not help with.

IMO, we got ourselves into this mess for taking a shortcut ("hello AML, I am
Linux"), instead of doing the full job in the first place and pushing for it
("hello AML, I need you to always post the video adapter when resuming").
Let's not make that mistake *again*.

Unlike Windows, we are a very fast moving target and we have very long-lived
hardware users.  We can't take half measures on forward and backwards
compatibility information to the hardware and firmware without it causing
painful issues down the road.

> reality is after the distro locks down their kernel version in stone,
> and people start complaining about buggy support for the X300 laptop,
> or some such, the temptation will be *very* high to put in special
> hacks in the thinkpad_acpi driver for some bleeding edge new laptop by
> backporting code from a newer kernel, or grabbing a patch which is
> being discussed on the linux-thinkpad list, etc.

That is not even temptation, that's exactly what happens, and IMHO that's
*how it is supposed to work* in the first place...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
