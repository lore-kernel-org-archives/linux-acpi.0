From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [APIC] Kernel panic, rsync corruption, intel q8200, 2.6.28-rc8
Date: Tue, 3 Feb 2009 22:03:25 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0902032152180.22800@localhost.localdomain>
References: <4978767D.4060700@intertwingly.net> <20090130000758.1dff0113.akpm@linux-foundation.org> <498885CC.4060509@intertwingly.net> <20090203114849.b661f1ce.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:56885 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbZBCVDy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Feb 2009 16:03:54 -0500
In-Reply-To: <20090203114849.b661f1ce.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sam Ruby <rubys@intertwingly.net>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, x86@kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>

On Tue, 3 Feb 2009, Andrew Morton wrote:
> > >> [    0.296001] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> > >> [    0.296001] Kernel panic - not syncing: IO-APIC + timer doesn't work! 
Sigh.

> Not sure.  Perhaps platform_i386/platform_x86_64 would be correct.
> Can the x86 maintainers please advise?

Yup. That's correct

@Sam: I just checked, that your machine has a serial port. That's a
good start :)

Do you have a second computer around with a serial port ? If yes, then
please add the following to the kernel command line:

       earlyprintk=serial,ttyS0,115200 apic=debug

and connect the serial ports with a null modem cable. Fire up a
terminal program on the second machine and capture the output.

Thanks,

	tglx
