From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Preserve task state in reentrant calls to ___wait_event
Date: Sat, 7 Nov 2015 10:19:54 +0100
Message-ID: <20151107091954.GE17308@twins.programming.kicks-ass.net>
References: <20151106204408.GA11609@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37209 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbbKGJUA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2015 04:20:00 -0500
Content-Disposition: inline
In-Reply-To: <20151106204408.GA11609@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lv.zheng@intel.com, mingo@redhat.com, rjw@rjwysocki.net, oleg@redhat.com, aystarik@gmail.com

On Fri, Nov 06, 2015 at 08:44:08PM +0000, Chris Bainbridge wrote:
> I am assuming here that wait_event_timeout() is supposed to support reentrant
> calls.

Not really. It is sort of allowed, provided the inner one will rarely
block. And therefore the outer one will mostly work.

> If not, perhaps it should BUG_ON when called with a non-running task
> state,

There is a warning in __might_sleep() that catches some of this.

> and the SBS HC / ACPI EC code needs to be fixed to stop doing this.

Yes.
