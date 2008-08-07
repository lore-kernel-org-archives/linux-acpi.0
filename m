From: Daniel Walker <dwalker@mvista.com>
Subject: RE: [PATCH 4/5] acpi: remove interpreter lock
Date: Thu, 07 Aug 2008 14:09:00 -0700
Message-ID: <1218143340.19162.40.camel@localhost.localdomain>
References: <1218121178-13779-1-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-2-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-3-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-4-git-send-email-dwalker@mvista.com>
	 <1218121178-13779-5-git-send-email-dwalker@mvista.com>
	 <9D39833986E69849A2A8E74C1078B6B3CE1334@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:24745 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbYHGVJT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 17:09:19 -0400
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B3CE1334@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <matthew@wil.cx>, Peter Zijlstra <peterz@infradead.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@elte.hu>

On Thu, 2008-08-07 at 13:32 -0700, Moore, Robert wrote:
> I believe the point was to allow the handler to execute methods, even
> from other threads and to not block the interpreter for an unknown
> amount of time.
> 

Could you elaborate on this more, I'm not following you.. What do you
mean by "handler"? The name "interpreter lock" to me sort of indicates
that it's protecting the interpreter. So I'm guessing the point was to
stop multiple threads from being inside the interpreter at once.

If that's the case it doesn't make sense to release the mutex while your
inside the interpreter. That means another thread could then enter and
the protection doesn't hold.

It looked like most if the interpreter functions allocate their own
memory, then use that memory without sharing it with other instances of
the interpreter. So it's all contained into the one thread. 

You also have the mutexes embedded in the AML , which seem to indicate
the AML is thread safe (might be a big assumption tho).

Daniel

