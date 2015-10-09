From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [Bugfix v4 2/2] ACPI, PCI: Prevent binding other PCI drivers to
 IOAPIC PCI devices
Date: Fri, 9 Oct 2015 17:45:17 +0200
Message-ID: <20151009154517.GF27420@8bytes.org>
References: <1444386214-26319-1-git-send-email-joro@8bytes.org>
 <1444399652-25920-1-git-send-email-jiang.liu@linux.intel.com>
 <1444399652-25920-3-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:38922 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757419AbbJIPpT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Oct 2015 11:45:19 -0400
Content-Disposition: inline
In-Reply-To: <1444399652-25920-3-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexdeucher@gmail.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-iommu@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org

On Fri, Oct 09, 2015 at 10:07:32PM +0800, Jiang Liu wrote:
> The ACPI IOAPIC driver makes use of IOAPIC PCI devices, so prevent
> binding other PCI drivers to IOAPIC PCI devices used by ACPI IOAPIC
> driver.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/acpi/ioapic.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Joerg Roedel <jroedel@suse.de>
