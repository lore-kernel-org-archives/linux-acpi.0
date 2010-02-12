From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH v3 1/7] PCI: split up pci_read_bridge_bases()
Date: Fri, 12 Feb 2010 13:26:23 -0800
Message-ID: <20100212132623.79fdf5cd@jbarnes-piketon>
References: <20100212165532.19522.47240.stgit@bob.kio>
	<20100212165952.19522.19555.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100212165952.19522.19555.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Peter Haight <peterh@sapros.com>, Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-am33-list@redhat.com, Yinghai Lu <yinghai@kernel.org>, linux-alpha@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: linux-acpi@vger.kernel.org

On Fri, 12 Feb 2010 09:59:52 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> 
> No functional change; this breaks up pci_read_bridge_bases() into
> separate pieces for the I/O, memory, and prefetchable memory windows,
> similar to how Yinghai recently split up pci_setup_bridge() in
> 68e84ff3bdc.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---

Applied to my linux-next branch replacing the old ones, thanks Bjorn.

-- 
Jesse Barnes, Intel Open Source Technology Center
