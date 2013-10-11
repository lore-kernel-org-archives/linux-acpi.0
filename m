From: Borislav Petkov <bp@alien8.de>
Subject: Re: Extended H/W error log driver
Date: Fri, 11 Oct 2013 10:04:27 +0200
Message-ID: <20131011080427.GC18719@pd.tnic>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:44005 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756815Ab3JKIEe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Oct 2013 04:04:34 -0400
Content-Disposition: inline
In-Reply-To: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Oct 11, 2013 at 02:32:38AM -0400, Chen, Gong wrote:
> [56005.785917] {3}Hardware error detected on CPU0
> [56005.785959] {3}event severity: corrected
> [56005.785975] {3}sub_event[0], severity: corrected
> [56005.785977] {3}section_type: memory error
> [56005.785981] {3}physical_address: 0x0000000851fe0000
> [56005.786027] {3}DIMM location: Memriser1 CHANNEL A DIMM 0

Very good guys, I've been waiting for years for this to be possible,
good job! :-)

Btw, what's "Memriser1"?

> [56005.786154] {4}Hardware error detected on CPU0
> [56005.786159] {4}event severity: corrected
> [56005.786162] {4}sub_event[0], severity: corrected

This sub_event[0] could use better decoding though.

> [56005.786166] {4}section_type: memory error
> 
> 
> trace output:
> 
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 4/4   #P:120
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
> ...
> ...
>           <idle>-0     [000] d.h. 56068.488759: extlog_mem_event: 3 corrected errors:unknown

That "unknown" thing needs a " " in front of it and comes from
cper_mem_err_type_str, AFAICT. I'm guessing the value is 0 and
uninitialized or so?

> on Memriser1 CHANNEL A DIMM 0(FRU:

Also another " " missing here.

> 00000000-0000-0000-0000-000000000000  physical addr: 0x0000000851fe0000 node: 0 card: 0 module: 0 rank: 0 bank: 0 row: 28927 column: 1296)
>           <idle>-0     [000] d.h. 56068.488834: extlog_mem_event: 4 corrected errors:unknown
> ...
> ...
> 
> dmesg output are shrank to only keep the most important data. The trace
> output will contain most of data. Not sure if all fields are meaningful
> to users. Some fields like FRU ID/FRU TEXT depends on BIOS manufactor.
> So welcome to add comments for what is needed or not.

Yeah, I guess we again depend on BIOS people to fill those in. I'd
expect serious server manifacturers who care about RAS to do so...

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
