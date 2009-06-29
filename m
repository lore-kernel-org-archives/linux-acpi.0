From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] eeepc-laptop: don't touch the pci slot if it was
	claimed by a different driver
Date: Mon, 29 Jun 2009 20:22:06 +0100
Message-ID: <20090629192206.GA7811@srcf.ucam.org>
References: <1245990020-20455-1-git-send-email-lenb@kernel.org> <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com> <9b2b86520906290544g2f5d1da9m8539a5a6f67cf33c@mail.gmail.com> <4A48C15C.3000509@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34714 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758254AbZF2TWI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jun 2009 15:22:08 -0400
Content-Disposition: inline
In-Reply-To: <4A48C15C.3000509@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Corentin Chary <corentincj@iksaif.net>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>

On Mon, Jun 29, 2009 at 02:27:56PM +0100, Alan Jenkins wrote:
> The whole point of registering as a PCI hotplug driver was to prevent
> conflict with pciehp.  At the moment it happens to work because
> eeepc-laptop is loaded first, but it doesn't work the other way round.
> If pciehp is loaded first then we fail to claim the slot - we need to
> respect this and not handle hotplug events.
> 
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
