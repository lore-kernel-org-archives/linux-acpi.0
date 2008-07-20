From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/3] acpi: semaphore removal
Date: Sun, 20 Jul 2008 18:15:12 +1000
Message-ID: <20080720081512.GC5947@disturbed>
References: <1216491411-24080-1-git-send-email-dwalker@mvista.com> <1216491411-24080-2-git-send-email-dwalker@mvista.com> <1216491411-24080-3-git-send-email-dwalker@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ipmail01.adl6.internode.on.net ([203.16.214.146]:55576 "EHLO
	ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751767AbYGTIPS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jul 2008 04:15:18 -0400
Content-Disposition: inline
In-Reply-To: <1216491411-24080-3-git-send-email-dwalker@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, len.brown@intel.com, ak@linux.intel.com

On Sat, Jul 19, 2008 at 11:16:53AM -0700, Daniel Walker wrote:
> The semaphore is used pretty extensively in acpi, but the actual
> usage model is really more like completions. The ASL functions
> getting implemented here are signals which follow a "wait for",
> signaled, or rest format.
> 
> This implements the ACPI signaling methods with the Linux
> completion API, instead of using semaphores.
> 
> completion_done() taken from Dave Chinner.

The patch series that contained completion_done() is (AFAIK)
in the -mm tree at the moment. You'd probably do best to keep
it as a separate patch in your series so we don't end up with
random conflicts all over the place....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
