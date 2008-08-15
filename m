From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH 0/4] acpi semaphore removal v3
Date: Fri, 15 Aug 2008 13:14:02 -0700
Message-ID: <1218831242-27618-1-git-send-email-dwalker@mvista.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:60326 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbYHOUOG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 16:14:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>

I fixed the lockdep issue. It was due to the mutex changes calling
mutex_lock_timeout with a timeout of 0. That acts like a trylock, but it doesn't
get treated by lockdep as a trylock. Now when the timeout is zero we just trylock.
I also removed completion_done() since it was already merged.

I think this is merge ready now ..

Daniel


