From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: Help needed, Re: [Bug #14334] pcmcia suspend regression from 2.6.31.1 to 2.6.31.2 - Dell Inspiron 600m
Date: Mon, 2 Nov 2009 19:40:25 +0100
Message-ID: <200911021940.25111.rjw@sisk.pl>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera> <200911021439.28266.rjw@sisk.pl> <20091102173843.GA662@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091102173843.GA662-S7uyTPAaJ/sb6pqDj42GsMgv3T4z79SOrE5yTffgRl4@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jose Marino <braket-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 02 November 2009, Dominik Brodowski wrote:
> Hey,
> 
> just two minor nit-pick which we could handle post-2.6.32:
> 
> > +++ linux-2.6/drivers/pcmcia/cs.c
> > @@ -98,10 +98,13 @@ EXPORT_SYMBOL(pcmcia_socket_list_rwsem);
> >   * These functions check for the appropriate struct pcmcia_soket arrays,
> >   * and pass them to the low-level functions pcmcia_{suspend,resume}_socket
> 
> ... some documentation of the new functions, especially whether other socket
> drivers should be updated?

OK, I'll post a separate patch for that for .33.

> > -static int socket_resume(struct pcmcia_socket *skt)
> > +static void socket_start_resume(struct pcmcia_socket *skt)
> >  {
> > -	int ret;
> > -
> > -	if (!(skt->state & SOCKET_SUSPEND))
> > -		return -EBUSY;
> > -
> >  	skt->socket = dead_socket;
> >  	skt->ops->init(skt);
> >  	skt->ops->set_socket(skt, &skt->socket);
> > +	if (skt->state & SOCKET_PRESENT)
> > +		skt->resume_status = socket_setup(skt, resume_delay);
> > +}
> >  
> > +static int socket_early_resume(struct pcmcia_socket *skt)
> > +{
> > +	socket_start_resume(skt);
> > +	return 0;
> > +}
> 
> Why do we need to have two functions doing the same? Wouldn't
> 
> static int socket_early_resume(...)
> 
> suffice, with the only call to socket_start_resume() being replaced with
> socket_early_resume()?

Yes, it would.  I'll do that in the final version of the patch.

Thanks,
Rafael
