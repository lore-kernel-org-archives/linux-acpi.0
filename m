From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH v1 3/7] PCI: split up pci_read_bridge_bases()
Date: Mon, 8 Feb 2010 11:59:24 -0800
Message-ID: <20100208115924.5a817027@jbarnes-piketon>
References: <20100203233617.10803.92102.stgit@bob.kio>
	<20100203233910.10803.74241.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20100203233910.10803.74241.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>, linux-pci@vger.kernel.org, Peter Haight <peterh@sapros.com>, Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: linux-acpi@vger.kernel.org

On Wed, 03 Feb 2010 16:39:11 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> 
> No functional change; this breaks up pci_read_bridge_bases() into
> separate pieces for the I/O, memory, and prefetchable memory windows,
> similar to how Yinghai recently split up pci_setup_bridge() in
> 68e84ff3bdc.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---

This one conflicts a bit with Yinghai's recent stuff.  Can you respin
against my linux-next branch?  May as well do the whole series, then
I'll just apply it in one go.

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
