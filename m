From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 2/2] x86_64: Collect host bridge resources
Date: Tue, 24 May 2005 14:05:27 +0200
Message-ID: <20050524120527.GB15326@wotan.suse.de>
References: <20050521004239.581618000@csdlinux-1> <20050521004506.842235000@csdlinux-1> <20050523161507.GN16164@wotan.suse.de> <20050523175706.A12032@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262007AbVEXMFi@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050523175706.A12032@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Andi Kleen <ak@suse.de>, len.brown@intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Mon, May 23, 2005 at 05:57:08PM -0700, Rajesh Shah wrote:
> On Mon, May 23, 2005 at 06:15:07PM +0200, Andi Kleen wrote:
> > On Fri, May 20, 2005 at 05:42:41PM -0700, rajesh.shah@intel.com wrote:
> > > This patch reads and stores host bridge resources reported by
> > > ACPI BIOS for x86_64 systems. This is needed since ACPI hotplug
> > > code now uses the PCI core for resource management. This patch
> > > simply adds the boot parameter (acpi=root_resources) to enable
> > > the functionality that is implemented in arch/i386.
> > > 
> > 
> > This means all hot plug users have to pass this strange parameter?
> > That does not sound very user friendly. Especially since you usually
> > only need pci hotplug in emergencies, and then you likely didnt pass it.
> > 
> > Cant you find a way to do this without parameters? Any reason
> > to not make it default?
> > 
> I found several systems in which the host bridge was decoding 6+
> resource ranges. In the pci_bus structure, I only have room for 4,
> so I'm forced to drop some ranges that are in fact being passed

How about you allocate an extended structure with kmalloc in this case?
Or if it is only 6 ranges max (it is not, is it?) you could extend
the array.

I doubt this information will need *that* much memory, so it should
be reasonable to just teach the PCI subsystem about it.

> Another option I'd thought of but never really pursued was to
> implement this as a late_initcall. I'll look into that some more.
> In that case, we'd continue to think that all host bridges decode
> all unclaimed resources at boot time and depend on BIOS to program
> resources for boot time devices correctly. Later, we'd collect the
> more accurate host bridge resource picture to make hotplug work
> correctly. Kind of hackish, but I can't think of another way to
> avoid the boot parameter.

It sounds preferable to me to just give PCI the full picture from
the beginning instead of using such hacks which will likely
come back later to hurt us.

-Andi
