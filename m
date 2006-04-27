From: Andi Kleen <ak@suse.de>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Thu, 27 Apr 2006 21:13:24 +0200
Message-ID: <200604272113.24705.ak@suse.de>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0B9F@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:28591 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964919AbWD0TNl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Apr 2006 15:13:41 -0400
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0B9F@USRV-EXCH4.na.uis.unisys.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Cc: "Brown, Len" <len.brown@intel.com>, sergio@sergiomb.no-ip.org, Kimball Murray <kimball.murray@gmail.com>, linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com, linux-acpi@vger.kernel.org

On Thursday 27 April 2006 21:10, Protasevich, Natalie wrote:
> > 
> > >There are probably better ways to control 224 possible IRQs by their 
> > >total number instead of their range, and per-cpu IDTs are the better 
> > >answer to the IRQ shortage altogether. But just going back 
> > to the way 
> > >it was wouldn't be right I think.
> > >We were able to run 2 generations of
> > >systems only because we had this compression, other big systems 
> > >benefited from it as well.
> > 
> > I don't propose reverting the IRQ re-name patch and breaking 
> > the big iron without replacing it with something else that works.
> 
> Len, maybe it sounds dramatic and/or extreme, but how about getting rid
> of IRQs and just having GSI-vector pair.
> I intuitively think that would be possible (not that I have all the
> details lined up :)
> And this would probably take away confusing IRQ abstraction out once and
> for all? I think something like that is done in ia64.

x86 users are attached to their interrupt numbers I think back from the bad old
days with only 16 interrupts and interrupt sharing didn't work. We might have a revolt
in the user base if /proc/interrupts didn't display them anymore @)

But I guess using GSI/vector internally only would be fine.

-Andi

