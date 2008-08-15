From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4/4] acpi: semaphore removal
Date: Sat, 16 Aug 2008 00:17:46 +0200
Message-ID: <48A6008A.8080104@linux.intel.com>
References: <1218831242-27618-1-git-send-email-dwalker@mvista.com> <1218831242-27618-2-git-send-email-dwalker@mvista.com> <1218831242-27618-3-git-send-email-dwalker@mvista.com> <1218831242-27618-4-git-send-email-dwalker@mvista.com> <1218831242-27618-5-git-send-email-dwalker@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:48210 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753324AbYHOWR6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 18:17:58 -0400
In-Reply-To: <1218831242-27618-5-git-send-email-dwalker@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>

Daniel Walker wrote:
> The semaphore usage in ACPI is more like completions. The ASL
> functions getting implemented here are signals which follow a
> "wait for", signaled, or reset format.
> 
> This implements the ACPI signaling methods with the Linux
> completion API, instead of using semaphores.

NACK. I don't see the point of emulating semaphores when
there are already perfectly fine semaphores available.

-Andi

