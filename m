From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/3] PCI: Cleanup printk logging
Date: Tue, 7 May 2019 17:50:40 -0500
Message-ID: <20190507225040.GF156478@google.com>
References: <1555733026-19609-1-git-send-email-mohankumar718@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555733026-19609-1-git-send-email-mohankumar718@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mohan Kumar <mohankumar718@gmail.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Mohan,

On Sat, Apr 20, 2019 at 07:03:46AM +0300, Mohan Kumar wrote:
> Replace printk with pr_* to avoid checkpatch warnings.

This looks fine, and I applied it to pci/printk with the intent of
putting it in v5.2.  I squashed in some pieces of your second patch,
and I'll respond to that one with the details.

When you post more than one patch in a series, it's nice to include a
cover letter where I can respond to the series as a whole.

> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/pci/pci-acpi.c | 11 ++++-------
>  drivers/pci/quirks.c   |  2 +-
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index e1949f7..3ada026 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -140,8 +140,7 @@ static acpi_status decode_type0_hpx_record(union acpi_object *record,
>  		hpx->t0->enable_perr     = fields[5].integer.value;
>  		break;
>  	default:
> -		printk(KERN_WARNING
> -		       "%s: Type 0 Revision %d record not supported\n",
> +		pr_warn("%s: Type 0 Revision %d record not supported\n",
>  		       __func__, revision);
>  		return AE_ERROR;
>  	}
> @@ -169,8 +168,7 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,
>  		hpx->t1->tot_max_split = fields[4].integer.value;
>  		break;
>  	default:
> -		printk(KERN_WARNING
> -		       "%s: Type 1 Revision %d record not supported\n",
> +		pr_warn("%s: Type 1 Revision %d record not supported\n",
>  		       __func__, revision);
>  		return AE_ERROR;
>  	}
> @@ -211,8 +209,7 @@ static acpi_status decode_type2_hpx_record(union acpi_object *record,
>  		hpx->t2->sec_unc_err_mask_or   = fields[17].integer.value;
>  		break;
>  	default:
> -		printk(KERN_WARNING
> -		       "%s: Type 2 Revision %d record not supported\n",
> +		pr_warn("%s: Type 2 Revision %d record not supported\n",
>  		       __func__, revision);
>  		return AE_ERROR;
>  	}
> @@ -272,7 +269,7 @@ static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
>  				goto exit;
>  			break;
>  		default:
> -			printk(KERN_ERR "%s: Type %d record not supported\n",
> +			pr_err("%s: Type %d record not supported\n",
>  			       __func__, type);
>  			status = AE_ERROR;
>  			goto exit;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f9cd4d4..06af0c3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2613,7 +2613,7 @@ static void nvbridge_check_legacy_irq_routing(struct pci_dev *dev)
>  	pci_read_config_dword(dev, 0x74, &cfg);
>  
>  	if (cfg & ((1 << 2) | (1 << 15))) {
> -		printk(KERN_INFO "Rewriting IRQ routing register on MCP55\n");
> +		pr_info("Rewriting IRQ routing register on MCP55\n");
>  		cfg &= ~((1 << 2) | (1 << 15));
>  		pci_write_config_dword(dev, 0x74, cfg);
>  	}
> -- 
> 2.7.4
> 
