From: karsten wiese <annabellesgarden@yahoo.de>
Subject: RE: [PATCH] Clear abnormal poweroff flag on VIA southbridges, fix resume
Date: Tue, 20 Jun 2006 00:57:19 +0200 (CEST)
Message-ID: <20060619225719.87000.qmail@web26501.mail.ukl.yahoo.com>
References: <20060618191421.GA15358@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web26501.mail.ukl.yahoo.com ([217.146.176.38]:40574 "HELO
	web26501.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964968AbWFSW5V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Jun 2006 18:57:21 -0400
In-Reply-To: <20060618191421.GA15358@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


--- Matthew Garrett <mjg59@srcf.ucam.org> schrieb:

> Some VIA southbridges contain a flag in the ACPI register space that 
> indicates whether an abnormal poweroff has occured, presumably with the 
> intention that it can be cleared on clean shutdown. Some BIOSes check

(intel defines this bit as being set, when poweroff-button is
pressed for > 4s. They say, BIOS is responsible for handling it.)

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
register is a keword for gcc here....

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
and here it should be PCI_VENDOR_ID_VIA.

> +
> +#endif
> +
>  /*
>   * CardBus controllers have a legacy base address that enables them
>   * to respond as i82365 pcmcia controllers.  We don't want them to
> 
> -- 

with above comments applied it works on this VIA K8T800 mobo.
Please repost. Thanks!
 
ACKed-by: Karsten Wiese <annabellesgarden@yahoo.de>



	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
