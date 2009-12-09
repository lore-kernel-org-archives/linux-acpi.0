From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Wed, 9 Dec 2009 10:57:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912091051450.4120-100000@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912090728200.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:40652 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752645AbZLIP5G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 10:57:06 -0500
In-Reply-To: <alpine.LFD.2.00.0912090728200.3560@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Wed, 9 Dec 2009, Linus Torvalds wrote:

> That's partly why I realy did suggest that we do the async stuff purely in 
> the USB layer, rather than try to put it deeper in the device layer. And 
> if we do support it "natively" in the device layer like Rafael's latest 
> patch, I still think we should be very very nervous about making devices 
> async unless there is a measured - and very noticeable - advantage.

Agreed.  Arjan's measurements indicated that USB was one of the biggest
offenders; everything else other than the PS/2 mouse was much faster.  
Given these results there isn't much incentive to do anything else
asynchronously.

(However other devices not present on Arjan's machine may be a
different story.  Spinning up multiple external disks is a good example 
-- although here it may be necessary for the driver to take charge, 
because spinning up a disk requires a lot of power and doing too many 
of them at the same time could be bad.)

Alan Stern

