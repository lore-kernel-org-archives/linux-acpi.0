From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 1/3] acpi: add real mutex function calls
Date: Mon, 21 Jul 2008 13:38:26 -0700
Message-ID: <1216672706.2294.67.camel@dhcp32.mvista.com>
References: <1216491411-24080-1-git-send-email-dwalker@mvista.com>
	 <1216491411-24080-2-git-send-email-dwalker@mvista.com>
	 <1216605078.4135.23.camel@yakui_zhao.sh.intel.com>
	 <1216631698.7257.29.camel@twins>  <48845425.9000607@linux.intel.com>
	 <1216632297.7257.31.camel@twins>  <4884E063.8080908@linux.intel.com>
	 <1216668835.7257.91.camel@twins>  <4884EAF1.4050901@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:64691 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYGUUib (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jul 2008 16:38:31 -0400
In-Reply-To: <4884EAF1.4050901@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, len.brown@intel.com, Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <matthew@wil.cx>

On Mon, 2008-07-21 at 22:00 +0200, Andi Kleen wrote:

> Now if mutexes were possible (AFAIK that's not possible in the general
> case) then that would work too. But using "completions" as the low
> level API doesn't make sense to me because it'll just lead to higher
> level locking code being reinvented and also because it's unlikely
> anything else has those with these semantics.

The completions should only be used by the interpreter to implement the
ASL style signals which fit completions really well (that was my goal
anyway)..

> I think what would make sense is to identify the locks in ACPICA
> which only have mutex semantics and convert them to a new osl mutex 
> abstraction. Then at least some of the locks could get lockdep
> checking.

To an extent that's already done .. There is a osl mutex abstraction
which just uses semaphores. I switched that over to use a mutex ..

Those areas that already used the osl mutex abstraction should now be
using the actual linux mutex.

> On the other hand to be honest I'm not looking forward to handle
> the usual 90+% false positives that you get out of lockdep ...
> 
> > Clearly this all wasn't extremely clear from the code - otherwise Daniel
> > wouldn't even have done these patches.
> > 
> >> Especially now that semaphores are not duplicated per architecture 
> >> anymore so actually keeping them around is not that costly.
> > 
> > Having them around might give people the idea its a good idea to use
> > them. Not having them around is a good way to discourage that.

I agree with Peter here.. I've seen a lot of bad locking, and I think we
really need explicit checks over just code review.

Daniel

