From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: Help needed, Re: [Bug #14334] pcmcia suspend regression from 2.6.31.1 to 2.6.31.2 - Dell Inspiron 600m
Date: Sat, 31 Oct 2009 23:10:24 +0100
Message-ID: <200910312310.24180.rjw@sisk.pl>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera> <200910312252.39446.rjw@sisk.pl> <alpine.LFD.2.01.0910311455520.31845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.01.0910311455520.31845-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jose Marino <braket-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday 31 October 2009, Linus Torvalds wrote:
> 
> On Sat, 31 Oct 2009, Rafael J. Wysocki wrote:
> > 
> > Yes, there is, because socket_early_resume() only does it in
> > the (skt->state & SOCKET_PRESENT) case.  If that bit is not set, the
> > initialization is entirely postponed.
> 
> Ahh, ok. And what's the reason for that? It seems like the 
> 
> 	skt->socket = dead_socket;
> 	skt->ops->init(skt);
> 	skt->ops->set_socket(skt, &skt->socket);
> 
> thing should always be safe, whether there is something present or not.. ?

It should, but I'm not sure given the reported behavior so far.

I guess I'll prepare another patch that does this unconditionally in the
early phase and let's see how that works.

Rafael
