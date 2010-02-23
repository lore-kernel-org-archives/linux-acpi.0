From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH v4 1/5] PCI: split up pci_read_bridge_bases()
Date: Mon, 22 Feb 2010 17:13:01 -0800
Message-ID: <20100222171301.32329c94@jbarnes-piketon>
References: <20100217201654.4013.70201.stgit@bob.kio>
	<20100217201952.4013.62534.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20100217201952.4013.62534.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Peter Haight <peterh@sapros.com>, Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-am33-list@redhat.com, Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: linux-acpi@vger.kernel.org

On Wed, 17 Feb 2010 13:19:52 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> 
> No functional change; this breaks up pci_read_bridge_bases() into separate
> pieces for the I/O, memory, and prefetchable memory windows, similar to how
> Yinghai recently split up pci_setup_bridge() in 68e84ff3bdc.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---

Had to drop these again, got:

Kernel: arch/x86/boot/bzImage is ready  (#16)
  MODPOST 2245 modules
ERROR: "pci_bus_resource_n" [drivers/pcmcia/yenta_socket.ko] undefined!
ERROR: "pci_bus_resource_n" [drivers/pcmcia/rsrc_nonstatic.ko] undefined!
ERROR: "pci_bus_resource_n" [drivers/pci/hotplug/shpchp.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

when building.

-- 
Jesse Barnes, Intel Open Source Technology Center
