From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Fri, 14 Aug 2009 21:12:38 +0200
Message-ID: <200908142112.38557.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908141044220.2987-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756944AbZHNTMM@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0908141044220.2987-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Friday 14 August 2009, Alan Stern wrote:
> On Thu, 13 Aug 2009, Rafael J. Wysocki wrote:
> 
> > > No, I've only tested it with a few selected drivers.  I'm going to try the
> > > "async everyone" scenario, though.
> > 
> > On HP nx6325 booted with init=/bin/bash it doesn't pass the
> > 'echo devices > /sys/power/pm_test && echo mem > /sys/power/state' test.
> > 
> > The suspend part actually seems to work, but the resume part crashes
> > miserably.
> 
> Any details?  Can you tell where it crashes?

Unfortunately it ends up in a continuous flood of backtraces, so I can't
say much.

However, if I set async_suspend for all PCI devices, as well as for ACPI battery
and i8042, everything apparently works, even with real suspend-resume.

Thanks,
Rafael
