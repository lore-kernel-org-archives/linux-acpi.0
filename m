From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Thu, 27 Apr 2006 15:36:50 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0BA3@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usea-naimss1.unisys.com ([192.61.61.103]:6415 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1751631AbWD0Ug7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Apr 2006 16:36:59 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, Andi Kleen <ak@suse.de>
Cc: sergio@sergiomb.no-ip.org, Kimball Murray <kimball.murray@gmail.com>, linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com, linux-acpi@vger.kernel.org

> >But I guess using GSI/vector internally only would be fine.
> 
> The last time I tried to name a variable "gsi" instead of "irq",
> Linus launched into a tirade that "GSI" doesn't mean anything to him,
> or anybody else that googles it.  On the other hand "IRQ" means
> something
> to everybody, and if you google it you find all kinds of interesting
> interrupt-related things.
> 
> My point was that "IRQ" means so many "interrupt related" things to
> different people in different contexts, that it is effectively
> meaningless.
> 
> But Linus was not swayed.
> 

Oh Len, let's call this thing IRQ why not ;) I kind of agree that this
is more popular and well-known term, like an old trade mark. I just see
all those layers of code right now to map those to GSIs, pins, whatever
it is, that can be replaced with... well, much smaller layers of code :)
and maybe less "assumpti-ous" too.

--Natalie 
