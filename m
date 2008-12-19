From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2.6.28-rc6] ACPICA: don't cond_resched() when
 irqs_disabled()
Date: Fri, 19 Dec 2008 03:38:18 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812190326000.6312@localhost.localdomain>
References: <20081126135508.GA1891@localhost>
 <alpine.LFD.2.00.0812190016120.6312@localhost.localdomain>
 <1229670120.3990.11.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:42327 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbYLSIiY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 03:38:24 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KC4004KR7ZX8KM2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Dec 2008 02:38:21 -0600 (CST)
In-reply-to: <1229670120.3990.11.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Wu, Fengguang" <fengguang.wu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

>     The issue on Fengguang's laptop is different with that on the box of
> T61.  On Fengguang's laptop after evaluating one ACPI object(GPE
> _L18object), the irq is disabled mystically. After some investigations
> we find that it is caused by SMI(The SMI will be triggered while
> evaluating the ACPI object. And this issue is also related with Video). 

Interesting.
I hadn't realized you root-caused that failure.
This is good to know, but the fact that SMM can
leave interrupts disabled is frightening.

If the BIOS SMM on that box disables interrupts when
random AML is run, then it is going to run into
all kinds of other problems in addition to this one...

Hopefully the BIOS bugs is fixed by a BIOS update...

>     If the boot option of "noapic" is added on the box of bug12252, the
> irq_router_resume will be called, in which the _CRS/_SRS object will be
> evaluated. But unfortunately the irq is disabled when irq_router_resume
> is called. 

Right.  I forced the T61 to run into this problem by forcing
it to use PIC mode and suspending -- for it doesn't use the links
in IOAPIC mode.  Many other systems do use the links in default
mode, however, so I'm surprised that we had not heard more about
this failure.

Now that I search for acpi_ps_complete_op() on kerneloops.org,
I see that just a few people have run into it.

thanks,
-- Len Brown, Intel Open Source Technology Center> 

