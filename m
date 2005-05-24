From: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [patch 2/2] x86_64: Collect host bridge resources
Date: Tue, 24 May 2005 10:37:25 -0700
Message-ID: <20050524103724.A22049@unix-os.sc.intel.com>
References: <20050521004239.581618000@csdlinux-1> <20050521004506.842235000@csdlinux-1> <20050523161507.GN16164@wotan.suse.de> <20050523175706.A12032@unix-os.sc.intel.com> <20050524120527.GB15326@wotan.suse.de> <20050524185856.A7639@jurassic.park.msu.ru> <20050524084533.A20567@unix-os.sc.intel.com> <20050524205855.A8367@jurassic.park.msu.ru>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261799AbVEXRiA@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050524205855.A8367@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Tue, May 24, 2005 at 08:58:55PM +0400
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@suse.de>, len.brown@intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, acpi-devel@lists.sourceforge.net, gregkh@suse.de
List-Id: linux-acpi@vger.kernel.org

On Tue, May 24, 2005 at 08:58:55PM +0400, Ivan Kokshaysky wrote:
> On Tue, May 24, 2005 at 08:45:36AM -0700, Rajesh Shah wrote:
> > The concern here isn't just increasing the size of pci_bus. The
> > resource pointers in pci_bus point to resource structures in the
> > corresponding pci_dev structure for p2p bridges. If we want to
> > maintain this scheme, we'd have to increase the number of resources
> > in the pci_dev structure too, which increases it for every single
> > pci device in the system.
> 
> No. The pci_bus resource pointers are just pointers to _some_ resources
> and generally aren't tied to particular pci device. For example, the
> root pci buses often don't even have corresponding bus->self structure,
> and bus resources are pointers to global io[mem,port]_resource.

For the transparent p2p bridge problem you mentioned, wouldn't you
be dealing with p2p bridges, and therefore expect the pci_bus
resource pointers to point to the corresponding pci_dev resources?
Or are you proposing to decouple pci_bus resource pointers from 
pci_dev completely? From quick code inspection, that seems to be
not too much trouble to increase from 4 then.

Rajesh
