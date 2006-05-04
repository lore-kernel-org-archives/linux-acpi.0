From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [RFC][PATCH] Document what in IRQ is.
Date: Thu, 4 May 2006 01:42:30 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB656C807@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22344 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750749AbWEDFme convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 May 2006 01:42:34 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: ak@suse.de, Natalie.Protasevich@unisys.com, sergio@sergiomb.no-ip.org, kimball.murray@gmail.com, linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com, linux-acpi@vger.kernel.org

 
>Linux does not have generic infrastructure to allow two interrupt
>sources to share the same token passed to the kernel. 

On i386 and x86_64 io_apic.c, see irq_pin_list
This advertises to support multiple pins per IRQ.

I suspect this code never runs, and simply adds
complexity to code that has no shortage of complexity.

If somebody can explain to me what a "shared ISA-space IRQ"
is supposed to be, I'm all ears.  I've had a BUG() in this
code for a while waiting for it to be used, and never seen it fire.

If we can get rid of that concept, then we have a 1:1 mapping
between irqs and apic:pin.  Possibly this simplification would
be helpful as we re-think how the mapping from cpu:vector -> irq works.

-Len
