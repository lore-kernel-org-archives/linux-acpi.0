From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: RTC_DRV_CMOS can break userspace interface
Date: Mon, 28 May 2007 03:16:22 +0100
Message-ID: <20070528021622.GA24517@srcf.ucam.org>
References: <20070527190351.GA21387@srcf.ucam.org> <20070527233911.GA23491@srcf.ucam.org> <20070528003822.GA23759@srcf.ucam.org> <200705271844.54589.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:34888 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbXE1CQe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 May 2007 22:16:34 -0400
Content-Disposition: inline
In-Reply-To: <200705271844.54589.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, May 27, 2007 at 06:44:49PM -0700, David Brownell wrote:
> On Sunday 27 May 2007, Matthew Garrett wrote:
> > Actually, it seems to be worse than that - the PNP entry for my cmos 
> > clock doesn't appear to mention an irq, so the wakealarm entry doesn't 
> > work. I can happily wake it using the /proc/acpi/alarm interface.
> > 
> > David, would you be happy with hardcoding the rtc-cmos IRQ to 8 on PCs 
> > if there's inadequate PNP information available?
> 
> That would seem to naturally belong in the PNP code, yes?
> 
> Agreed that it seems like it needs to be hardcoded somewhere.

The PNP code is reporting what's in the tables - I'd be a bit surprised 
if it special-cased specific devices, but I guess there's an argument 
for that. All the other machines I've checked report an IRQ, so I guess 
Apple just didn't take much care in getting this right.

As far as sanity checking goes - how about we check that the reported 
io ports are the legacy range, and if so hardcode the irq if the 
hardware hasn't reported one? I'd /hope/ that nobody has produced any 
hardware that that would break, but then, well. The strongest argument 
for it being safe is probably that the legacy RTC driver seems to 
hardcode this and hasn't obviously been breaking things.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
