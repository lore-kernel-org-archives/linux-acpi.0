From: TJ <linux@tjworld.net>
Subject: Re: [patch 2.6.21-rc5-git 2/3] ACPI driver model flags and
	platform_enable_wake()
Date: Wed, 25 Jul 2007 22:18:51 +0100
Message-ID: <1185398331.10845.23.camel@bagoas>
References: <200704051249.10407.david-b@pacbell.net>
	 <200707251304.03191.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pella.tjworld.net ([72.249.12.25]:39006 "EHLO tjworld.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbXGYVS5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 17:18:57 -0400
In-Reply-To: <200707251304.03191.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

On Wed, 2007-07-25 at 13:04 -0700, David Brownell wrote:

> As I recall, Mattia Dongili <malattia@linux.it> reported an error
> with a Vaio laptop; it would wake immediately after entering STR.
> It didn't reproduce for anyone else.  But that was eventually tracked
> down to a bug in iwl3945, which has since been fixed (yes?).

I'm not sure if this might inform your thinking here but today I've just
tracked down a similar issue on another Sony Vaio (PCG-SRX51) where S3
STR immediately wakes.

I enabled ACPI_FUTURE_USAGE and called acpi_get_event_status()
immediately upon resume (before the wake flag is cleared) and iterated
each wake event.

I discovered that the PM timer event is the reason the system resumes
but so far haven't discovered why. I have a tenuous theory it could be
related to the kernel timer using the ACPI PM Timer. I tried disabling
that with the boot parameter 'nopmtimer' but that didn't help.

To test this I'm currently building a kernel that disables the PM Timer
wake event during suspend and re-enables it on resume, something the
ACPI specification hints at in section 4.7.2.1.

I'm not sure if this problem occurs on a wider range of systems than the
Sony since at present, without a debug kernel with ACPI_FUTURE_USAGE and
specific additional checks, there is no way to know the reason a system
resumed.

I'm planning on submitting a patch to log the wake event since it would
greatly enhance our abilities to diagnose reasons behind these
situations if the log showed it without a custom-kernel build.

TJ.

