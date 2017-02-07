From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 4/4] i2c: allow specify device properties in i2c_board_info
Date: Tue, 7 Feb 2017 13:44:05 +0100
Message-ID: <CAJZ5v0iEbxJREPpDNF+4iLmYowAmLeV18MmybddcGv4NBMFJdw@mail.gmail.com>
References: <20170203014128.317-1-dmitry.torokhov@gmail.com> <20170203014128.317-5-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36439 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753955AbdBGMoG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2017 07:44:06 -0500
In-Reply-To: <20170203014128.317-5-dmitry.torokhov@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>

On Fri, Feb 3, 2017 at 2:41 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> With many drivers converting to using generic device properties, it is
> useful to provide array of device properties when instantiating new i2c
> client via i2c_board_info and have them automatically added to the device
> in question.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Wolfram,

Any objections here?

> ---
>  drivers/i2c/i2c-core.c | 16 +++++++++++++++-
>  include/linux/i2c.h    |  3 +++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index f009549f86a5..3897e78e5e9a 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1335,15 +1335,29 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
>         client->dev.fwnode = info->fwnode;
>
>         i2c_dev_set_name(adap, client);
> +
> +       if (info->properties) {
> +               status = device_add_properties(&client->dev, info->properties);
> +               if (status) {
> +                       dev_err(&adap->dev,
> +                               "Failed to add properties to client %s: %d\n",
> +                               client->name, status);
> +                       goto out_err;
> +               }
> +       }
> +
>         status = device_register(&client->dev);
>         if (status)
> -               goto out_err;
> +               goto out_free_props;
>
>         dev_dbg(&adap->dev, "client [%s] registered with bus id %s\n",
>                 client->name, dev_name(&client->dev));
>
>         return client;
>
> +out_free_props:
> +       if (info->properties)
> +               device_remove_properties(&client->dev);
>  out_err:
>         dev_err(&adap->dev,
>                 "Failed to register i2c client %s at 0x%02x (%d)\n",
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 4aa7d244b38a..ec8f866a5656 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -51,6 +51,7 @@ enum i2c_slave_event;
>  typedef int (*i2c_slave_cb_t)(struct i2c_client *, enum i2c_slave_event, u8 *);
>
>  struct module;
> +struct property_entry;
>
>  #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
>  /*
> @@ -310,6 +311,7 @@ static inline int i2c_slave_event(struct i2c_client *client,
>   * @archdata: copied into i2c_client.dev.archdata
>   * @of_node: pointer to OpenFirmware device node
>   * @fwnode: device node supplied by the platform firmware
> + * @properties: additional device properties for the device
>   * @irq: stored in i2c_client.irq
>   *
>   * I2C doesn't actually support hardware probing, although controllers and
> @@ -331,6 +333,7 @@ struct i2c_board_info {
>         struct dev_archdata     *archdata;
>         struct device_node *of_node;
>         struct fwnode_handle *fwnode;
> +       const struct property_entry *properties;
>         int             irq;
>  };
>
> --

Thanks,
Rafael
