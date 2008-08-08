From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 5/5] acpi: semaphore removal
Date: Thu, 07 Aug 2008 20:47:45 -0700
Message-ID: <1218167265.19162.132.camel@localhost.localdomain>
References: <1218121178-13779-1-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-2-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-3-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-4-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-5-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-6-git-send-email-dwalker@mvista.com>
	 <20080808003408.GA8618@parisc-linux.org> <20080808012849.GC24344@disturbed>
	 <20080808025303.GB8618@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:59837 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbYHHDsG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 23:48:06 -0400
In-Reply-To: <20080808025303.GB8618@parisc-linux.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Dave Chinner <david@fromorbit.com>, linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Zhao Yakui <yakui.zhao@intel.com>, Ingo Molnar <mingo@elte.hu>

On Thu, 2008-08-07 at 20:53 -0600, Matthew Wilcox wrote:
> On Fri, Aug 08, 2008 at 11:28:49AM +1000, Dave Chinner wrote:
> > > completion_done is an abomination.  Stop this.
> > 
> > Say what?
> > 
> > You've had several opportunities to comment on that *you suggested*
> > [1]. You did not respond to any of them when it was being discussed
> > 6 weeks ago  and subsequent resends [2] and now you're saying what
> > you suggested is an abortion?
> 
> Sorry, I had it confused with these:
> 
> http://oss.sgi.com/archives/xfs/2008-06/msg00372.html


I was just saying that completions should be used for resource counting.
Like the usage in drivers/usb/usb-skeleton.c,

sema_init(&dev->limit_sem, WRITES_IN_FLIGHT);

This writes in flight usage happens 5-10 times in Linux, and completion
can fit that usage model .. It's not really locking, it's just counting.

Daniel

