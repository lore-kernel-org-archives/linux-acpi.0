From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 5/5] acpi: semaphore removal
Date: Thu, 7 Aug 2008 18:34:08 -0600
Message-ID: <20080808003408.GA8618@parisc-linux.org>
References: <1218121178-13779-1-git-send-email-dwalker@mvista.com> <1218121178-13779-2-git-send-email-dwalker@mvista.com> <1218121178-13779-3-git-send-email-dwalker@mvista.com> <1218121178-13779-4-git-send-email-dwalker@mvista.com> <1218121178-13779-5-git-send-email-dwalker@mvista.com> <1218121178-13779-6-git-send-email-dwalker@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:44009 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbYHHAe3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 20:34:29 -0400
Content-Disposition: inline
In-Reply-To: <1218121178-13779-6-git-send-email-dwalker@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Zhao Yakui <yakui.zhao@intel.com>, Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@elte.hu>

On Thu, Aug 07, 2008 at 07:59:43AM -0700, Daniel Walker wrote:
> The semaphore usage in ACPI is more like completions. The ASL
> functions getting implemented here are signals which follow a
> "wait for", signaled, or reset format.
> 
> This implements the ACPI signaling methods with the Linux
> completion API, instead of using semaphores.
> 
> completion_done() taken from Dave Chinner.

completion_done is an abomination.  Stop this.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
