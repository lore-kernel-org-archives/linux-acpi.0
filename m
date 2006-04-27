From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Thu, 27 Apr 2006 15:32:41 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB64A3FE9@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16225 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965069AbWD0Tcq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Apr 2006 15:32:46 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>, "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Cc: sergio@sergiomb.no-ip.org, Kimball Murray <kimball.murray@gmail.com>, linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com, linux-acpi@vger.kernel.org


>But I guess using GSI/vector internally only would be fine.

The last time I tried to name a variable "gsi" instead of "irq",
Linus launched into a tirade that "GSI" doesn't mean anything to him,
or anybody else that googles it.  On the other hand "IRQ" means
something
to everybody, and if you google it you find all kinds of interesting
interrupt-related things.

My point was that "IRQ" means so many "interrupt related" things to
different people in different contexts, that it is effectively
meaningless.

But Linus was not swayed.

-Len
