From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v3 3/3] Improve container_notify_cb() to support
 container hot-remove.
Date: Thu, 01 Nov 2012 10:43:14 -0600
Message-ID: <1351788194.19172.98.camel@misato.fc.hp.com>
References: <1351668471-31436-1-git-send-email-tangchen@cn.fujitsu.com>
	 <1351668471-31436-4-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1351668471-31436-4-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: yinghai@kernel.org, bhelgaas@google.com, lenb@kernel.org, jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2012-10-31 at 15:27 +0800, Tang Chen wrote:
> This patch introduces a new function container_device_remove() to do
> the container hot-remove job. It works like the following:
> 
> 1. call acpi_bus_trim(device, 0) to stop the container device,
>    which means to unbind ACPI drivers first before remove devices.
>    (This feature is introduced by Lu Yinghai:
>     http://www.spinics.net/lists/linux-pci/msg17667.html)
> 2. generate the KOBJ_OFFLINE uevent. (Did I do this correct ?)
> 3. call acpi_bus_hot_remove_device(), which will call acpi_bus_trim(device, 1)
>    to remove the container.
> 
> This patch is based on Lu Yinghai's work.
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-split-pci-root-hp-2
> 
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> ---
>  drivers/acpi/container.c |   63 ++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 53 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
> index a10eee6..4abec98 100644
> --- a/drivers/acpi/container.c
> +++ b/drivers/acpi/container.c
> @@ -166,6 +166,32 @@ static int container_device_add(struct acpi_device **device, acpi_handle handle)
>  	return result;
>  }
>  
> +static int container_device_remove(struct acpi_device *device)
> +{
> +	int ret;
> +	struct acpi_eject_event *ej_event;
> +
> +	/* stop container device at first */
> +	ret = acpi_bus_trim(device, 0);
> +	pr_debug("acpi_bus_trim stop return %x\n", ret);
> +	if (ret)
> +		return ret;
> +
> +	/* send the uevent before remove the device */
> +	kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
> +
> +	ej_event = kmalloc(sizeof(*ej_event), GFP_KERNEL);
> +	if (!ej_event)
> +		return -ENOMEM;
> +
> +	ej_event->device = device;
> +	ej_event->event = ACPI_NOTIFY_EJECT_REQUEST;
> +
> +	acpi_bus_hot_remove_device(ej_event);

Hi Tang,

Rafael pointed out in my CPU hot-remove patch that
acpi_bus_hot_remove_device() was not exported for modules.  Looks like
you have the same problem here.  FYI, I just sent the following patch
that exports acpi_bus_hot_remove_device() and acpi_os_hotplug_execute().

https://lkml.org/lkml/2012/11/1/225

Thanks,
-Toshi
