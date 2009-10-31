From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Help needed, Re: [Bug #14334] pcmcia suspend regression from
 2.6.31.1 to 2.6.31.2 - Dell Inspiron 600m
Date: Sun, 01 Nov 2009 09:56:15 +1100
Message-ID: <1257029775.7907.21.camel@pasglop>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera>
	 <200910311031.17660.rjw@sisk.pl> <1257022890.7907.14.camel@pasglop>
	 <200910312227.15493.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200910312227.15493.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jose Marino <braket-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2009-10-31 at 22:27 +0100, Rafael J. Wysocki wrote:

> In the meantime I invented a patch that works, ie. apparently fixes the problem
> and if there was a card in the socket during the suspend, it's standard config
> space is restored correctly.  I tested it on one of my boxes with two different
> CardBus adapters and Jose says it fixes the problem for him.
> 
> The patch is appended, please have a look.

Base idea of the patch sounds good, quick browse through looks good too,

I'll try to band on it with various PCMCIA & CB gear tomorrow.

Cheers,
Ben.
