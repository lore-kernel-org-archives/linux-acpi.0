From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/3] PM: Asynchronous resume of devices
Date: Sat, 22 Aug 2009 11:24:30 +0200
Message-ID: <20090822092429.GC11448@elf.ucw.cz>
References: <200908122218.13975.rjw@sisk.pl> <200908122220.03363.rjw@sisk.pl> <20090814163328.GF1626@ucw.cz> <200908152259.18417.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932943AbZHVJYg@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200908152259.18417.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Do we really need async for noirq handlers?
> 
> Yes, we do.  Specifically, for PCI.

Do noirq parts of PCI handling really so long that we need to make
them async?

Async in normal paths looks pretty much okay to me, but in noirq
parts, locking is tricky, etc...
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
