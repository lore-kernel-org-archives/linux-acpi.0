From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH V2 RESEND] mailbox: add ACPI support for mailbox framework
Date: Thu, 11 Jun 2015 12:59:23 +0300
Message-ID: <20150611095923.GU1478@lahna.fi.intel.com>
References: <1428537507-30561-1-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49836 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbbFKJ7c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jun 2015 05:59:32 -0400
Content-Disposition: inline
In-Reply-To: <1428537507-30561-1-git-send-email-fkan@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Feng Kan <fkan@apm.com>
Cc: patches@apm.com, jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Wed, Apr 08, 2015 at 04:58:27PM -0700, Feng Kan wrote:
> This will add support for ACPI parsing of the mboxes attribute
> when booting with ACPI table. The client will have a attribute
> mimic the dts call "mboxes". In the ACPI case, the client will
> mark "mboxes" with the ACPI reference of the mbox it wishes to
> use.
> 
> 	Name (_DSD, Package () {
> 		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> 		Package () {
> 			Package (2) {"mboxes", Package(){"^^MBOXREF, index"}}

This should be

 			Package (2) {"mboxes", Package() {^^MBOXREF, index}}

without quotes I think.

> 		}
> 	})
> 
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  V2 CHANGE:
>         - change to use ACPI reference rather than use ACPI HID directly.
> 	- consolidate to use one single xlate function
> 	- fix code to accept use of index
> 
>  drivers/mailbox/mailbox.c          | 105 ++++++++++++++++++++++++++-----------
>  include/linux/mailbox_controller.h |   6 +--
>  2 files changed, 76 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 19b491d..3bb981c 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -9,6 +9,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/interrupt.h>
>  #include <linux/spinlock.h>
>  #include <linux/mutex.h>
> @@ -278,6 +279,70 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
>  }
>  EXPORT_SYMBOL_GPL(mbox_send_message);
>  
> +#ifdef CONFIG_ACPI
> +static struct mbox_chan *mbox_acpi_parse_chan(struct device *dev, int index)
> +{
> +	struct acpi_device *acpi_dev;
> +	struct mbox_controller *mbox;
> +	struct mbox_chan *chan;
> +	int status;
> +	struct acpi_reference_args args;
> +
> +	status = acpi_dev_get_property_reference(ACPI_COMPANION(dev), "mboxes",
> +						 index, &args);
> +	if (ACPI_FAILURE(status)) {
> +		dev_dbg(dev, "mbox: no matching mbox found in ACPI table\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +	acpi_dev = args.adev;
> +
> +	chan = NULL;
> +	list_for_each_entry(mbox, &mbox_cons, node)
> +		if (ACPI_COMPANION(mbox->dev) == acpi_dev) {
> +			chan = mbox->chan_xlate(mbox, args.args[0]);
> +			break;
> +		}
> +
> +	return chan;
> +}

This looks nicer if you add

#else

static inline struct mbox_chan *mbox_acpi_parse_chan(struct device *dev, int index)
{
	return NULL;
}

and then ...

> +#endif
> +
> +static struct mbox_chan *mbox_of_parse_chan(struct device *dev, int index)
> +{
> +	struct of_phandle_args spec;
> +	struct mbox_controller *mbox;
> +	struct mbox_chan *chan;
> +
> +	if (of_parse_phandle_with_args(dev->of_node, "mboxes",
> +				       "#mbox-cells", index, &spec)) {
> +		dev_dbg(dev, "%s: can't parse \"mboxes\" property\n", __func__);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	chan = NULL;
> +	list_for_each_entry(mbox, &mbox_cons, node)
> +		if (mbox->dev->of_node == spec.np) {
> +			chan = mbox->chan_xlate(mbox, spec.args[0]);
> +			break;
> +		}
> +
> +	of_node_put(spec.np);
> +	return chan;
> +}
> +
> +static struct mbox_chan *mbox_parse_chan(struct device *dev, int index)
> +{
> +	if (!dev)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (dev->of_node)
> +		return mbox_of_parse_chan(dev, index);
> +#ifdef CONFIG_ACPI
> +	else
> +		return mbox_acpi_parse_chan(dev, index);
> +#endif

.. you can get rid of the ugly #ifdef here. Just make it:

	if (dev->of_node)
		return mbox_of_parse_chan(dev, index);
	else
		return mbox_acpi_parse_chan(dev, index);

> +}
> +
