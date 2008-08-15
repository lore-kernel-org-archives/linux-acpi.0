From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/4] acpi: add real mutex function calls
Date: Sat, 16 Aug 2008 00:16:15 +0200
Message-ID: <48A6002F.6070706@linux.intel.com>
References: <1218831242-27618-1-git-send-email-dwalker@mvista.com> <1218831242-27618-2-git-send-email-dwalker@mvista.com> <1218831242-27618-3-git-send-email-dwalker@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:21555 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751605AbYHOWQL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 18:16:11 -0400
In-Reply-To: <1218831242-27618-3-git-send-email-dwalker@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>

Daniel Walker wrote:
> Instead of re-using semaphores for the mutex operation, I've
> added usage of the kernel mutex for the acpi os mutex
> implementation.

This still implies that we'll get lockdep warnings if the AML
does something dodgy with mutexes, right?

I don't like that. We cannot generally fix the AML, the only
way would be to time out on a deadlock and let it handle that.
Also it's not that we don't get enough ACPI reports already.

Is there a way to just turn lockdep always off for these mutexes?

-Andi
