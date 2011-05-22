From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH 5/9] HWPoison: add memory_failure_queue()
Date: Sun, 22 May 2011 16:14:23 +0800
Message-ID: <BANLkTi=5Y0fqsmhsoPm8si=nQBc-tCwtrw@mail.gmail.com>
References: <1305619719-7480-1-git-send-email-ying.huang@intel.com>
	<1305619719-7480-6-git-send-email-ying.huang@intel.com>
	<20110517084622.GE22093@elte.hu>
	<4DD23750.3030606@intel.com>
	<20110517092620.GI22093@elte.hu>
	<4DD31C78.6000209@intel.com>
	<20110520115614.GH14745@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37386 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab1EVIOY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 May 2011 04:14:24 -0400
In-Reply-To: <20110520115614.GH14745@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>

On Fri, May 20, 2011 at 7:56 PM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Huang Ying <ying.huang@intel.com> wrote:
>
>> > So why are we not working towards integrating this into our event
>> > reporting/handling framework, as i suggested it from day one on when you
>> > started posting these patches?
>>
>> The memory_failure_queue() introduced in this patch is general, that is, it
>> can be used not only by ACPI/APEI, but also any other hardware error
>> handlers, including your event reporting/handling framework.
>
> Well, the bit you are steadfastly ignoring is what i have made clear well
> before you started adding these facilities: THEY ALREADY EXISTS to a large
> degree :-)
>
> So you were and are duplicating code instead of using and extending existing
> event processing facilities. It does not matter one little bit that the code
> you added is partly 'generic', it's still overlapping and duplicated.

How to do hardware error recovering in your perf framework?  IMHO,  it
can be something as follow:

- NMI handler run for the hardware error, where hardware error
information is collected and put into a ring buffer, an irq_work is
triggered for further work
- In irq_work handler, memory_failure_queue() is called to do the real
recovering work for recoverable memory error in ring buffer.

What's your idea about hardware error recovering in perf?

Best Regards,
Huang Ying
