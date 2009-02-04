From: Len Brown <lenb@kernel.org>
Subject: Re: [APIC] Kernel panic, rsync corruption, intel q8200, 2.6.28-rc8
Date: Tue, 03 Feb 2009 23:35:33 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902032332190.5607@localhost.localdomain>
References: <4978767D.4060700@intertwingly.net>
 <20090130000758.1dff0113.akpm@linux-foundation.org>
 <498885CC.4060509@intertwingly.net>
 <20090203114849.b661f1ce.akpm@linux-foundation.org>
 <alpine.LFD.2.00.0902032152180.22800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:26550 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbZBDEfh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2009 23:35:37 -0500
In-reply-to: <alpine.LFD.2.00.0902032152180.22800@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Sam Ruby <rubys@intertwingly.net>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, x86@kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>


> > > >> [    0.296001] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> > > >> [    0.296001] Kernel panic - not syncing: IO-APIC + timer doesn't work! 

just for the record, check_timer() is x86 IO-APIC code, not ACPI code.
So if the machine actually has MPS support, you'll probably get the 
same result with "acpi=off".  (of course if it doesn't have MPS,
then acpi=off would boot in uniprocessor legacy PIC mode)

cheers,
-Len

