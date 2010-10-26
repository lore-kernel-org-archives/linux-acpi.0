From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [NAK] Re: [PATCH -v2 9/9] ACPI, APEI, Generic Hardware Error
 Source POLL/IRQ/NMI notification type support
Date: Tue, 26 Oct 2010 10:38:07 +0200
Message-ID: <20101026083806.GA14103@basil.fritz.box>
References: <1287992610-14996-1-git-send-email-ying.huang@intel.com>
 <1287992610-14996-10-git-send-email-ying.huang@intel.com>
 <20101025084553.GA27119@elte.hu>
 <alpine.LFD.2.00.1010252058370.11036@localhost.localdomain>
 <alpine.LFD.2.00.1010260629560.3955@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:58152 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab0JZIiM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2010 04:38:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010260629560.3955@localhost6.localdomain6>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Huang Ying <ying.huang@intel.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Borislav Petkov <petkovbb@googlemail.com>, "H. Peter Anvin" <hpa@zytor.com>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Luck <tony.luck@intel.com>

> So please explain why your error reporting is so different from the
> above that it justifies a separate facility. And you better come up
> with a real good explanation other than we looked at EDAC and it did
> not fit our needs.

Well it didn't fit the needs at all.  Is that not enough, Mr Inquisitor?

Really if you want to nack and maintain and design things you need
to do a bit more than just arguing from two lines of
high level description.

EDAC enumerates hardware and exports some hardware
registers and decodes a few errors in a format into
the kernel log that is hard to impossible to post-process.

APEI does nothing of that, so it doesn't fit into EDAC.

perf does small parts of it, but a lot of things that are needed
it doesn't do either. And for the things it does it's incredible 
overkill in terms of code size, overhead etc. for the task
at hand.

Basically the only facility in perf that could 
be reused is a simple message passing layer, which 
is only a few tens lines of code anyways, but only
at the cost of doing a lot of changes to get the right
semantics out of it.

The main interface in APEI right now is to manage fatal
errors after reboot. Short of making it a file system,
which didn't really fit either, there's no existing interface
that handles that in a half way sensible way.
 
There's some other stuff but it's reasonably small too.

-Andi
