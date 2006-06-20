From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clear abnormal poweroff flag on VIA southbridges, fix
 resume
Date: Mon, 19 Jun 2006 23:01:44 -0700
Message-ID: <20060619230144.155bc938.akpm@osdl.org>
References: <20060618191421.GA15358@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:8149 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965065AbWFTGBr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 02:01:47 -0400
In-Reply-To: <20060618191421.GA15358@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, 18 Jun 2006 20:14:22 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> Some VIA southbridges contain a flag in the ACPI register space that 
> indicates whether an abnormal poweroff has occured, presumably with the 
> intention that it can be cleared on clean shutdown. Some BIOSes check 
> this flag at resume time, and will re-POST the system rather than jump 
> back to the OS if it's set. Clearing it at boot time appears to be 
> sufficient. I'm not sure if drivers/pci/quirks.c is the right place to 
> do it, but I'm not sure where would be cleaner.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7537260..2f9f996 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -660,6 +660,33 @@ static void __devinit quirk_vt82c598_id(
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id );
>  
> +#ifdef CONFIG_ACPI
> +
> +/* Some VIA systems boot with the abnormal status flag set. This can cause
> + * the BIOS to re-POST the system on resume rather than passing control 
> + * back to the OS. Clear the flag on boot
> + */
> +
> +static void __devinit quirk_via_abnormal_poweroff(struct pci_dev *dev)
> +{
> +	u32 register;
> +
> +	acpi_hw_register_read (ACPI_MTX_DO_NOT_LOCK, ACPI_REGISTER_PM1_STATUS,
> +			       &register);
> +
> +	if (register & 0x800) {
> +		printk ("Clearing abnormal poweroff flag\n");
> +		acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK,
> +					ACPI_REGISTER_PM1_STATUS,
> +					(u16)0x800);
> +	}
> +}
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_VIA, PCI_DEVICE_ID_VIA_8235, quirk_via_abnormal_poweroff);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_VIA, PCI_DEVICE_ID_VIA_8237, quirk_via_abnormal_poweroff);
> +
> +#endif

Is CONFIG_ACPI the right thing to use here?  As opposed to, say, CONFIG_PM?
Or CONFIG_ACPI_SLEEP??
