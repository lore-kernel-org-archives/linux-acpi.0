From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] ACPI, PCI, ISA: Fix memory leak when there is no IRQ in the ACPI subsystem.
Date: Tue, 18 Feb 2014 02:02:50 +0100
Message-ID: <87065822.vfIc9IskHH@vostro.rjw.lan>
References: <1392037211-29349-1-git-send-email-tomasz.nowicki@linaro.org> <1392037211-29349-2-git-send-email-tomasz.nowicki@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392037211-29349-2-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, February 10, 2014 02:00:11 PM Tomasz Nowicki wrote:
> Whenever we register ISA interrupt or not, we need to free the IRQ routing
> table entry.
> 
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> ---
>  drivers/acpi/pci_irq.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index b0e31b6..6ec0f36 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -432,6 +432,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>  #endif
>  		dev_warn(&dev->dev, "PCI INT %c: no GSI\n", pin_name(pin));
>  
> +		kfree(entry);

If I'm not mistaken, entry is always NULL here, isn't it?

>  		return 0;
>  	}
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
