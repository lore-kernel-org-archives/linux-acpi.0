From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 4/4] acpi: semaphore removal
Date: Fri, 15 Aug 2008 17:18:55 -0700
Message-ID: <1218845935.6166.116.camel@dhcp32.mvista.com>
References: <1218831242-27618-1-git-send-email-dwalker@mvista.com>
	 <1218831242-27618-2-git-send-email-dwalker@mvista.com>
	 <1218831242-27618-3-git-send-email-dwalker@mvista.com>
	 <1218831242-27618-4-git-send-email-dwalker@mvista.com>
	 <1218831242-27618-5-git-send-email-dwalker@mvista.com>
	 <48A6008A.8080104@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:29000 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbYHPAS5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 20:18:57 -0400
In-Reply-To: <48A6008A.8080104@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>

On Sat, 2008-08-16 at 00:17 +0200, Andi Kleen wrote:
> Daniel Walker wrote:
> > The semaphore usage in ACPI is more like completions. The ASL
> > functions getting implemented here are signals which follow a
> > "wait for", signaled, or reset format.
> > 
> > This implements the ACPI signaling methods with the Linux
> > completion API, instead of using semaphores.
> 
> NACK. I don't see the point of emulating semaphores when
> there are already perfectly fine semaphores available.


With semaphores as a super set, under that you have mutexes and
completions, and other un-classified usages.. Mutex usage is obviously
for mutual exclusion (semaphore initialized to 1), completions are used
for signaling (semaphore initialized to 0).

The semaphores in ACPI are specifically used in the initialized to 0
configuration (i.e. signaling). There are a total of three
initialization locations of ACPI semaphores

1    186  drivers/acpi/executer/excreate.c <<acpi_ex_create_event>>
2    295  drivers/acpi/executer/exsystem.c <<acpi_ex_system_reset_event>>
3    216  drivers/acpi/namespace/nsaccess.c <<acpi_ns_root_initialize>>

ACPI doesn't use semaphores, it uses completions .. Although the name
semaphore remains, they are still completions.

It should really be the inverse , why is ACPI using semaphores when we
have perfectly good completions (specific tool for a specific job).. 

Daniel

