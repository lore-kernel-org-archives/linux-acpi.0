From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/3] PM: Asynchronous resume of devices
Date: Sat, 22 Aug 2009 23:45:24 +0200
Message-ID: <200908222345.24834.rjw@sisk.pl>
References: <200908122218.13975.rjw@sisk.pl> <200908152259.18417.rjw@sisk.pl> <20090822092429.GC11448@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46243 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932376AbZHVVo3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Aug 2009 17:44:29 -0400
In-Reply-To: <20090822092429.GC11448@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@linux.intel.com>

On Saturday 22 August 2009, Pavel Machek wrote:
> Hi!
> 
> > > Do we really need async for noirq handlers?
> > 
> > Yes, we do.  Specifically, for PCI.
> 
> Do noirq parts of PCI handling really so long that we need to make
> them async?

I think so.  It may get 10 ms to handle a PCI device at this stage usually
and this is all waiting.  If you multiply that by the number of PCI devices ...

> Async in normal paths looks pretty much okay to me, but in noirq
> parts, locking is tricky, etc...

The locking is actually simpler in that case.

Thanks,
Rafael
