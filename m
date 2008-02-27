From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: new regression in 2.6.25-rc3: no keyboard/lid acpi events on
 thinkpad T61p
Date: Thu, 28 Feb 2008 00:20:01 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802280018310.3391@jikos.suse.cz>
References: <8f53421d0802251119q470a79c1p31048ef136271f84@mail.gmail.com>
 <20080225114611.d91791f6.akpm@linux-foundation.org> <20080226085403.GI17932@hjernemadsen.org>
 <20080226213200.GL17932@hjernemadsen.org> <Pine.LNX.4.64.0802262242070.7699@twin.jikos.cz>
 <20080227221342.GS17932@hjernemadsen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:38459 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751200AbYB0XUD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Feb 2008 18:20:03 -0500
In-Reply-To: <20080227221342.GS17932@hjernemadsen.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Klaus S. Madsen" <ksm@hjernemadsen.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Pavel Machek <pavel@ucw.cz>

On Wed, 27 Feb 2008, Klaus S. Madsen wrote:

> On Tue, Feb 26, 2008 at 22:44:13 +0100, Jiri Kosina wrote:
> > Hmm, just a random shot (shouldn't be the case, but just to be on the safe 
> > side) -- could you please try
> > 
> >         echo 0 > /proc/sys/kernel/randomize_va_space
> > 
> > to see whether it removes the segfault by any chance?
> Unfortunately this does not remove the segfault. I got a proper
> bisection result (82bc03fc158e28c90d7ed9919410776039cb4e14: x86: add PWT
> to NOCACHE flags), which I've reported in a new thread, as it really
> doesn't have anything to do with the original subject anymore. The
> subject of the new thread is:
> Regression in 2.6.25-rc3: s2ram segfaults before suspending

Thanks for bisecting this.

Please, don't forget to CC the author of the commit, whenever you finish 
your bisection (this time it is Ingo). Added to CC.

-- 
Jiri Kosina
SUSE Labs
