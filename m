From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH] acpi: pci_root: fix NULL pointer deref after resume
	from suspend
Date: Mon, 28 Sep 2009 11:38:20 -0600
Message-ID: <20090928173819.GA2441@ldl.fc.hp.com>
References: <1254119480-9730-1-git-send-email-dfeng@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:6809 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbZI1RiQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Sep 2009 13:38:16 -0400
Content-Disposition: inline
In-Reply-To: <1254119480-9730-1-git-send-email-dfeng@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Xiaotian Feng <dfeng@redhat.com>
Cc: lenb@kernel.org, bjorn.helgaas@hp.com, andrew.patterson@hp.com, jbarnes@virtuousgeek.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Xiaotian,

Thanks for the bug report.

* Xiaotian Feng <dfeng@redhat.com>:
> commit 275582 introduces acpi_get_pci_dev(), but pdev->subordinate
> can be NULL, then a NULL was passed to pci_get_slot, this results
> the kernel oops when resume from suspend.
> 
> This patch resolves following kernel oops:
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000028
> IP: [<ffffffff812217e7>] pci_get_slot+0x4c/0x8c
> 
> Signed-off-by: Xiaotian Feng <dfeng@redhat.com>
> ---
>  drivers/acpi/pci_root.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 3112221..3c35144 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -387,7 +387,11 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
>  		if (!pdev || hnd == handle)
>  			break;
>  
> -		pbus = pdev->subordinate;
> +		if (pdev->subordinate)
> +			pbus = pdev->subordinate;
> +		else
> +			pbus = pdev->bus;
> +

I'm a little confused by this. If we start from the PCI root
bridge and walk back down the hierarchy, shouldn't everything
between the root and the device be a P2P bridge?

What is special about suspend/resume that causes the subordinate
bus to become NULL?

Can you send the full stacktrace?

Thanks.

/ac

