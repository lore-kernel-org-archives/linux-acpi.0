From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [APIC] Kernel panic, rsync corruption, intel q8200, 2.6.28-rc8
Date: Fri, 30 Jan 2009 00:07:58 -0800
Message-ID: <20090130000758.1dff0113.akpm@linux-foundation.org>
References: <4978767D.4060700@intertwingly.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53560 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751521AbZA3IIf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jan 2009 03:08:35 -0500
In-Reply-To: <4978767D.4060700@intertwingly.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sam Ruby <rubys@intertwingly.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, 22 Jan 2009 08:37:01 -0500 Sam Ruby <rubys@intertwingly.net> wrote:

> Hardware summary: http://tinyurl.com/ap79ra
> APIC details: http://intertwingly.net/stories/2009/01/22/
> Note acpidump.err: Wrong checksum for OEMB!
> 
> Messages on boot using Intrepid, Jaunty Alpha 3, or Fedora 10:
> 
> [    0.296001] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> [    0.296001] Kernel panic - not syncing: IO-APIC + timer doesn't work! 
>   Boot with apic=debug and send a report.  Then try booting with the 
> 'noapic' option.
> [    0.296001]
> 
> Able to get past this issue using "noapic", at which point things mostly 
> work,

Join the ever-growing noapic club :(

I assume this is an ACPI problem.  Or at least, a BIOS problem which
ACPI can solve for us.

> but rsync of large iso images result in corrupt files.  Able to 
> copy those same files using Vista on the same machine, or using Hardy on 
> another machine.  This problem may not be related to the above, but it 
> seems plausible to me that this might be an interrupt issue.

Yes, it might be unrelated.  There are no kernel messages when it happens?

> memtest86+ runs clean.
> 
> Quite willing to invest time in installing kernels or distributions on 
> fresh hard drives, run tests, obtain debug information, and report back.
> 
> More background here: http://intertwingly.net/blog/2009/01/20/noAPIC
> 
> Not subscribed, but will actively monitor the web archives for this 
> mailing list for the next several days.

It'd be best to raise a report against ACPI?BIOS (I think) at
bugzilla.kernel.org, please.

If any previous kernel version worked OK, please be sure to note that.

Thanks.

