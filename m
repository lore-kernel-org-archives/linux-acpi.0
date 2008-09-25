From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 3/7] pci: using %pF in quirks.c
Date: Thu, 25 Sep 2008 07:52:40 -0700
Message-ID: <200809250752.42036.jbarnes@virtuousgeek.org>
References: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com> <1222308277-10984-3-git-send-email-yhlu.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1222308277-10984-3-git-send-email-yhlu.kernel@gmail.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, September 24, 2008 7:04 pm Yinghai Lu wrote:
> Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
> ---
>  drivers/pci/quirks.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 1f26712..addf2db 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1689,8 +1689,7 @@ static void pci_do_fixups(struct pci_dev *dev, struct
> pci_fixup *f, struct pci_f if ((f->vendor == dev->vendor || f->vendor ==
> (u16) PCI_ANY_ID) && (f->device == dev->device || f->device == (u16)
> PCI_ANY_ID)) { #ifdef DEBUG
> -			dev_dbg(&dev->dev, "calling ");
> -			print_fn_descriptor_symbol("%s\n", f->hook);
> +			dev_dbg(&dev->dev, "calling %pF\n", f->hook);
>  #endif
>  			f->hook(dev);
>  		}

Applied to linux-next, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
