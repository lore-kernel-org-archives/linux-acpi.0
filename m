From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] x86/PCI: ignore Consumer/Producer bit and parse
 additional _CRS resources
Date: Fri, 19 Mar 2010 13:38:48 -0700
Message-ID: <20100319133848.35465d9a@jbarnes-piketon>
References: <20100316201046.24527.79634.stgit@bob.kio>
	<20100316201134.24527.87006.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20100316201134.24527.87006.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>, Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 16 Mar 2010 14:11:34 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> 
> We previously used only resources marked "Producer," i.e., those the bridge
> forwards downstream.  But BIOSes haven't used that bit consistently, so it's
> useless.  For bridge devices, we have to assume *all* ACPI resources are
> forwarded downstream.  Non-Producer bridge resources typically appear in
> PCI config space and are not described in ACPI.
> 
> In addition to ACPI_RESOURCE_TYPE_ADDRESS{16,32,64}, parse these types:
> 
>     ACPI_RESOURCE_TYPE_IO
>     ACPI_RESOURCE_TYPE_FIXED_IO
>     ACPI_RESOURCE_TYPE_MEMORY24
>     ACPI_RESOURCE_TYPE_MEMORY32
>     ACPI_RESOURCE_TYPE_FIXED_MEMORY32
>     ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64
> 
> This basically reimplements what drivers/pnp/pnpacpi/rsparser.c already
> does, and I plan to take advantage of that, but we're not quite ready to
> do it yet because it will require converting pci_root.c from an ACPI
> driver to a PNP driver.
> 
> This is a possible fix for http://bugzilla.kernel.org/show_bug.cgi?id=15533
> reported by Pete Zaitcev <zaitcev@redhat.com>.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
> 

Applied to my for-linus tree, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
