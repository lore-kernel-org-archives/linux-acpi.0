From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH v2 08/11] PCI Hotplug: acpiphp: convert to
 acpi_get_pci_dev
Date: Thu, 11 Jun 2009 15:17:43 -0700
Message-ID: <20090611151743.6586cbb3@jbarnes-g45>
References: <20090604054504.18802.21690.stgit@bob.kio>
	<20090604055857.18802.34388.stgit@bob.kio>
	<20090611144845.76e7dc1d@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090611144845.76e7dc1d@jbarnes-g45>
Sender: linux-pci-owner@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 11 Jun 2009 14:48:45 -0700
Jesse Barnes <jesse.barnes@intel.com> wrote:

> On Wed, 03 Jun 2009 23:58:57 -0600
> Alex Chiang <achiang@hp.com> wrote:
> 
> > Now that acpi_get_pci_dev is available, let's use it instead of
> > acpi_get_pci_id.
> > 
> > Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> > Signed-off-by: Alex Chiang <achiang@hp.com>
> > ---
> > 
> 
> Applied to linux-next, thanks.

Oops, since this one depends on others in the series it's probably best
if they just go in through Len's tree.  This one has my 
  Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>
too.

-- 
Jesse Barnes, Intel Open Source Technology Center
