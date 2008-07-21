From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/3] acpi: add real mutex function calls
Date: Mon, 21 Jul 2008 11:17:25 +0200
Message-ID: <48845425.9000607@linux.intel.com>
References: <1216491411-24080-1-git-send-email-dwalker@mvista.com>	 <1216491411-24080-2-git-send-email-dwalker@mvista.com>	 <1216605078.4135.23.camel@yakui_zhao.sh.intel.com> <1216631698.7257.29.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39447 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754640AbYGUJR0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jul 2008 05:17:26 -0400
In-Reply-To: <1216631698.7257.29.camel@twins>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Daniel Walker <dwalker@mvista.com>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, len.brown@intel.com

Peter Zijlstra wrote:
> On Mon, 2008-07-21 at 09:51 +0800, Zhao Yakui wrote:
>> On Sat, 2008-07-19 at 11:16 -0700, Daniel Walker wrote:
>>> Instead of re-using semaphores for the mutex operation, I've
>>> added usage of the kernel mutex for the os mutex implementation.
>>>
>> What is the advantage that the kernel mutex is used for the ACPI mutex
>> implementation instead of using semaphore?
>> And it seems that too much ACPICA source code is touched.
> 
> You get help from lockdep, and also our goal is to fully eradicate
> semaphore usage.

Issue is that ACPICA is shared with other OS source code and to replace 
a major interface like this would mean replacing it for everyone. It 
might end up with ACPICA just reimplementing a semaphore like wrapper if 
semaphores really go away, but I don't really see that coming anyways.

-Andi

