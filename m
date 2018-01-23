From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [net-next: PATCH v4 4/7] device property: Allow iterating over
 available child fwnodes
Date: Tue, 23 Jan 2018 01:05:26 +0100
Message-ID: <CAJZ5v0gc0qB1ssmAcS9jM47=akeUPhKwzDpzGE=T79meSOsRMQ@mail.gmail.com>
References: <1516278704-17141-1-git-send-email-mw@semihalf.com> <1516278704-17141-5-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44809 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeAWAF2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jan 2018 19:05:28 -0500
In-Reply-To: <1516278704-17141-5-git-send-email-mw@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, David Miller <davem@davemloft.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, stefanc@marvell.com, Nadav Haklai <nadavh@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, jaz@semihalf.com, Tomasz Nowicki <tn@semihalf.com>

On Thu, Jan 18, 2018 at 1:31 PM, Marcin Wojtas <mw@semihalf.com> wrote:
> Implement a new helper function fwnode_get_next_available_child_node(),
> which enables obtaining next enabled child fwnode, which
> works on a similar basis to OF's of_get_next_available_child().
>
> This commit also introduces a macro, thanks to which it is
> possible to iterate over the available fwnodes, using the
> new function described above.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/property.c  | 26 ++++++++++++++++++++
>  include/linux/property.h |  6 +++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 1d6c9d9..613ba82 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -998,6 +998,32 @@ fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
>  EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
>
>  /**
> + * fwnode_get_next_available_child_node - Return the next
> + * available child node handle for a node
> + * @fwnode: Firmware node to find the next child node for.
> + * @child: Handle to one of the node's child nodes or a %NULL handle.
> + */
> +struct fwnode_handle *
> +fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
> +                                    struct fwnode_handle *child)
> +{
> +       struct fwnode_handle *next_child = child;
> +
> +       if (!fwnode)
> +               return NULL;
> +
> +       do {
> +               next_child = fwnode_get_next_child_node(fwnode, next_child);
> +
> +               if (!next_child || fwnode_device_is_available(next_child))
> +                       break;
> +       } while (next_child);
> +
> +       return next_child;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
> +
> +/**
>   * device_get_next_child_node - Return the next child node handle for a device
>   * @dev: Device to find the next child node for.
>   * @child: Handle to one of the device's child nodes or a null handle.
> diff --git a/include/linux/property.h b/include/linux/property.h
> index e05889f..5b0563a 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -83,11 +83,17 @@ struct fwnode_handle *fwnode_get_next_parent(
>         struct fwnode_handle *fwnode);
>  struct fwnode_handle *fwnode_get_next_child_node(
>         const struct fwnode_handle *fwnode, struct fwnode_handle *child);
> +struct fwnode_handle *fwnode_get_next_available_child_node(
> +       const struct fwnode_handle *fwnode, struct fwnode_handle *child);
>
>  #define fwnode_for_each_child_node(fwnode, child)                      \
>         for (child = fwnode_get_next_child_node(fwnode, NULL); child;   \
>              child = fwnode_get_next_child_node(fwnode, child))
>
> +#define fwnode_for_each_available_child_node(fwnode, child)                   \
> +       for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
> +            child = fwnode_get_next_available_child_node(fwnode, child))
> +
>  struct fwnode_handle *device_get_next_child_node(
>         struct device *dev, struct fwnode_handle *child);
>
> --
