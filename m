From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] USB: PCI: set 32bit DMA mask for PCI based USB
 controllers
Date: Wed, 30 Jan 2019 08:40:59 +0100
Message-ID: <20190130074059.GA29458@lst.de>
References: <1548831714-3706-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548831714-3706-1-git-send-email-guohanjun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, John Garry <john.garry@huawei.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, anthony.jebson@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 30, 2019 at 03:01:54PM +0800, Hanjun Guo wrote:
> This is the RFC version, I'm not sure this is the best solution,
> comments are warmly welcomed.
> 
> Thanks
> Hanjun
> 
>  drivers/usb/core/hcd-pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> index 0343246..a9c33e6 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -188,6 +188,10 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (pci_enable_device(dev) < 0)
>  		return -ENODEV;
>  
> +	retval = dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
> +	if (retval)
> +		return retval;

dma_coerce_mask_and_coherent is only for platform devices (and I'm
not sure it is a good idea to start with, but that is a different
story).

PCI device should have the dma_mask pointer set already, so you should
use dma_set_mask_and_coherent here.
