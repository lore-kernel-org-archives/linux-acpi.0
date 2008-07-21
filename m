From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/3] acpi: add real mutex function calls
Date: Mon, 21 Jul 2008 21:20:23 +0200
Message-ID: <4884E177.5000809@linux.intel.com>
References: <1216491411-24080-1-git-send-email-dwalker@mvista.com>	 <1216491411-24080-2-git-send-email-dwalker@mvista.com>	 <1216605078.4135.23.camel@yakui_zhao.sh.intel.com> <1216648574.2294.9.camel@dhcp32.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:14181 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754723AbYGUTUd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jul 2008 15:20:33 -0400
In-Reply-To: <1216648574.2294.9.camel@dhcp32.mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, len.brown@intel.com, robert.moore@intel.com

Daniel Walker wrote:
> On Mon, 2008-07-21 at 09:51 +0800, Zhao Yakui wrote:
>> On Sat, 2008-07-19 at 11:16 -0700, Daniel Walker wrote:
>>> Instead of re-using semaphores for the mutex operation, I've
>>> added usage of the kernel mutex for the os mutex implementation.
>>>
>> What is the advantage that the kernel mutex is used for the ACPI mutex
>> implementation instead of using semaphore?
>> And it seems that too much ACPICA source code is touched.
> 
> In general you would want to use a mutex whenever your using mutex-like
> semantics. If I see a mutex used in code then I have a pretty good idea
> the locking is sane..

With a mutex the locking can be totally broken and with a semaphore the 
locking can be completely fine. They are both just tools which can be 
used correctly and also incorrectly.

The main advantage of mutexes is that they can be slightly more 
efficient (doesn't matter for the ACPI case, the ACPI interpreter is not 
performance critical) and that they are easier to check with lockdep. 
But there are also other considerations like in ACPICA's case portability.

My feeling is that adding own semaphore wrappers to ACPICA wouldn't
be an improvement. Defering to Bob Moore for his opinion, since
he maintains ACPICA.

-Andi
