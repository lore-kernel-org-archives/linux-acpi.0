From: Andi Kleen <andi@firstfloor.org>
Subject: Re: acpi_idle: Very idle Core i7 machine never enters C3
Date: Tue, 26 Jan 2010 22:45:20 +0100
Message-ID: <87y6jkee1b.fsf@basil.nowhere.org>
References: <20100126084740.GA5265@jgarrett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:56826 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546Ab0AZVpW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2010 16:45:22 -0500
In-Reply-To: <20100126084740.GA5265@jgarrett.org> (Jeff Garrett's message of "Tue, 26 Jan 2010 02:47:40 -0600")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Garrett <jeff@jgarrett.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

jeff@jgarrett.org (Jeff Garrett) writes:

> Hi,
>
> I was trying to chase down a theory that my desktop machine (a core i7)
> is running warm (the fan sounds like it's at full speed all the time,
> and I think it's not always acted this way -- hence the theory).
>
> powertop is never showing it spending any time in C3...
>
> I compiled a kernel without USB/sound/radeon, and ran without X.  I was
> able to get the wakeups/sec down below 20, but no time is spent in C3.

[...]
> This may be a complete red herring, but I added some printk logic to
> acpi_idle_bm_check(), and it is getting called often, but bm_status is
> always 1.  [I infer from this that the idle logic is trying to go into
> C3, but this check is stopping it...  Unless I misread something.]

Normally a Core i7 (or any modern Intel systems) should not use
bm_check at all. That's only for older systems that didn't support
MWAIT with c-state hint, but relied on the old port based interface. 

So something is already confused there.

I think it should still work though.
Of course if you really have a lot of bus mastering in the background
then yes there will be no C3.

-Andi


-- 
ak@linux.intel.com -- Speaking for myself only.
