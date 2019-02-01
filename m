From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [RFC PATCH] USB: PCI: set 32bit DMA mask for PCI based USB
 controllers
Date: Fri, 1 Feb 2019 17:13:52 +0800
Message-ID: <e47d89e3-9bb0-95b0-db63-717594b1692b@huawei.com>
References: <1548831714-3706-1-git-send-email-guohanjun@huawei.com>
 <f9a8ab1f-d560-0fb6-dfc9-61be3c1a2d82@huawei.com>
 <ce031291-3050-3817-0ed9-9d83dad0cc55@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ce031291-3050-3817-0ed9-9d83dad0cc55@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>, anthony.jebson@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On 2019/2/1 13:55, Hanjun Guo wrote:
> Hi John,
> 
> On 2019/1/31 17:54, John Garry wrote:
>> On 30/01/2019 07:01, Hanjun Guo wrote:
>>> From: Hanjun Guo <hanjun.guo@linaro.org>
> [...]
>>>
>>>  drivers/usb/core/hcd-pci.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
>>> index 0343246..a9c33e6 100644
>>> --- a/drivers/usb/core/hcd-pci.c
>>> +++ b/drivers/usb/core/hcd-pci.c
>>> @@ -188,6 +188,10 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>>      if (pci_enable_device(dev) < 0)
>>>          return -ENODEV;
>>>
>>> +    retval = dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
>>> +    if (retval)
>>> +        return retval;
>>
>> Hi Hanjun,
>>
>> You're missing tidy-up upon failure.
> 
> Good catch, needs to disable pci for failure, I will send
> a updated version to address the comments from you and Christoph.

There is a _DMA method which was introduced in ACPI 6.2 to cover
this, I will try that solution then report back.

Thanks
Hanjun
