From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] acpi: add real mutex function calls
Date: Mon, 21 Jul 2008 11:14:58 +0200
Message-ID: <1216631698.7257.29.camel@twins>
References: <1216491411-24080-1-git-send-email-dwalker@mvista.com>
	 <1216491411-24080-2-git-send-email-dwalker@mvista.com>
	 <1216605078.4135.23.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:54747 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703AbYGUJPD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jul 2008 05:15:03 -0400
In-Reply-To: <1216605078.4135.23.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Daniel Walker <dwalker@mvista.com>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, len.brown@intel.com, ak@linux.intel.com

On Mon, 2008-07-21 at 09:51 +0800, Zhao Yakui wrote:
> On Sat, 2008-07-19 at 11:16 -0700, Daniel Walker wrote:
> > Instead of re-using semaphores for the mutex operation, I've
> > added usage of the kernel mutex for the os mutex implementation.
> > 
> What is the advantage that the kernel mutex is used for the ACPI mutex
> implementation instead of using semaphore?
> And it seems that too much ACPICA source code is touched.

You get help from lockdep, and also our goal is to fully eradicate
semaphore usage.

