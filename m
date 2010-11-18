From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 3/4] PCI: fix locking for pci_find_upstream_pcie_bridge
 and add declaration
Date: Thu, 18 Nov 2010 10:18:11 -0800
Message-ID: <20101118101811.1fd1c3fd@jbarnes-desktop>
References: <20101118135207.2269.2593.sendpatchset@localhost6.localdomain6>
	<20101118135237.2269.96220.sendpatchset@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20101118135237.2269.96220.sendpatchset@localhost6.localdomain6>
Sender: linux-pci-owner@vger.kernel.org
To: Stefan Assmann <sassmann@redhat.com>
Cc: linux-pci@vger.kernel.org, JBeulich@novell.com, linux-acpi@vger.kernel.org, Olaf.Dabrunz@gmx.net, mingo@elte.hu, bjorn.helgaas@hp.com, tglx@linutronix.de, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 18 Nov 2010 08:52:28 -0500
Stefan Assmann <sassmann@redhat.com> wrote:

> From: Stefan Assmann <sassmann@redhat.com>
> 
> Add header declaration of pci_find_upstream_pcie_bridge to pci.h. This will
> allow the boot interrupt reroute code, and others, to make use of this
> implementation. Also pci_find_upstream_pcie_bridge should take the pci_bus_sem
> semaphore while reading global PCI structures, so update the locking as well.
> 
> Signed-off-by: Stefan Assmann <sassmann@redhat.com>
> ---

You should split this into two patches just to keep things separate,
but other than that it looks fine.  I assume this set will go through
the ACPI tree, you can add my:
Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

-- 
Jesse Barnes, Intel Open Source Technology Center
