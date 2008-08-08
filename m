From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 5/5] acpi: semaphore removal
Date: Fri, 08 Aug 2008 04:44:04 +0200
Message-ID: <489BB2F4.9010408@linux.intel.com>
References: <1218121178-13779-1-git-send-email-dwalker@mvista.com> <1218121178-13779-2-git-send-email-dwalker@mvista.com> <1218121178-13779-3-git-send-email-dwalker@mvista.com> <1218121178-13779-4-git-send-email-dwalker@mvista.com> <1218121178-13779-5-git-send-email-dwalker@mvista.com> <1218121178-13779-6-git-send-email-dwalker@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25290 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746AbYHHCn6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Aug 2008 22:43:58 -0400
In-Reply-To: <1218121178-13779-6-git-send-email-dwalker@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Matthew Wilcox <matthew@wil.cx>, Peter Zijlstra <peterz@infradead.org>, Zhao Yakui <yakui.zhao@intel.com>, Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@elte.hu>

Daniel Walker wrote:
> The semaphore usage in ACPI is more like completions. The ASL
> functions getting implemented here are signals which follow a
> "wait for", signaled, or reset format.
> 
> This implements the ACPI signaling methods with the Linux
> completion API, instead of using semaphores.
> 
> completion_done() taken from Dave Chinner.

I agree with Matthew's earlier criticism. It doesn't make sense to
reinvent semaphores using completions when we really need semaphores
here for several cases (e.g. the AML locks by themselves)

So I'm not going to apply this patch.

What I'm open for is to convert specific non AML instances
of the ACPICA semaphores to mutexes. Such changes would need
to be coordinated with Bob of course though because it would affect
his codebase. In fact that has been already done for some.

-Andi
