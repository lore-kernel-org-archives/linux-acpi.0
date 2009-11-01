From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: Help needed, Re: [Bug #14334] pcmcia suspend regression from
 2.6.31.1 to 2.6.31.2 - Dell Inspiron 600m
Date: Sun, 1 Nov 2009 09:18:12 -0800 (PST)
Message-ID: <alpine.LFD.2.01.0911010914100.31845@localhost.localdomain>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera> <200911010010.07394.rjw@sisk.pl> <200911010024.12081.rjw@sisk.pl> <200911010936.10409.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200911010936.10409.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jose Marino <braket-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



On Sun, 1 Nov 2009, Rafael J. Wysocki wrote:
> 
> If people don't object, I'll push it through the suspend-2.6 tree along 
> with a few other bug fixes.

No objections, but a cleanup request:

> +static int socket_early_resume(struct pcmcia_socket *skt)
> +{
> +	if (skt->state & SOCKET_SUSPEND)
> +		socket_start_resume(skt);
> +
> +	return 0;
> +}
> +
> +static int socket_late_resume(struct pcmcia_socket *skt)
> +{
> +	if (!(skt->state & SOCKET_SUSPEND))
> +		return 0;

As far as I can tell, that "SOCKET_SUSPEND" test is totally pointless. 
That socket _is_ going to be suspended, and testing for it here just seems 
to confuse things. 

So I'd remove it from both early_resume and late_resume, and only keep it 
in the case of the legacy user-requested suspend/resume (do we even do 
that any more?).

The SOCKET_SUSPEND flag itself is still relevant, of course, since the 
state change handling will test it (in order to avoid insert/remove 
handlign while we have the suspend flag set). It's just that the suspend 
code shouldn't _test_ it, since the suspend code is what sets it in the 
first place.

		Linus
