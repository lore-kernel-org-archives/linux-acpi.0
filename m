From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2/2] PNP: don't check disabled PCI BARs for conflicts
	in quirk_system_pci_resources()
Date: Tue, 30 Sep 2008 22:01:30 +0200
Message-ID: <20080930200130.GA23954@elte.hu>
References: <48E11EFA.8010402@keyaccess.nl> <alpine.LFD.2.00.0809291211330.3389@nehalem.linux-foundation.org> <48E1EF0E.8030006@keyaccess.nl> <alpine.LFD.2.00.0809300741320.3389@nehalem.linux-foundation.org> <48E24C6F.3030903@keyaccess.nl> <alpine.LFD.2.00.0809300904530.3389@nehalem.linux-foundation.org> <alpine.LFD.2.00.0809301001280.3389@nehalem.linux-foundation.org> <alpine.LFD.2.00.0809301015210.4651@nehalem.linux-foundation.org> <20080930193819.GA29860@elte.hu> <alpine.LFD.2.00.0809301244290.3262@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0809301244290.3262@nehalem.linux-foundation.org>
Sender: linux-pci-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Rene Herman <rene.herman@keyaccess.nl>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Frans Pop <elendil@planet.nl>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Adam Belay <abelay@mit.edu>, Avuton Olrich <avuton@gmail.com>, Karl Bellve <karl.bellve@umassmed.edu>, Willem Riede <wriede@riede.org>, Matthew Hall <mhall@mhcomputing.net>, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-acpi@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > so instead of the current hardcoded levels:
> > 
> >   core_initcall(sysctl_init);
> > 
> > we could have natural constructs like:
> > 
> >   initcall_depends_on(sysctl_init, securityfs_init);
> >   initcall_depends_on(sock_init, sysctl_init)
> 
> would be a TOTAL DISASTER, because if you do that, then you are 
> essentially back to the insane situation where people need to know 
> what other parts are enabled.

well, as i mentioned it was and is on the backburner, because we went 
over the same list of problems that you mentioned: harder to read and 
interpret and debug, harder to reproduce boot ordering, etc.

but i'd still like the address the above specific point: it would be 
silly to propagate Kconfig dependencies into the initcall dependencies, 
why do you assume we'd do that?

When PROCFS or PNP is turned off, then their initcall symbols should 
naturally alias to some NOP definition, a function that is immediately 
marked as 'done'. We _already_ have NOP stubs for many initializer 
symbols.

and note:

> > ( More details: we'd have a number of compatibility and convenience
> >   symbols as well - well-known initialization stages for various 
> >   customary phases of bootup.

One convenience symbol would be "memory_done()": to indicate that 
kmalloc() and all the other memory allocators are up and running and 
usable.

	Ingo
