From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 11/12] platform/x86: intel_cht_int33fe: Link with
 external dependencies using fwnodes
Date: Thu, 11 Apr 2019 16:28:58 +0300
Message-ID: <CAHp75VeM8Ob-Q9FToNxt7Rwrcoodpphc10=PpDw9CB6xd=3eUA@mail.gmail.com>
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com> <20190410152505.87041-12-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410152505.87041-12-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 10, 2019 at 6:25 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Supplying also external devices - the DisplayPort connector
> and the USB role switch - software fwnodes. After this the
> driver has access to all the components tied to the USB
> Type-C connector and can start creating software node
> references to actually associate them with the USB Type-C
> connector device.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 92 ++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 0707afd39ca5..0687aa23fcfe 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -33,6 +33,8 @@ enum {
>         INT33FE_NODE_FUSB302,
>         INT33FE_NODE_MAX17047,
>         INT33FE_NODE_PI3USB30532,
> +       INT33FE_NODE_DISPLAYPORT,
> +       INT33FE_NODE_ROLE_SWITCH,
>         INT33FE_NODE_USB_CONNECTOR,
>         INT33FE_NODE_MAX,
>  };
> @@ -44,6 +46,7 @@ struct cht_int33fe_data {
>         /* Contain a list-head must be per device */
>         struct device_connection connections[4];
>
> +       struct fwnode_handle *dp;
>         struct fwnode_handle *node[INT33FE_NODE_MAX];
>  };
>
> @@ -144,8 +147,71 @@ static const struct property_entry *props[] = {
>         [INT33FE_NODE_FUSB302]          = fusb302_props,
>         [INT33FE_NODE_MAX17047]         = max17047_props,
>         [INT33FE_NODE_PI3USB30532]      = NULL,
> +       [INT33FE_NODE_DISPLAYPORT]      = NULL,
> +       [INT33FE_NODE_ROLE_SWITCH]      = NULL,
>  };
>
> +static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
> +{
> +       struct fwnode_handle *fwnode = data->node[INT33FE_NODE_ROLE_SWITCH];
> +       struct pci_dev *pdev;
> +       struct device *dev;
> +       struct device *p;
> +
> +       /* First let's find xHCI PCI device */
> +       pdev = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, NULL);
> +       if (!pdev || (pdev->vendor != PCI_VENDOR_ID_INTEL))
> +               return -ENODEV;
> +
> +       /* Then the child platform device */
> +       p = device_find_child_by_name(&pdev->dev, "intel_xhci_usb_sw");
> +       pci_dev_put(pdev);
> +       if (!p)
> +               return -EPROBE_DEFER;
> +
> +       /* Finally the mux device */
> +       dev = device_find_child_by_name(p, "intel_xhci_usb_sw-role-switch");
> +       put_device(p);
> +       if (!dev)
> +               return -EPROBE_DEFER;
> +
> +       /* If there already is a node for the mux, using that one. */
> +       if (dev->fwnode) {
> +               fwnode_handle_get(dev->fwnode);
> +               fwnode_remove_software_node(fwnode);
> +               data->node[INT33FE_NODE_ROLE_SWITCH] = dev->fwnode;
> +       } else {
> +               /* The node can be tied to the lifetime of the device. */
> +               dev->fwnode = fwnode_handle_get(dev->fwnode);
> +       }
> +
> +       put_device(dev);
> +
> +       return 0;
> +}
> +
> +static int cht_int33fe_setup_dp(struct cht_int33fe_data *data)
> +{
> +       struct fwnode_handle *fwnode = data->node[INT33FE_NODE_DISPLAYPORT];
> +       struct pci_dev *pdev;
> +
> +       /* First let's find the GPU PCI device */
> +       pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, NULL);
> +       if (!pdev || (pdev->vendor != PCI_VENDOR_ID_INTEL))
> +               return -ENODEV;
> +
> +       /* Then the DP child device node */
> +       data->dp = device_get_named_child_node(&pdev->dev, "DD02");
> +       pci_dev_put(pdev);
> +       if (!data->dp)
> +               return -ENODEV;
> +
> +       fwnode->secondary = ERR_PTR(-ENODEV);
> +       data->dp->secondary = fwnode;
> +
> +       return 0;
> +}
> +
>  static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
>  {
>         int i;
> @@ -154,6 +220,12 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
>                 fwnode_remove_software_node(data->node[i]);
>                 data->node[i] = NULL;
>         }
> +
> +       if (data->dp) {
> +               data->dp->secondary = NULL;
> +               fwnode_handle_put(data->dp);
> +               data->dp = NULL;
> +       }
>  }
>
>  static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
> @@ -180,6 +252,26 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
>         }
>         data->node[INT33FE_NODE_USB_CONNECTOR] = fwnode;
>
> +       /* The devices that are not created in this driver need extra steps. */
> +
> +       /*
> +        * There is no ACPI device node for the USB role mux, so we need to find
> +        * the mux device and assign our node directly to it. That means we
> +        * depend on the mux driver. This function will return -PROBE_DEFER
> +        * until the mux device is registered.
> +        */
> +       ret = cht_int33fe_setup_mux(data);
> +       if (ret)
> +               goto err_remove_nodes;
> +
> +       /*
> +        * The DP connector does have ACPI device node. In this case we can just
> +        * find that ACPI node and assing our node as the secondary node to it.
> +        */
> +       ret = cht_int33fe_setup_dp(data);
> +       if (ret)
> +               goto err_remove_nodes;
> +
>         return 0;
>
>  err_remove_nodes:
> --
> 2.20.1
>


--
With Best Regards,
Andy Shevchenko
