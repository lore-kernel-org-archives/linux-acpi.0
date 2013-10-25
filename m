From: Adam Williamson <awilliam@redhat.com>
Subject: Re: [PATCH] x86/ACPI: Make Sony Vaio Z1 series to use "reboot=pci"
 default
Date: Fri, 25 Oct 2013 10:43:00 -0700
Message-ID: <1382722980.2445.13.camel@adam.happyassassin.net>
References: <1382597377-26797-1-git-send-email-tianyu.lan@intel.com>
	 <20131025105352.GA5419@gmail.com>
	 <1382719652.2445.1.camel@adam.happyassassin.net>
	 <CA+55aFyZEZp3CSFEcxzKt0c_7Q9_juGWiqb7VH214Fjcs3wUkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56381 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727Ab3JYRnO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Oct 2013 13:43:14 -0400
In-Reply-To: <CA+55aFyZEZp3CSFEcxzKt0c_7Q9_juGWiqb7VH214Fjcs3wUkQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Lan Tianyu <tianyu.lan@intel.com>, Matthew Garrett <mjg@redhat.com>, Peter Anvin <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Robin Holt <holt@sgi.com>, davej@fedoraproject.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, 2013-10-25 at 18:16 +0100, Linus Torvalds wrote:
> On Fri, Oct 25, 2013 at 5:47 PM, Adam Williamson <awilliam@redhat.com> wrote:
> >
> > I don't, but one comment I could add is that reboot _used_ to work okay
> > on the Z1. And I _think_ it's worked OK since the April 2011 commit you
> > mention (so the introduction of that didn't break it), but I can't
> > absolutely swear to it.
> 
> It might be interesting to try, and if it used to work with the acpi
> method, use bisection to see when it stopped working..

Yeah, I knew that'd be the reply :) I'll try and dig out some old kernel
builds from Koji and see if I can at least pinpoint when it last worked,
and if it really _was_ after the ACPI method landed.
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
http://www.happyassassin.net

