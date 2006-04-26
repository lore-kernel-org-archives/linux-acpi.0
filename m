From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Wed, 26 Apr 2006 09:00:45 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0B98@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usea-naimss1.unisys.com ([192.61.61.103]:64772 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S932454AbWDZOAu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2006 10:00:50 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sergio@sergiomb.no-ip.org, "Brown, Len" <len.brown@intel.com>
Cc: Kimball Murray <kimball.murray@gmail.com>, linux-kernel@vger.kernel.org, akpm@digeo.com, ak@suse.de, kmurray@redhat.com, linux-acpi@vger.kernel.org

> I think, it is about time, not thinking via quirks as 
> workarounds, because all pcis (on via) are quirked, some are 
> quirked twice.
> And we should think in programmer interrupts of via chipset, 
> in specific function for this propose, for me, doesn't make 
> sense every time VIA put other ID out, we have to add quirks 
> to this ID , as this was an exception. 
> 
> Thanks, 

VIA's numerous pci quirks are not related to this patch. They only hit
one problem with it having only 4 bits encoding their interrupt.
 
> On Tue, 2006-04-25 at 15:53 -0400, Brown, Len wrote:
> > I'd rather see the original irq-renaming patch and its subsequent 
> > multiple via workaround patches reverted than to further complicate 
> > what is becoming a fragile mess.
> > 
> > -Len

There are probably better ways to control 224 possible IRQs by their
total number instead of their range, and per-cpu IDTs are the better
answer to the IRQ shortage altogether. But just going back to the way it
was wouldn't be right I think. We were able to run 2 generations of
systems only because we had this compression, other big systems
benefited from it as well.
Thanks,
--Natalie
