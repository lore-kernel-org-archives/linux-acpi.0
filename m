From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: Help needed, Re: [Bug #14334] pcmcia suspend regression from 2.6.31.1 to 2.6.31.2 - Dell Inspiron 600m
Date: Mon, 2 Nov 2009 14:35:57 +0100
Message-ID: <200911021435.57884.rjw@sisk.pl>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera> <200911010936.10409.rjw@sisk.pl> <20091101164736.GA5666@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091101164736.GA5666-S7uyTPAaJ/sb6pqDj42GsMgv3T4z79SOrE5yTffgRl4@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jose Marino <braket-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sunday 01 November 2009, Dominik Brodowski wrote:
> Hey,
> 
> On Sun, Nov 01, 2009 at 09:36:10AM +0100, Rafael J. Wysocki wrote:
> > Commit 0c570cdeb8fdfcb354a3e9cd81bfc6a09c19de0c
> > (PM / yenta: Fix cardbus suspend/resume regression) caused resume to
> > fail on systems with two CardBus bridges.  While the exact nature
> > of the failure is not known at the moment, it can be worked around by
> > splitting the yenta resume into an early part, executed during the
> > early phase of resume, that will only resume the socket and power it
> > up if there was a card in it during suspend, and a late part,
> > executed during "regular" resume, that will carry out all of the
> > remaining yenta resume operations.
> > 
> > Fixes http://bugzilla.kernel.org/show_bug.cgi?id=14334, which is a
> > listed regression from 2.6.31.
> 
> The only issue I see is that we now return 0 unconditionally on the resume
> callbacks.

Hmm. pcmcia_socket_dev_suspend() and pcmcia_socket_dev_resume() return 0
unconditionally even without the patch, so it doesn't change that.

> Otherwise, it's
> 
> Acked-by: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>

Thanks!

Rafael
