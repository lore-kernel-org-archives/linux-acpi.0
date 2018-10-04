From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI / ACPI: Mark expected switch fall-through
Date: Thu, 4 Oct 2018 15:52:19 -0500
Message-ID: <20181004205219.GJ120535@bhelgaas-glaptop.roam.corp.google.com>
References: <20181004154041.GA28767@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181004154041.GA28767@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Oct 04, 2018 at 05:40:41PM +0200, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1472052 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to pci/misc for v4.20, thanks!

> ---
>  drivers/pci/pci-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 79c8e95..2a4aa64 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -588,6 +588,7 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  			error = -EBUSY;
>  			break;
>  		}
> +		/* Fall through */
>  	case PCI_D0:
>  	case PCI_D1:
>  	case PCI_D2:
> -- 
> 2.7.4
> 
