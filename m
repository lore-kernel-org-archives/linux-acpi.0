From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 1/3] acpi: add real mutex function calls
Date: Mon, 21 Jul 2008 13:55:45 -0600
Message-ID: <20080721195545.GI24246@parisc-linux.org>
References: <1216491411-24080-1-git-send-email-dwalker@mvista.com> <1216491411-24080-2-git-send-email-dwalker@mvista.com> <1216605078.4135.23.camel@yakui_zhao.sh.intel.com> <1216631698.7257.29.camel@twins> <48845425.9000607@linux.intel.com> <1216632297.7257.31.camel@twins> <4884E063.8080908@linux.intel.com> <1216668835.7257.91.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:43408 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbYGUT4C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jul 2008 15:56:02 -0400
Content-Disposition: inline
In-Reply-To: <1216668835.7257.91.camel@twins>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>, Zhao Yakui <yakui.zhao@intel.com>, Daniel Walker <dwalker@mvista.com>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, len.brown@intel.com, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Jul 21, 2008 at 09:33:55PM +0200, Peter Zijlstra wrote:
> Does ACPICA use counting semaphores? If so, you could have used real
> arguments against his patches, instead of this other-os bull.

Yep.  In theory, it allows for a more powerful implementation than
Linux's semaphores (allowing you to do the equivalent of init_sem(5);
down(1); down(3); down(2); and have the third down() block until there's
two units available).  In practice, no ACPI code is asking for more than
one unit at a time.

> Also, what is the justification for using counting semaphores? Are we
> counting hardware slots or is it just generic ACPI braindamage?

It's the interface that AML is allowed to use, iirc.  So short of
revising the spec ... we have no idea how hardware are using it.

> Clearly this all wasn't extremely clear from the code - otherwise Daniel
> wouldn't even have done these patches.

Some people get religion about a topic and push pointless patches
anyway.

> > Especially now that semaphores are not duplicated per architecture 
> > anymore so actually keeping them around is not that costly.
> 
> Having them around might give people the idea its a good idea to use
> them. Not having them around is a good way to discourage that.

We'll end up making completions be more of a mess than semaphores ever
were or pushing semaphore implementations into every user that really
wanted a counting semaphore implementation.  People need to drop this
crusade, it's causing more harm than good.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
