From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 1/3] acpi: add real mutex function calls
Date: Wed, 23 Jul 2008 15:14:51 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B3B6925F@orsmsx415.amr.corp.intel.com>
References: <1216491411-24080-1-git-send-email-dwalker@mvista.com> <1216491411-24080-2-git-send-email-dwalker@mvista.com> <1216605078.4135.23.camel@yakui_zhao.sh.intel.com> <1216648574.2294.9.camel@dhcp32.mvista.com> <4884E177.5000809@linux.intel.com> <1216669184.2294.44.camel@dhcp32.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58547 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341AbYGWWPj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jul 2008 18:15:39 -0400
Content-class: urn:content-classes:message
In-reply-to: <1216669184.2294.44.camel@dhcp32.mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>, Andi Kleen <ak@linux.intel.com>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Brown, Len" <len.brown@intel.com>

We've already added ACPI_MUTEX and ACPI_SPINLOCK to ACPICA (split off
from ACPI_SEMAPHORE), essentially at the request of Linux. I really
would rather not add yet another type, for what looks like little gain.

As far as portability, this is always an important issue for ACPICA. I
am still getting complaints from other OSVs about the MUTEX and SPINLOCK
types that were added.

Bob



>-----Original Message-----
>From: Daniel Walker [mailto:dwalker@mvista.com]
>Sent: Monday, July 21, 2008 12:40 PM
>To: Andi Kleen
>Cc: Zhao, Yakui; linux-acpi@vger.kernel.org; Ingo Molnar; Peter
Zijlstra;
>Brown, Len; Moore, Robert
>Subject: Re: [PATCH 1/3] acpi: add real mutex function calls
>
>On Mon, 2008-07-21 at 21:20 +0200, Andi Kleen wrote:
>> Daniel Walker wrote:
>> > On Mon, 2008-07-21 at 09:51 +0800, Zhao Yakui wrote:
>> >> On Sat, 2008-07-19 at 11:16 -0700, Daniel Walker wrote:
>> >>> Instead of re-using semaphores for the mutex operation, I've
>> >>> added usage of the kernel mutex for the os mutex implementation.
>> >>>
>> >> What is the advantage that the kernel mutex is used for the ACPI
mutex
>> >> implementation instead of using semaphore?
>> >> And it seems that too much ACPICA source code is touched.
>> >
>> > In general you would want to use a mutex whenever your using
mutex-like
>> > semantics. If I see a mutex used in code then I have a pretty good
idea
>> > the locking is sane..
>>
>> With a mutex the locking can be totally broken and with a semaphore
the
>> locking can be completely fine. They are both just tools which can be
>> used correctly and also incorrectly.
>
>True ..
>
>> The main advantage of mutexes is that they can be slightly more
>> efficient (doesn't matter for the ACPI case, the ACPI interpreter is
not
>> performance critical) and that they are easier to check with lockdep.
>> But there are also other considerations like in ACPICA's case
>portability.
>
>The ACPI interpreter actually specifically implements a mutex in the
>AML. The interpreter wants a mutex, and not a semaphore. I'm not sure
>why your bringing up portability issues ..
>
>> My feeling is that adding own semaphore wrappers to ACPICA wouldn't
>> be an improvement. Defering to Bob Moore for his opinion, since
>> he maintains ACPICA.
>
>I'm not trying to mod the locking that ACPI internally does (which I
>think is mutex compatible) .. I'm just changing what the linux wrappers
>are calling .. The additional lockdep calls are linux specific but they
>aren't changing how the locking is already being done.
>
>Daniel

