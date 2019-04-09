From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 08/11] platform/x86: intel_cht_int33fe: Provide software
 nodes for the devices
Date: Tue, 9 Apr 2019 15:41:13 +0300
Message-ID: <20190409124113.GB20058@kuha.fi.intel.com>
References: <20190403164537.24643-1-heikki.krogerus@linux.intel.com>
 <20190403164537.24643-9-heikki.krogerus@linux.intel.com>
 <CAHp75VfQK_YHyfryMUO0uG_uwoKcgMn_NUXaRbiOXeXQz6xyYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfQK_YHyfryMUO0uG_uwoKcgMn_NUXaRbiOXeXQz6xyYQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 08, 2019 at 07:09:15PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 3, 2019 at 7:46 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Software nodes provide two features that we will need later.
> > 1) Software nodes can have references to other software nodes.
> > 2) Software nodes can exist before a device entry is created.
> 
> >  #include <linux/platform_device.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> > +#include <linux/pci.h>
> 
> I understand your attitude to ordering here, but we already have it
> ordered, why not to keep it that way?

Sure. I'll keep the order.

> > -static struct i2c_client *cht_int33fe_find_max17047(void)
> > -{
> > -       struct i2c_client *max17047 = NULL;
> > -
> > -       i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
> > -       return max17047;
> > -}
> 
> This sounds like a cleanup patch before actual change.
> And I'm not sure, do we need to remove this function?
> 
> > +static int
> > +cht_int33fe_max17047(struct device *dev, struct cht_int33fe_data *data)
> > +{
> > +       struct fwnode_handle *fwnode = data->node[INT33FE_NODE_MAX17047];
> > +       struct i2c_client *max17047 = NULL;
> > +       struct i2c_board_info board_info;
> > +       int ret;
> > +
> > +       i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
> > +       if (max17047) {
> > +               /* Pre-existing i2c-client for the max17047, add device-props */
> > +               max17047->dev.fwnode->secondary = fwnode;
> > +               /* And re-probe to get the new device-props applied. */
> > +               ret = device_reprobe(&max17047->dev);
> > +               if (ret)
> > +                       dev_warn(dev, "Reprobing max17047 error: %d\n", ret);
> > +               return 0;
> > +       }
> > +
> > +       memset(&board_info, 0, sizeof(board_info));
> > +       strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
> > +       board_info.dev_name = "max17047";
> > +       board_info.fwnode = fwnode;
> > +       data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
> > +       if (IS_ERR(data->max17047))
> > +               return PTR_ERR(data->max17047);
> > +
> > +       return 0;
> > +}
> 
> This looks like a split from the original code with some changes.
> Perhaps, split patch first.
> 
> >         /* Work around BIOS bug, see comment on cht_int33fe_find_max17047 */
> 
> After this patch, the comment here become outdated, care to fix?
> 
> > +       ret = cht_int33fe_max17047(dev, data);
> 
> Seems like the verb is missed in the name of the function.

Yeah, I never meant to rename the function. I'll just keep the
function name as cht_int33fe_find_max17047.


thanks,

-- 
heikki
