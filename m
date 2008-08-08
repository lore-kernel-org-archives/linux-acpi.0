From: Daniel Walker <dwalker@mvista.com>
Subject: RE: [PATCH 4/5] acpi: remove interpreter lock
Date: Thu, 07 Aug 2008 17:01:36 -0700
Message-ID: <1218153696.19162.95.camel@localhost.localdomain>
References: <1218121178-13779-1-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-2-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-3-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-4-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-5-git-send-email-dwalker@mvista.com>
	 <9D39833986E69849A2A8E74C1078B6B3CE1334@orsmsx415.amr.corp.intel.com>
	 <1218143340.19162.40.camel@localhost.localdomain>
	 <9D39833986E69849A2A8E74C1078B6B3CE13CB@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:20940 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbYHHAB4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 20:01:56 -0400
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B3CE13CB@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <matthew@wil.cx>, Peter Zijlstra <peterz@infradead.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@elte.hu>

On Thu, 2008-08-07 at 14:30 -0700, Moore, Robert wrote:
> Yes, we lock the interpreter for major parts of control method execution
> in order to implement the multithreading model of the ACPI
> specification.
> 
> Here are a couple of sections from the ACPICA programmer reference that
> explain the ACPICA multithreading, control method execution, reentrancy,
> etc.

Thanks for the lengthy response.

> 3.3.2.1	Control Method Blocking
> First of all, how can a control method block? This is a fairly
> exhaustive list of the possibilities:
> 1.	Executes the Sleep() ASL opcode
> 2.	Executes the Acquire() ASL opcode and the request cannot be
> immediately satisfied
> 3.	Executes the Wait() ASL opcode and the request cannot be
> immediately satisfied
> 4.	Attempts to acquire the Global Lock (via Operation Region
> access, etc), but must wait
> 5.	Attempts to execute a control method that is serialized and
> already executing (or is blocked), or has reached its concurrency limit
> 6.	Invokes the host debugger via a write to the debug object or
> executes the BreakPoint() ASL opcode
> 7.	Accesses an Operation Region which results in a dispatch to a
> user-installed handler that blocks on I/O or other long-term operation
> 8.	A Notify AML opcode results in a dispatch to a user-installed
> handler that blocks in a similar way


Ok .. Well it looks like the deadlock that lockdep is warning on is
fixed with #2 or #3 .. If you release the interpreter before sleeping on
an Acquire() ASL opcode then you "fix" the deadlock that could happen by
having different locking orders of the interpreter lock with other
mutexes.

I'm not sure how to train lockdep to understand this tho , Ingo? Peter?
you guys have any thoughts?

I assume it's not safe to remove the interpreter lock given the text
that you quoted?

Daniel

