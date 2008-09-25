From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 3/7] pci: using %pF in quirks.c
Date: Thu, 25 Sep 2008 08:56:57 -0600
Message-ID: <200809250856.57716.bjorn.helgaas@hp.com>
References: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com> <1222308277-10984-3-git-send-email-yhlu.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:12644 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbYIYO5G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 10:57:06 -0400
In-Reply-To: <1222308277-10984-3-git-send-email-yhlu.kernel@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday 24 September 2008 08:04:33 pm Yinghai Lu wrote:
> Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
> ---
>  drivers/pci/quirks.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 1f26712..addf2db 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1689,8 +1689,7 @@ static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f, struct pci_f
>  		if ((f->vendor == dev->vendor || f->vendor == (u16) PCI_ANY_ID) &&
>   		    (f->device == dev->device || f->device == (u16) PCI_ANY_ID)) {
>  #ifdef DEBUG
> -			dev_dbg(&dev->dev, "calling ");
> -			print_fn_descriptor_symbol("%s\n", f->hook);
> +			dev_dbg(&dev->dev, "calling %pF\n", f->hook);
>  #endif
>  			f->hook(dev);
>  		}

I posted a similar patch already:
  http://lkml.org/lkml/2008/8/22/178

Maybe mine was too complicated because it touched more files at once.
Regardless, we need to remove the #ifdef DEBUG because it's no longer
necessary.
