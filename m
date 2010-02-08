From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH v2 0/7] PCI: try "pci=use_crs" again
Date: Mon, 8 Feb 2010 15:08:34 -0800
Message-ID: <20100208150834.17756314@jbarnes-piketon>
References: <20100208224236.27954.4358.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20100208224236.27954.4358.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>, linux-pci@vger.kernel.org, Peter Haight <peterh@sapros.com>, Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: linux-acpi@vger.kernel.org

On Mon, 08 Feb 2010 15:44:18 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> Historically, Linux has assumed a single PCI host bridge, with that
> bridge claiming all the address space left after RAM and legacy
> devices are taken out.
> 
> If the system contains multiple host bridges, we can no longer
> operate under that assumption.  We have to know what parts of the
> address space are claimed by each bridge so that when we assign
> resources to a PCI device, we take them from a range claimed by the
> upstream host bridge.
> 
> We use ACPI to enumerate all the PCI host bridges in the system, and
> part of the host bridge description is the "_CRS" (current resource
> settings" property, which lists the address space used by the
> bridge.  On x86, we currently ignore most of the _CRS information.
> This patch series changes this, so we will use _CRS to learn about
> the host bridge windows.
> 
> Since most x86 machines with multiple host bridges are relatively
> new, this series only turns this on for machines with BIOS dates of
> 2010 or newer and for a few machines we know to require it.
> 
> These apply on be6e9f7853e.  I added an initial patch to clean up the
> formatting of the disabled window printk.
> 
> Changes since v1:
>     - rebase to be6e9f7853e
>     - add patch to clean up "disabled window" printk
>     - add bugzilla reference comment in use_crs DMI quirk

A 2010 default is probably too conservative, but we can always add a
whitelist or change the default later.  Applied the series to my
linux-next branch, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
