From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [PATCH v3 2/2] PCI Hotplug: acpiphp: get pci_bus from acpi
 handle correctly
Date: Fri, 24 Jul 2009 14:38:27 -0700
Message-ID: <20090724143827.31b4c37d@jbarnes-g45>
References: <20090723230026.4247.12759.stgit@bob.kio>
	<20090723230305.4247.81288.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754728AbZGXVib@vger.kernel.org>
In-Reply-To: <20090723230305.4247.81288.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: lenb@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 23 Jul 2009 17:03:05 -0600
Alex Chiang <achiang@hp.com> wrote:

> We cannot simply call acpi_get_pci_dev() on any random ACPI handle
> and hope that it works, because a PCI root bridge may not have
> an associated struct pci_dev.
> 
> This is allowed per the PCI specification, and is referred to as a
> non-materialized bridge.
> 
> So, depending on the type of PCI bridge that the handle points to,
> use the appropriate interface to return the struct pci_bus correctly.
> 
> Signed-off-by: Alex Chiang <achiang@hp.com>
> ---

I put these in my linux-next branch, just because I'm really
conservative about the current release.

If we hear of boxes in the wild getting bitten by the non-materialized
bit, we can push this set back to stable.

-- 
Jesse Barnes, Intel Open Source Technology Center
