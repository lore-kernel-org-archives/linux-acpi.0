From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 1/3] acpi: add real mutex function calls
Date: Mon, 21 Jul 2008 13:22:11 -0700
Message-ID: <1216671731.2294.54.camel@dhcp32.mvista.com>
References: <1216491411-24080-1-git-send-email-dwalker@mvista.com>
	 <1216491411-24080-2-git-send-email-dwalker@mvista.com>
	 <1216605078.4135.23.camel@yakui_zhao.sh.intel.com>
	 <1216631698.7257.29.camel@twins> <48845425.9000607@linux.intel.com>
	 <1216632297.7257.31.camel@twins> <4884E063.8080908@linux.intel.com>
	 <1216668835.7257.91.camel@twins>  <20080721195545.GI24246@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:56416 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672AbYGUUWP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jul 2008 16:22:15 -0400
In-Reply-To: <20080721195545.GI24246@parisc-linux.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Peter Zijlstra <peterz@infradead.org>, Andi Kleen <ak@linux.intel.com>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, len.brown@intel.com, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, 2008-07-21 at 13:55 -0600, Matthew Wilcox wrote:
> > > Especially now that semaphores are not duplicated per
> architecture 
> > > anymore so actually keeping them around is not that costly.
> > 
> > Having them around might give people the idea its a good idea to use
> > them. Not having them around is a good way to discourage that.
> 
> We'll end up making completions be more of a mess than semaphores ever
> were or pushing semaphore implementations into every user that really
> wanted a counting semaphore implementation.  People need to drop this
> crusade, it's causing more harm than good.

I'm not trying to push that .. I would like it if completions stayed
roughly the same, and the code using semaphores was changed to use
mutexes, instead of making completions look like semaphores ..

Daniel

