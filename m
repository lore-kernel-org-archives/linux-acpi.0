From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH v2] ACPI: D3 states cleanup
Date: Fri, 20 Apr 2012 15:47:33 +0800
Message-ID: <20120420074725.GA30140@localhost.amd.com>
References: <1334884749.4927.6.camel@minggr>
 <20120420022304.GA3001@localhost.amd.com>
 <1334891953.4927.19.camel@minggr>
 <20120420052259.GA21040@localhost.amd.com>
 <1334900255.4927.36.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:1342
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752308Ab2DTHrs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Apr 2012 03:47:48 -0400
Content-Disposition: inline
In-Reply-To: <1334900255.4927.36.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "Huang, Ying" <ying.huang@intel.com>

Hi,

On Fri, Apr 20, 2012 at 01:37:35PM +0800, Lin Ming wrote:
> > > > > There are two ACPI D3 states defined now:
> > > > > ACPI_STATE_D3 and ACPI_STATE_D3_COLD.
> > > > > 
> > > > > But the uses of these states are not clear/correct in some code.
> > > > > For example, some code refer ACPI_STATE_D3 as D3hot and others refer
> > > > > it as D3cold.
> > > > > 
> > > > > This patch introduces ACPI_STATE_D3_HOT to refer to ACPI D3hot state.
> > > > > And changes ACPI_STATE_D3 to refer to ACPI D3cold state only.
> > > > > Also redefines ACPI_STATE_D3_COLD the same as ACPI_STATE_D3.
> > > > > 
> > > > 
> > > > With this patch now, if a device has _PS3, then we will set its D3hot
> > > > flag valid. This doesn't feel right to me, since per our discussion the
> > > > other day, we should assume _PS3 will put the device into D3cold.
> > > > 
> > > > Or do you mean: if _PS3 is available, then both D3hot and D3cold is
> > > > valid from the perspective of acpi, it is the individual driver's
> > > > responsibility to decide which state is actually valid and will be used.
> > > 
> > > Right.
> > > 
> > > ACPI_STATE_D3(same as ACPI_STATE_D3_COLD now) is always valid.
> > > 
> > 
> > I mean, if _PS3 is available, can we say D3hot is valid?
> 
> Yes.
> 

OK, now I'm confused...

First, let me try to clarify the meaning of acpi power state's valid
flag.

By valid, I suppose it means the device can be in that state, instead of
we have a way to program this device to go into that state.

e.g. D0 is valid means the device can be in D0 state, and D3_cold is
valid means the device can be in D3_cold state. We unconditionally set
these two states as valid, because we know every device supports these
two states. But we might not be able to put the device into that state
in software, since we might not have _PS0 or _PS3 control methods for it.

And if we do have the _PSx or _PRx control methods, we knows we have a
way to put the device into that state, and hence the device should be
able to support that power state, so we will set that state as valid too.

Is this correct?

For D3hot, obviously not all device supports this state, so we will need
to figure it out through the acpi table.
I remembered Rafael said the following words the other day in a reply to
my evaluate_ps3_when_entering_d3_cold_patch:

-----------------------------------------------------------------------
I'd rather say that with _PR3 we have the opportunity to avoid removing
power completely from the device.  In other words, D3_hot is supported (and
it is supported _only_ in that case).
-----------------------------------------------------------------------

So I think here is a problem, that if a device has only _PS3, why should
we say D3hot is supported? Is there a reason for this that I missed?

Explanation is appreciated, thanks.

-Aaron


