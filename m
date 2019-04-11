From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 12/12] platform/x86: intel_cht_int33fe: Replacing the
 old connections with references
Date: Thu, 11 Apr 2019 16:30:26 +0300
Message-ID: <CAHp75VdtNAAHPSPji6h1hQU+Yehu5pqaD3RCEfqLud12NvtTfA@mail.gmail.com>
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com> <20190410152505.87041-13-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410152505.87041-13-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 10, 2019 at 6:25 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Now that the software nodes support references, and the
> device connection API support parsing fwnode references,
> replacing the old connection descriptions with software node
> references. Relying on device names when matching the
> connection would not have been possible to link the USB
> Type-C connector and the DisplayPort connector together, but
> with real references it's not problem.
>
> The DisplayPort ACPI node is dag up, and the drivers own
> software node for the DisplayPort is set as the secondary
> node for it. The USB Type-C connector refers the software
> node, but it is now tied to the ACPI node, and therefore any
> device entry (struct drm_connector in practice) that the
> node combo is assigned to.
>
> The USB role switch device does not have ACPI node, so we
> have to wait for the device to appear. Then we can simply
> assign our software node for the to the device.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 94 +++++++++++++++++++-----
>  1 file changed, 77 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 0687aa23fcfe..8d9f890ec000 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -39,15 +39,22 @@ enum {
>         INT33FE_NODE_MAX,
>  };
>
> +enum {
> +       INT33FE_REF_ORIENTATION,
> +       INT33FE_REF_MODE_MUX,
> +       INT33FE_REF_DISPLAYPORT,
> +       INT33FE_REF_ROLE_SWITCH,
> +       INT33FE_REF_MAX,
> +};
> +
>  struct cht_int33fe_data {
>         struct i2c_client *max17047;
>         struct i2c_client *fusb302;
>         struct i2c_client *pi3usb30532;
> -       /* Contain a list-head must be per device */
> -       struct device_connection connections[4];
>
>         struct fwnode_handle *dp;
>         struct fwnode_handle *node[INT33FE_NODE_MAX];
> +       struct software_node_reference *ref[INT33FE_REF_MAX];
>  };
>
>  /*
> @@ -280,6 +287,65 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
>         return ret;
>  }
>
> +static void cht_int33fe_remove_references(struct cht_int33fe_data *data)
> +{
> +       int i;
> +
> +       for (i = 0; i < INT33FE_REF_MAX; i++)
> +               fwnode_remove_software_node_reference(data->ref[i]);
> +}
> +
> +static int cht_int33fe_add_references(struct cht_int33fe_data *data)
> +{
> +       struct fwnode_reference_args args[2] = { };
> +       struct software_node_reference *ref;
> +       struct fwnode_handle *con;
> +
> +       con = data->node[INT33FE_NODE_USB_CONNECTOR];
> +
> +       /* USB Type-C muxes */
> +       args[0].fwnode = data->node[INT33FE_NODE_PI3USB30532];
> +       args[1].fwnode = NULL;
> +
> +       ref = fwnode_create_software_node_reference(con, "orientation-switch",
> +                                                   args);
> +       if (IS_ERR(ref))
> +               return PTR_ERR(ref);
> +       data->ref[INT33FE_REF_ORIENTATION] = ref;
> +
> +       ref = fwnode_create_software_node_reference(con, "mode-switch", args);
> +       if (IS_ERR(ref)) {
> +               cht_int33fe_remove_references(data);
> +               return PTR_ERR(ref);
> +       }
> +       data->ref[INT33FE_REF_MODE_MUX] = ref;
> +
> +       /* USB role switch */
> +       args[0].fwnode = data->node[INT33FE_NODE_ROLE_SWITCH];
> +       args[1].fwnode = NULL;
> +
> +       ref = fwnode_create_software_node_reference(con, "usb-role-switch",
> +                                                   args);
> +       if (IS_ERR(ref)) {
> +               cht_int33fe_remove_references(data);
> +               return PTR_ERR(ref);
> +       }
> +       data->ref[INT33FE_REF_ROLE_SWITCH] = ref;
> +
> +       /* DisplayPort */
> +       args[0].fwnode = data->node[INT33FE_NODE_DISPLAYPORT];
> +       args[1].fwnode = NULL;
> +
> +       ref = fwnode_create_software_node_reference(con, "displayport", args);
> +       if (IS_ERR(ref)) {
> +               cht_int33fe_remove_references(data);
> +               return PTR_ERR(ref);
> +       }
> +       data->ref[INT33FE_REF_DISPLAYPORT] = ref;
> +
> +       return 0;
> +}
> +
>  static int cht_int33fe_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -348,22 +414,14 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       /* Work around BIOS bug, see comment on cht_int33fe_check_for_max17047 */
> -       ret = cht_int33fe_find_max17047(dev, data);
> +       ret = cht_int33fe_add_references(data);
>         if (ret)
>                 goto out_remove_nodes;
>
> -       data->connections[0].endpoint[0] = "port0";
> -       data->connections[0].endpoint[1] = "i2c-pi3usb30532-switch";
> -       data->connections[0].id = "orientation-switch";
> -       data->connections[1].endpoint[0] = "port0";
> -       data->connections[1].endpoint[1] = "i2c-pi3usb30532-mux";
> -       data->connections[1].id = "mode-switch";
> -       data->connections[2].endpoint[0] = "i2c-fusb302";
> -       data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
> -       data->connections[2].id = "usb-role-switch";
> -
> -       device_connections_add(data->connections);
> +       /* Work around BIOS bug, see comment on cht_int33fe_check_for_max17047 */
> +       ret = cht_int33fe_find_max17047(dev, data);
> +       if (ret)
> +               goto out_remove_references;
>
>         memset(&board_info, 0, sizeof(board_info));
>         strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
> @@ -396,9 +454,11 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>         i2c_unregister_device(data->fusb302);
>
>  out_unregister_max17047:
> -       device_connections_remove(data->connections);
>         i2c_unregister_device(data->max17047);
>
> +out_remove_references:
> +       cht_int33fe_remove_references(data);
> +
>  out_remove_nodes:
>         cht_int33fe_remove_nodes(data);
>
> @@ -413,7 +473,7 @@ static int cht_int33fe_remove(struct platform_device *pdev)
>         i2c_unregister_device(data->fusb302);
>         i2c_unregister_device(data->max17047);
>
> -       device_connections_remove(data->connections);
> +       cht_int33fe_remove_references(data);
>         cht_int33fe_remove_nodes(data);
>
>         return 0;
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
