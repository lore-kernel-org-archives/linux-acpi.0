From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: Help needed, Re: [Bug #14334] pcmcia suspend regression from 2.6.31.1 to 2.6.31.2 - Dell Inspiron 600m
Date: Fri, 30 Oct 2009 23:17:25 +0100
Message-ID: <200910302317.26024.rjw@sisk.pl>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera> <alpine.LFD.2.01.0910301335570.31845@localhost.localdomain> <alpine.LFD.2.01.0910301412500.31845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.01.0910301412500.31845-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jose Marino <braket-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 30 October 2009, Linus Torvalds wrote:
> 
> On Fri, 30 Oct 2009, Linus Torvalds wrote:
> > 
> > And partly exactly _because_ even Cardbus is starting to be "legacy", I'd 
> > personally prefer to try to simplify the model to the point where we don't 
> > have to think about all the subtle interactions. Just making suspend act 
> > as an eject would mean that we'd never have to worry about how the CardBus 
> > bridge interacts with the PCI layer at suspend/resume time.
> 
> Put another way: five years ago I would have felt that it could be 
> important that people can suspend and resume while they have a CD-ROM 
> mounted through a PCMCIA IDE card. Or something like that where you want 
> to keep session information.
> 
> These days, that scenario is less interesting to begin with, and we're 
> generally better at some of the hotplug issues anyway. Example: one of the 
> reasons I used to like not causing an unplug event was because I had 
> network cards, and hated setting up the connection again. These days, all 
> distros come with networkmanager or similar, and hotplug networking just 
> works (even if the "CD-ROM mounted" case probably still would cause 
> problems).
> 
> So I think we used to have good reasons to try to maintain state over a 
> suspend event, but many of those reasons have become weaker, while at the 
> same time USB has meant that PCMCIA itself has become more of a 
> "maintenance burden" rather than a "primary subsystem".

I agree.

Rafael
