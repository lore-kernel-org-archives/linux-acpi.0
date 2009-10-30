From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Help needed, Re: [Bug #14334] pcmcia suspend regression from
 2.6.31.1 to 2.6.31.2 - Dell Inspiron 600m
Date: Sat, 31 Oct 2009 10:57:21 +1100
Message-ID: <1256947041.6372.165.camel@pasglop>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera>
	 <6dRYo8ss7vL.A.EqH.Nse5KB@chimera> <200910301948.24473.rjw@sisk.pl>
	 <alpine.LFD.2.01.0910301228430.31845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933126AbZJ3X5g@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.01.0910301228430.31845@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jose Marino <braket@hotmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2009-10-30 at 12:47 -0700, Linus Torvalds wrote:
> 
> On Fri, 30 Oct 2009, Rafael J. Wysocki wrote:
> > 
> >
> > 1) Resume works if pcmcia_socket_dev_resume(dev) is moved to the "regular"
> >    resume phase, after resume_device_irqs().
> 
> Hmm. We really probably shouldn't call pcmcia_socket_dev_resume() in 
> early_resume. It takes mutexes etc, and it calls "socket_resume()", which 
> sleeps etc. That per se should be ok these days (since we don't actualyl 
> disable CPU irq's, just device irqs), but it also does that whole card 
> insertion events etc. And _that_ code I wouldn't trust at all.
> 
> The PCMCIA code is better than it used to be a long time ago, but some of 
> it is still pretty crazy. 
> 
> I get the feeling that we should just revert that commit 0c570cdeb, and 
> instead always do PCMCIA suspend as a "eject" event. That way we have no 
> driver behind it to resume at resume time - and we'll see any plugged-in 
> device as just a new insertion. 

To me the proper approach would be to split it so that

 - early_resume() restores power & config space etc... so that existing
devices can move on (might check for removal). There's no other hotplug
activity

 - normal resume() restarts handling of events such as insertions

Now, while I do have some cardbus & pcmcia stuff somewhere, I also don't
have much time to hack on this right now...

Cheers,
Ben.
