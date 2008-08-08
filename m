From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 5/5] acpi: semaphore removal
Date: Fri, 8 Aug 2008 11:28:49 +1000
Message-ID: <20080808012849.GC24344@disturbed>
References: <1218121178-13779-1-git-send-email-dwalker@mvista.com> <1218121178-13779-2-git-send-email-dwalker@mvista.com> <1218121178-13779-3-git-send-email-dwalker@mvista.com> <1218121178-13779-4-git-send-email-dwalker@mvista.com> <1218121178-13779-5-git-send-email-dwalker@mvista.com> <1218121178-13779-6-git-send-email-dwalker@mvista.com> <20080808003408.GA8618@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ipmail05.adl2.internode.on.net ([203.16.214.145]:64460 "EHLO
	ipmail05.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752001AbYHHBd4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 21:33:56 -0400
Content-Disposition: inline
In-Reply-To: <20080808003408.GA8618@parisc-linux.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Daniel Walker <dwalker@mvista.com>, linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Zhao Yakui <yakui.zhao@intel.com>, Ingo Molnar <mingo@elte.hu>

On Thu, Aug 07, 2008 at 06:34:08PM -0600, Matthew Wilcox wrote:
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

Say what?

You've had several opportunities to comment on that *you suggested*
[1]. You did not respond to any of them when it was being discussed
6 weeks ago  and subsequent resends [2] and now you're saying what
you suggested is an abortion?

What's the problem? The implementation, the interface, or
something else?

[1] http://oss.sgi.com/archives/xfs/2008-06/msg00380.html

[2] http://oss.sgi.com/archives/xfs/2008-06/msg00382.html
    http://oss.sgi.com/archives/xfs/2008-06/msg00400.html
    http://oss.sgi.com/archives/xfs/2008-07/msg00173.html

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
