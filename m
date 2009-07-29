From: Len Brown <lenb@kernel.org>
Subject: Re: Dynamic configure max_cstate
Date: Tue, 28 Jul 2009 20:17:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907282014030.17102@localhost.localdomain>
References: <20090727073338.GA12669@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:57297 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbZG2ARc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jul 2009 20:17:32 -0400
In-reply-to: <20090727073338.GA12669@rhlx01.hs-esslingen.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org



thanks,
Len Brown, Intel Open Source Technology Center

On Mon, 27 Jul 2009, Andreas Mohr wrote:

> Hi,
> 
> > When running a fio workload, I found sometimes cpu C state has
> > big impact on the result. Mostly, fio is a disk I/O workload
> > which doesn't spend much time with cpu, so cpu switch to C2/C3
> > freqently and the latency is big.
> 
> Rather than inventing ways to limit ACPI Cx state usefulness, we should
> perhaps be thinking of what's wrong here.
> 
> And your complaint might just fit into a thought I had recently:
> are we actually taking ACPI Cx exit latency into account, for timers???

Yes.
menu_select() calls tick_nohz_get_sleep_length() specifically
to compare the expiration of the next timer vs. the expected sleep length.

The problem here is likely that the expected sleep length
is shorter than expected, for IO interrupts are not timers...
Thus we add long deep C-state wakeup time to the IO interrupt latency...

-Len Brown, Intel Open Source Technology Center

