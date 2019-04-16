From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RESEND][PATCH v2 27/36] drivers: Add a generic helper to match
 device by fwnode handle
Date: Tue, 16 Apr 2019 12:48:36 +0200
Message-ID: <CAJZ5v0i2-11rgH5Y+83U041Eyp=SA56oPqDmS2g24SyYYJH3jg@mail.gmail.com>
References: <1555344260-12375-28-git-send-email-suzuki.poulose@arm.com> <1555411164-26399-1-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555411164-26399-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, coresight@lists.linaro.org, "Rafael J. Wysocki" <rafael@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 16, 2019 at 12:39 PM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> Make the device_fwnode_match() a generic helper to match device
> by fwnode handle for use with bus_find_device(). This will be
> also used by coresight.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>
> Resending with linux-acpi in Cc, as requested by Rafael.

Do any other patches in your series depend on this one?

>  drivers/base/devcon.c    | 5 -----
>  drivers/base/property.c  | 6 ++++++
>  include/linux/property.h | 1 +
>  3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
> index 04db9ae..f4a9e30 100644
> --- a/drivers/base/devcon.c
> +++ b/drivers/base/devcon.c
> @@ -107,11 +107,6 @@ static struct bus_type *generic_match_buses[] = {
>         NULL,
>  };
>
> -static int device_fwnode_match(struct device *dev, void *fwnode)
> -{
> -       return dev_fwnode(dev) == fwnode;
> -}
> -
>  static void *device_connection_fwnode_match(struct device_connection *con)
>  {
>         struct bus_type *bus;
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 8b91ab3..d10d923 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -25,6 +25,12 @@ struct fwnode_handle *dev_fwnode(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_fwnode);
>
> +int device_fwnode_match(struct device *dev, void *fwnode)
> +{
> +       return dev_fwnode(dev) == fwnode;
> +}
> +EXPORT_SYMBOL_GPL(device_fwnode_match);
> +
>  /**
>   * device_property_present - check if a property of a device is present
>   * @dev: Device whose property is being checked
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 65d3420..c8fd3d42 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -34,6 +34,7 @@ enum dev_dma_attr {
>  };
>
>  struct fwnode_handle *dev_fwnode(struct device *dev);
> +int device_fwnode_match(struct device *dev, void *fwnode);
>
>  bool device_property_present(struct device *dev, const char *propname);
>  int device_property_read_u8_array(struct device *dev, const char *propname,
> --
> 2.7.4
>
