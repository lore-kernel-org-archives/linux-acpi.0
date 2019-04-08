From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 10/11] platform/x86: intel_cht_int33fe: Link with external
 dependencies using fwnodes
Date: Mon, 8 Apr 2019 19:42:52 +0300
Message-ID: <CAHp75VeTUCQax01xVNg7N6oAYKoxadX9vL-X9oEQFHHJ6OSrpg@mail.gmail.com>
References: <20190403164537.24643-1-heikki.krogerus@linux.intel.com> <20190403164537.24643-11-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403164537.24643-11-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 3, 2019 at 7:46 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Supplying also external devices - the DisplayPort connector
> and the USB role switch - software fwnodes. After this the
> driver has access to all the components tied to the USB
> Type-C connector and can start creating software node
> references to actually associate them with the USB Type-C
> connector device.

> +static int role_switch_match(struct device *dev, void *name)
> +{
> +       return !strcmp(dev_name(dev), name);
> +}
> +
> +static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
> +{

> +       /* First let's find xHCI PCI device */
> +       pdev = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, NULL);
> +       if (!pdev || (pdev->vendor != PCI_VENDOR_ID_INTEL))
> +               return -ENODEV;
> +

> +       /* Then the child platform device */
> +       p = device_find_child(&pdev->dev, "intel_xhci_usb_sw",
> +                             role_switch_match);

We have already similar code in kernel
(drivers/nvdimm/claim.c::namespace_match), perhaps
you at least can (locally) introduce

static int match_name(...) // or re-use from drivers/base/bus.c
{
...
}

static device_find_child_by_name(...)
{
...
}

which we may move to the driver core now or later on.

> +       pci_dev_put(pdev);
> +       if (!p)
> +               return -EPROBE_DEFER;
> +

> +       /* Finally the mux device */
> +       dev = device_find_child(p, "intel_xhci_usb_sw-role-switch",
> +                               role_switch_match);

Ditto.

> +       put_device(p);
> +       if (!dev)
> +               return -EPROBE_DEFER;

> +       return 0;

> +}

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

Can't generic helper be in charge of doing this, i.e. chaining fwnodes?

///
void fwnode_chain(parent, new)
{
...
}
///

fwnode_chain(data->dp, fwnode);


> +
> +       return 0;
> +}

--
With Best Regards,
Andy Shevchenko
