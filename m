From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 1/3] acpi: add real mutex function calls
Date: Mon, 21 Jul 2008 06:56:14 -0700
Message-ID: <1216648574.2294.9.camel@dhcp32.mvista.com>
References: <1216491411-24080-1-git-send-email-dwalker@mvista.com>
	 <1216491411-24080-2-git-send-email-dwalker@mvista.com>
	 <1216605078.4135.23.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:14302 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbYGUN4S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jul 2008 09:56:18 -0400
In-Reply-To: <1216605078.4135.23.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, len.brown@intel.com, ak@linux.intel.com

On Mon, 2008-07-21 at 09:51 +0800, Zhao Yakui wrote:
> On Sat, 2008-07-19 at 11:16 -0700, Daniel Walker wrote:
> > Instead of re-using semaphores for the mutex operation, I've
> > added usage of the kernel mutex for the os mutex implementation.
> > 
> What is the advantage that the kernel mutex is used for the ACPI mutex
> implementation instead of using semaphore?
> And it seems that too much ACPICA source code is touched.

In general you would want to use a mutex whenever your using mutex-like
semantics. If I see a mutex used in code then I have a pretty good idea
the locking is sane.. As Peter mentioned , you also get lockdep which
helps to find lots of different locking problems.

You can also look at Documentation/mutex-design.txt which has a fairly
big list of benefits over the semaphore. (tho when that was written the
semaphore implementation was different.)

Daniel

