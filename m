From: Daniel J Blueman <daniel@numascale-asia.com>
Subject: Re: [PATCH] Fix printing when no interrupt is allocated
Date: Wed, 31 Oct 2012 17:03:00 +0800
Message-ID: <5090E944.4020803@numascale-asia.com>
References: <1350606821-29813-1-git-send-email-daniel@numascale-asia.com> <1350609711.22385.21.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51116 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161043Ab2JaJDF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Oct 2012 05:03:05 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so816911pad.19
        for <linux-acpi@vger.kernel.org>; Wed, 31 Oct 2012 02:03:04 -0700 (PDT)
In-Reply-To: <1350609711.22385.21.camel@joe-AO722>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Joe Perches <joe@perches.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Len,

On 19/10/2012 09:21, Joe Perches wrote:
> On Fri, 2012-10-19 at 08:33 +0800, Daniel J Blueman wrote:
>> Previously a new line is implicitly added in the no GSI case:
>>
>> [    7.185182] pci 0001:00:12.0: can't derive routing for PCI INT A
>> [    7.191352] pci 0001:00:12.0: PCI INT A: no GSI
>> [    7.195956]  - using ISA IRQ 10
>>
>> The code thus prints a blank line where no legacy IRQ is available:
>>
>> [    1.650124] pci 0000:00:14.0: can't derive routing for PCI INT A
>> [    1.650126] pci 0000:00:14.0: PCI INT A: no GSI
>> [    1.650126]
>> [    1.650180] pci 0000:00:14.0: can't derive routing for PCI INT A
>>
>> Fix this by making the newline explicit and removing the superfluous
>> one.
>
> I think this is a better fix:
>
>   drivers/acpi/pci_irq.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index 0eefa12..9b98f9f 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -459,19 +459,20 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>   	 */
>   	if (gsi < 0) {
>   		u32 dev_gsi;
> -		dev_warn(&dev->dev, "PCI INT %c: no GSI", pin_name(pin));
>   		/* Interrupt Line values above 0xF are forbidden */
>   		if (dev->irq > 0 && (dev->irq <= 0xF) &&
>   		    (acpi_isa_irq_to_gsi(dev->irq, &dev_gsi) == 0)) {
> -			printk(" - using ISA IRQ %d\n", dev->irq);
> +			dev_warn(&dev->dev,
> +				 "PCI INT %c: no GSI - using ISA IRQ %d\n",
> +				 pin_name(pin), dev->irq);
>   			acpi_register_gsi(&dev->dev, dev_gsi,
>   					  ACPI_LEVEL_SENSITIVE,
>   					  ACPI_ACTIVE_LOW);
> -			return 0;
>   		} else {
> -			printk("\n");
> -			return 0;
> +			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
> +				 pin_name(pin));
>   		}
> +		return 0;
>   	}
>
>   	rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);

We're still seeing this in 3.7-rc3. Any preference to the approach here?

Thanks,
   Daniel
-- 
Daniel J Blueman
Principal Software Engineer, Numascale Asia
