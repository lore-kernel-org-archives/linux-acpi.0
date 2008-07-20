From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 2/3] acpi: semaphore removal
Date: Sun, 20 Jul 2008 07:49:02 -0700
Message-ID: <1216565342.3978.166.camel@localhost.localdomain>
References: <1216491411-24080-1-git-send-email-dwalker@mvista.com>
	 <1216491411-24080-2-git-send-email-dwalker@mvista.com>
	 <1216491411-24080-3-git-send-email-dwalker@mvista.com>
	 <20080720081512.GC5947@disturbed>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:13859 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbYGTOtG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Jul 2008 10:49:06 -0400
In-Reply-To: <20080720081512.GC5947@disturbed>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, len.brown@intel.com, ak@linux.intel.com

On Sun, 2008-07-20 at 18:15 +1000, Dave Chinner wrote:
> On Sat, Jul 19, 2008 at 11:16:53AM -0700, Daniel Walker wrote:
> > The semaphore is used pretty extensively in acpi, but the actual
> > usage model is really more like completions. The ASL functions
> > getting implemented here are signals which follow a "wait for",
> > signaled, or rest format.
> > 
> > This implements the ACPI signaling methods with the Linux
> > completion API, instead of using semaphores.
> > 
> > completion_done() taken from Dave Chinner.
> 
> The patch series that contained completion_done() is (AFAIK)
> in the -mm tree at the moment. You'd probably do best to keep
> it as a separate patch in your series so we don't end up with
> random conflicts all over the place....

Yeah,  I will eventually pull it out .. I'm not too worried about it,
since these patches are a ways from even going into -mm ..

Daniel

