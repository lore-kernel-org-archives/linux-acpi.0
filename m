From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: Help needed, Re: [Bug #14334] pcmcia suspend regression from 2.6.31.1 to 2.6.31.2 - Dell Inspiron 600m
Date: Sat, 31 Oct 2009 10:31:17 +0100
Message-ID: <200910311031.17660.rjw@sisk.pl>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera> <alpine.LFD.2.01.0910301228430.31845@localhost.localdomain> <1256947041.6372.165.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1256947041.6372.165.camel@pasglop>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jose Marino <braket-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday 31 October 2009, Benjamin Herrenschmidt wrote:
> On Fri, 2009-10-30 at 12:47 -0700, Linus Torvalds wrote:
> > 
> > On Fri, 30 Oct 2009, Rafael J. Wysocki wrote:
> > > 
> > >
> > > 1) Resume works if pcmcia_socket_dev_resume(dev) is moved to the "regular"
> > >    resume phase, after resume_device_irqs().
> > 
> > Hmm. We really probably shouldn't call pcmcia_socket_dev_resume() in 
> > early_resume. It takes mutexes etc, and it calls "socket_resume()", which 
> > sleeps etc. That per se should be ok these days (since we don't actualyl 
> > disable CPU irq's, just device irqs), but it also does that whole card 
> > insertion events etc. And _that_ code I wouldn't trust at all.
> > 
> > The PCMCIA code is better than it used to be a long time ago, but some of 
> > it is still pretty crazy. 
> > 
> > I get the feeling that we should just revert that commit 0c570cdeb, and 
> > instead always do PCMCIA suspend as a "eject" event. That way we have no 
> > driver behind it to resume at resume time - and we'll see any plugged-in 
> > device as just a new insertion. 
> 
> To me the proper approach would be to split it so that

Well, agreed, but ...

>  - early_resume() restores power & config space etc... so that existing
> devices can move on (might check for removal). There's no other hotplug
> activity

... that's exactly what doesn't work at the moment.

Thanks,
Rafael
