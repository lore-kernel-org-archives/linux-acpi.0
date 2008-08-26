From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 4/4] acpi: semaphore removal
Date: Tue, 26 Aug 2008 12:30:46 -0700
Message-ID: <1219779046.3797.12.camel@dhcp32.mvista.com>
References: <1219777186-4787-1-git-send-email-dwalker@mvista.com>
	 <1219777186-4787-2-git-send-email-dwalker@mvista.com>
	 <1219777186-4787-3-git-send-email-dwalker@mvista.com>
	 <1219777186-4787-4-git-send-email-dwalker@mvista.com>
	 <20080826191335.GE23698@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:1352 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbYHZTau (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Aug 2008 15:30:50 -0400
In-Reply-To: <20080826191335.GE23698@parisc-linux.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

On Tue, 2008-08-26 at 13:13 -0600, Matthew Wilcox wrote:
> On Tue, Aug 26, 2008 at 11:59:49AM -0700, Daniel Walker wrote:
> > The semaphore usage in ACPI is more like completions. The ASL
> 
> Huh?  They are semaphores.  They're not 'more like completions' at all.

You can clearly make a completion out of a semaphore, but we have a
completion API .. ACPI is using locked semaphores, and essentially
re-making completions with the semaphore API..

Daniel

