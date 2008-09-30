From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 2/2] PNP: don't check disabled PCI BARs for conflicts in
 quirk_system_pci_resources()
Date: Tue, 30 Sep 2008 12:54:27 -0700
Message-ID: <20080930125427.7a90a8b3@infradead.org>
References: <200809290957.59813.bjorn.helgaas@hp.com>
	<alpine.LFD.1.10.0809290912060.3265@nehalem.linux-foundation.org>
	<48E11EFA.8010402@keyaccess.nl>
	<alpine.LFD.2.00.0809291211330.3389@nehalem.linux-foundation.org>
	<48E1EF0E.8030006@keyaccess.nl>
	<alpine.LFD.2.00.0809300741320.3389@nehalem.linux-foundation.org>
	<48E24C6F.3030903@keyaccess.nl>
	<alpine.LFD.2.00.0809300904530.3389@nehalem.linux-foundation.org>
	<alpine.LFD.2.00.0809301001280.3389@nehalem.linux-foundation.org>
	<alpine.LFD.2.00.0809301015210.4651@nehalem.linux-foundation.org>
	<20080930193819.GA29860@elte.hu>
	<alpine.LFD.2.00.0809301244290.3262@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0809301244290.3262@nehalem.linux-foundation.org>
Sender: linux-pci-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Frans Pop <elendil@planet.nl>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Adam Belay <abelay@mit.edu>, Avuton Olrich <avuton@gmail.com>, Karl Bellve <karl.bellve@umassmed.edu>, Willem Riede <wriede@riede.org>, Matthew Hall <mhall@mhcomputing.net>, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 30 Sep 2008 12:51:07 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Tue, 30 Sep 2008, Ingo Molnar wrote:
> > 
> > incidentally, i've been talking to Arjan about this recently in
> > context of the CONFIG_FASTBOOT feature. Because, as a side-effect,
> > in the long run, once the dependencies between initcalls fan out in
> > a more natural way, with explicit initcall ordering we'll also be
> > able to boot a bit faster and a bit more parallel.
> 
> Hell no.
> 
> We do not want any implicit parallelism in the initcalls. That way
> lies madness.
> 
> The probe functions that explicitly know that they are slow (like USB 
> detection and/or other individual drivers that have timeouts) should
> put themselves in the background. We should _not_ use the dependency
> chain to do so automatically, because for most cases drivers are
> totally independent, but we still want a _reliable_  and _repeatable_
> ordering.
> 
> Which means that I will not accept stuff that makes for a parallel
> bootup as a general initcall notion. I want things like network
> devices to show up in the same order for the same kernel, thank you
> very much - even if there is absolutely _zero_ ordering constraints
> between two independent network drivers.

just to avoid any confusion; the current -fastboot tree does not do
this parallel stuff. At all.
(so please don't judge it as doing that)


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
