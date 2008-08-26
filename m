From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/4] mutex: add mutex_lock_timeout()
Date: Tue, 26 Aug 2008 21:32:24 +0200
Message-ID: <48B45A48.6080604@linux.intel.com>
References: <1219777186-4787-1-git-send-email-dwalker@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51692 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844AbYHZTcX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Aug 2008 15:32:23 -0400
In-Reply-To: <1219777186-4787-1-git-send-email-dwalker@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox <matthew@wil.cx>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org


Daniel,

My decision on this patchkit is to reject it for now, because:

- I'm worried about the long term maintenance impact of doing full
lockdep checking on AML controlled locks. Since I'm keeping ACPI
only temporarily I don't want to leave an potentially problematic
legacy.
- I fail to see the advantage of implementing semaphores using conditions.

However what you can do is to ask Len again when he's back. Ultimately
it is his decision and he might decide that he can deal with AML lockdep
issues longer term.

Don't think it makes all that much sense to resubmit the completion
patch though. It's unrelated to the other patches anyways (not sure
why you mix them together)

-Andi
