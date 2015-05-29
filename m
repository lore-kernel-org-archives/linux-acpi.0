From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/2] ACPI / PCI: Fix _PRT lookup for ARI enabled
 devices
Date: Fri, 29 May 2015 17:18:48 -0500
Message-ID: <20150529221848.GD12733@google.com>
References: <20150526210927.7537.55656.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:32816 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbbE2WSw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2015 18:18:52 -0400
Received: by iebgx4 with SMTP id gx4so73255079ieb.0
        for <linux-acpi@vger.kernel.org>; Fri, 29 May 2015 15:18:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150526210927.7537.55656.stgit@gimli.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, ddutile@redhat.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, lenb@kernel.org

On Tue, May 26, 2015 at 03:11:38PM -0600, Alex Williamson wrote:
> v2: don't modify entry->id.device
> 
> In most cases we only use ARI with SR-IOV VFs, which do not support
> INTx and therefore never hit this problem.  However, some non-SR-IOV
> implementations create multiple PFs, extending beyond the standard
> 3-bit function numbers with ARI, and do support INTx for those
> additional functions.  This can happen with Solarflare SFC9120
> adapters.  The host driver typically doesn't use INTx, so we also
> haven't noticed this problem on bare metal, but when we attempt to
> assign the device to a VM using vfio-pci, we fail trying to setup
> default INTx signaling.  Thanks,
> 
> Alex
> 
> ---
> 
> Alex Williamson (2):
>       PCI: Move pci_ari_enabled() to global header
>       ACPI / PCI: Account for ARI in _PRT lookups

Rafael, do you want this or should I take it?

I put it on my pci/virtualization branch for v4.2.  If you want it, let me
know and I'll drop it and you can add my:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
