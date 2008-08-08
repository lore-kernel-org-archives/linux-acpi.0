From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 5/5] acpi: semaphore removal
Date: Thu, 07 Aug 2008 18:00:06 -0700
Message-ID: <1218157206.19162.98.camel@localhost.localdomain>
References: <1218121178-13779-1-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-2-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-3-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-4-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-5-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-6-git-send-email-dwalker@mvista.com>
	 <20080808003408.GA8618@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:42869 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175AbYHHB1Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 21:27:25 -0400
In-Reply-To: <20080808003408.GA8618@parisc-linux.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Zhao Yakui <yakui.zhao@intel.com>, Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@elte.hu>

On Thu, 2008-08-07 at 18:34 -0600, Matthew Wilcox wrote:
> On Thu, Aug 07, 2008 at 07:59:43AM -0700, Daniel Walker wrote:
> > The semaphore usage in ACPI is more like completions. The ASL
> > functions getting implemented here are signals which follow a
> > "wait for", signaled, or reset format.
> > 
> > This implements the ACPI signaling methods with the Linux
> > completion API, instead of using semaphores.
> > 
> > completion_done() taken from Dave Chinner.
> 
> completion_done is an abomination.  Stop this.
> 

In my ACPI changes it's just used for a BUG_ON to trigger if there is
something waiting on the completion before the memory gets free'd ..

You don't like how it's used, or you don't like the code itself?

Daniel

