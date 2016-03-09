From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND PATCH 2/2] device property: fix for a case of use-after-free
Date: Wed, 09 Mar 2016 01:52:32 +0100
Message-ID: <38356299.uTpVNISVVC@vostro.rjw.lan>
References: <1457444677-25645-1-git-send-email-heikki.krogerus@linux.intel.com> <1457444677-25645-3-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48363 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753440AbcCIAuk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2016 19:50:40 -0500
In-Reply-To: <1457444677-25645-3-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, John Youn <John.Youn@synopsys.com>, linux-acpi@vger.kernel.org

On Tuesday, March 08, 2016 03:44:37 PM Heikki Krogerus wrote:
> In device_remove_property_set(), the secondary fwnode needs
> to be cleared before the pset is freed. This fixes a
> use-after-free when a property set is providing the primary
> fwnode.
> 
> Reported-by: John Youn <John.Youn@synopsys.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/property.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index a163f2c..a9df21a9 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -820,11 +820,13 @@ void device_remove_property_set(struct device *dev)
>  	 * the pset. If there is no real firmware node (ACPI/DT) primary
>  	 * will hold the pset.
>  	 */
> -	if (!is_pset_node(fwnode))
> +	if (is_pset_node(fwnode))
> +		dev->fwnode = NULL;

I don't really like the way you clear dev->fwnode directly here.  set_primary_fwnode(dev, NULL) would be more appropriate IMO.

Also set_secondary_fwnode(dev, NULL) need not be done in that case, because it
doesn't change anything.

Moreover, if the primary node is not pset, the secondary one should only be
cleared if it is pset.

So that would mean

	if (is_pset_node(fwnode)) {
		set_primary_fwnode(dev, NULL);
		pset_free_set(to_pset_node(fwnode));
	} else {
		fwnode = fwnode->secondary;
		if (!IS_ERR(fwnode) && is_pset_node(fwnode)) {
			set_secondary_fwnode(dev, NULL);
			pset_free_set(to_pset_node(fwnode));
		}
	}

Or am I mistaken?


> +	else
>  		fwnode = fwnode->secondary;
>  	if (!IS_ERR(fwnode) && is_pset_node(fwnode))
> -		pset_free_set(to_pset_node(fwnode));
> -	set_secondary_fwnode(dev, NULL);
> +		set_secondary_fwnode(dev, NULL);
> +	pset_free_set(to_pset_node(fwnode));
>  }
>  EXPORT_SYMBOL_GPL(device_remove_property_set);
>  

Thanks,
Rafael

