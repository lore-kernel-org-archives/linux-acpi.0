From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] x86/PCI: parse additional host bridge window resource
 types
Date: Thu, 22 Apr 2010 16:17:49 -0700
Message-ID: <20100422161749.5e8af128@virtuousgeek.org>
References: <20100420195241.13265.93577.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20100420195241.13265.93577.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Tue, 20 Apr 2010 13:52:41 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> 
> This adds support for Memory24, Memory32, and Memory32Fixed descriptors in
> PCI host bridge _CRS.
> 
> I experimentally determined that Windows (2008 R2) accepts these descriptors
> and treats them as windows that are forwarded to the PCI bus, e.g., if
> it finds any PCI devices with BARs outside the windows, it moves them into
> the windows.
> 
> I don't know whether any machines actually use these descriptors in PCI
> host bridge _CRS methods, but if any exist and they're new enough that we
> automatically turn on "pci=use_crs", they will work with Windows but not
> with Linux.
> 
> Here are the details: https://bugzilla.kernel.org/show_bug.cgi?id=15817
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---

Applied to for-linus, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
