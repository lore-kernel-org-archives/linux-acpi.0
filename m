From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 5/5] acpi: semaphore removal
Date: Thu, 07 Aug 2008 20:35:37 -0700
Message-ID: <1218166537.19162.122.camel@localhost.localdomain>
References: <1218121178-13779-1-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-2-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-3-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-4-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-5-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-6-git-send-email-dwalker@mvista.com>
	 <489BB2F4.9010408@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:58576 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbYHHDf6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 23:35:58 -0400
In-Reply-To: <489BB2F4.9010408@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Matthew Wilcox <matthew@wil.cx>, Peter Zijlstra <peterz@infradead.org>, Zhao Yakui <yakui.zhao@intel.com>, Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@elte.hu>

On Fri, 2008-08-08 at 04:44 +0200, Andi Kleen wrote:
> Daniel Walker wrote:
> > The semaphore usage in ACPI is more like completions. The ASL
> > functions getting implemented here are signals which follow a
> > "wait for", signaled, or reset format.
> > 
> > This implements the ACPI signaling methods with the Linux
> > completion API, instead of using semaphores.
> > 
> > completion_done() taken from Dave Chinner.
> 
> I agree with Matthew's earlier criticism. It doesn't make sense to
> reinvent semaphores using completions when we really need semaphores
> here for several cases (e.g. the AML locks by themselves)

Not following you .. The AML locks are strict mutexes (I was happily
surprised to find out how strict).. The AML signals are just strict
completions .. I didn't have to mod the completion API to make this
work, the one API addition could be removed without any ill effects
(except less debug checking).

It's really a clean replacement .. ACPI has it's own mutex API which now
just calls the Linux mutex, and that change leaves AML signals as the
only semaphore user which are completions ..

Everything should be fine if Bob just uses two types of locking either
he uses a mutex, or he uses a semaphore with an initial unit of 0..
Which appears to be what he's been doing for a while anyway..

> So I'm not going to apply this patch.

Ok .. I think the interpreter locking needs to get straightened out
before it's even considered to be applied ..

> What I'm open for is to convert specific non AML instances
> of the ACPICA semaphores to mutexes. Such changes would need
> to be coordinated with Bob of course though because it would affect
> his codebase. In fact that has been already done for some.

You don't want lockdep checking the AML mutexes?

Daniel

