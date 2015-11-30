From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] acpi: Better describe ACPI_DEBUGGER
Date: Mon, 30 Nov 2015 23:39:08 +0100
Message-ID: <20151130223908.GH3816@twins.programming.kicks-ass.net>
References: <20151130213215.GC3816@twins.programming.kicks-ass.net>
 <1645670.Yj5okVLt1U@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:36196 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbbK3WjN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2015 17:39:13 -0500
Content-Disposition: inline
In-Reply-To: <1645670.Yj5okVLt1U@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, acpi@linux.intel.com

On Mon, Nov 30, 2015 at 11:43:26PM +0100, Rafael J. Wysocki wrote:
> On Monday, November 30, 2015 10:32:15 PM Peter Zijlstra wrote:
> > Hi,
> > 
> > For a brief moment I was tricked into thinking that:
> > 
> >   In-kernel debugger (EXPERIMENTAL) (ACPI_DEBUGGER) [N/y/?] (NEW)
> > 
> > might be something useful. Better describe the feature to reduce
> > such confusion.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Applied, thanks!
> 
> I should have caught that, sorry for the sloppiness.

n/p, for a brief moment I thought about things like a GDB stub running
in SMM -- which would be entirely awesome if it had dedicated IO through
a BMC or simple serial.

Then I thought about all the kvm-gdb-stub fail I've encountered over the
years and figured this would never work, seeing how BIOSes are never
updated/fixed.
