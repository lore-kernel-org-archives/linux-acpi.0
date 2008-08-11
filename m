From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.27-rc0 Power Bugs with HP/Compaq Laptops
Date: Mon, 11 Aug 2008 19:18:49 +0200
Message-ID: <20080811171849.GN4524@elte.hu>
References: <680ad8bc0808070757u49e13b3br1f69fb4881dc44ce@mail.gmail.com> <200808072300.21771.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:44898 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498AbYHKRTN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Aug 2008 13:19:13 -0400
Content-Disposition: inline
In-Reply-To: <200808072300.21771.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matt Parnell <mparnell@gmail.com>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>


> > "This is not the right fix. Instead, HPET should be used as a timer 
> > source for dynticks. This is not in 2.6.26, but I tried the 
> > linux-next tree (google it) and it looked like dynticks worked fine, 
> > without disabling C1E. Can't place my finger on the exact commit, 
> > but you could check."

Would be nice to figure out which exact change solves the problem, so 
that we could fast-route it into v2.6.27. (and for eventual .26 and .25 
backporting, if it's simple enough)

first thing would be to check whether tip/master works fine:

  http://people.redhat.com/mingo/tip.git/README

if that works fine it would be nice to check whether the pending changes 
in tip/timers/hpet solves this particular issue. That can be done by:

  git-checkout -b tmp.test tip/timers/hpet

[ once you have set up tip as a remote repository, as described in the 
  README above. ]

If tip/timers/hpet solves the problem then it's one of these five 
commits that solves it:

 f92a789: hpet: /dev/hpet - fixes and cleanup, fix
 64a76f6: hpet: /dev/hpet - fixes and cleanup
 f356181: x86: add PCI ID for 6300ESB force hpet
 3243b4e: x86: add another PCI ID for ICH6 force-hpet
 70ef6d5: x86: get irq for hpet timer

	Ingo
