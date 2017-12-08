From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V7 2/7] ACPI / bus: Introduce acpi_get_match_data() function
Date: Fri, 8 Dec 2017 15:51:16 +0100
Message-ID: <CAJZ5v0iw1u4o0SbCN12ctG+Kpg0EP+JBGvToLyiEcQopY=KPzw@mail.gmail.com>
References: <1512681031-11343-1-git-send-email-okaya@codeaurora.org> <1512681031-11343-3-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:47057 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753359AbdLHOvR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Dec 2017 09:51:17 -0500
In-Reply-To: <1512681031-11343-3-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: dmaengine <dmaengine@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, Dec 7, 2017 at 10:10 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> OF has of_device_get_match_data() function to extract driver specific data
> structure. Add a similar function for ACPI.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/bus.c   | 18 ++++++++++++++++++
>  include/linux/acpi.h |  6 ++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 4d0979e..f87ed3b 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -785,6 +785,24 @@ const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
>  }
>  EXPORT_SYMBOL_GPL(acpi_match_device);
>
> +void *acpi_get_match_data(const struct device *dev)
> +{
> +       const struct acpi_device_id *match;
> +
> +       if (!dev->driver)
> +               return NULL;
> +
> +       if (!dev->driver->acpi_match_table)
> +               return NULL;

You can safely check dev->driver and this in the same statement (as
long as the first check to be made is on the left).

> +
> +       match = acpi_match_device(dev->driver->acpi_match_table, dev);
> +       if (!match)
> +               return NULL;
> +
> +       return (void *)match->driver_data;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_match_data);
> +
>  int acpi_match_device_ids(struct acpi_device *device,
>                           const struct acpi_device_id *ids)
>  {
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 502af53..a927260 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -584,6 +584,7 @@ extern int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *),
>  const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
>                                                const struct device *dev);
>
> +void *acpi_get_match_data(const struct device *dev);
>  extern bool acpi_driver_match_device(struct device *dev,
>                                      const struct device_driver *drv);
>  int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
> @@ -755,6 +756,11 @@ static inline const struct acpi_device_id *acpi_match_device(
>         return NULL;
>  }
>
> +static inline void *acpi_get_match_data(const struct device *dev)
> +{
> +       return NULL;
> +}
> +
>  static inline bool acpi_driver_match_device(struct device *dev,
>                                             const struct device_driver *drv)
>  {
> --

But anyway

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
