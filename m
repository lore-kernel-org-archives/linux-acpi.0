From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Thu, 13 Aug 2009 23:53:54 +0200
Message-ID: <200908132353.54902.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908121702520.23954-100000@iolanthe.rowland.org> <200908122343.20554.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36591 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412AbZHMVxN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Aug 2009 17:53:13 -0400
In-Reply-To: <200908122343.20554.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>

On Wednesday 12 August 2009, Rafael J. Wysocki wrote:
> On Wednesday 12 August 2009, Alan Stern wrote:
> > On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:
> > 
> > > Hi,
> > > 
> > > The following patches introduce a mechanism allowing us to execute device
> > > drivers' suspend and resume callbacks asynchronously during system sleep
> > > transitions, such as suspend to RAM.  The idea is explained in the [1/1] patch
> > > message.
> > > 
> > > Comments welcome.
> > 
> > I get the idea.  Not bad.
> 
> Thanks!
> 
> > Have you tried it in a serious way?  For example, turning on the
> > async_suspend flag for every device?
> 
> No, I've only tested it with a few selected drivers.  I'm going to try the
> "async everyone" scenario, though.

On HP nx6325 booted with init=/bin/bash it doesn't pass the
'echo devices > /sys/power/pm_test && echo mem > /sys/power/state' test.

The suspend part actually seems to work, but the resume part crashes
miserably.

Thanks,
Rafael
