From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/2] PCI PM: Introduce pci_preferred_state
Date: Wed, 7 May 2008 11:33:09 +0200
Message-ID: <20080507093309.GE13858@elf.ucw.cz>
References: <200805062342.42789.rjw@sisk.pl> <200805062349.18683.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55095 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbYEGJc1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 May 2008 05:32:27 -0400
Content-Disposition: inline
In-Reply-To: <200805062349.18683.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <greg@kroah.com>

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The new suspend and hibernation callbacks introduced with
> 'struct pm_ops' and 'struct pm_ext_ops' do not take a
> pm_message_t argument, so the drivers using them will not be able
> to use pci_choose_state() in its present form.  For this reason,
> introduce the new function pci_preferred_state() playing the role
> of pci_choose_state(), but taking only a pointer to the device
> object.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/pci/pci.c   |   33 ++++++++++++++++++++++++++++++++-
>  include/linux/pci.h |    1 +
>  include/linux/pm.h  |   10 ++++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/pci/pci.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci.c
> +++ linux-2.6/drivers/pci/pci.c
> @@ -509,7 +509,38 @@ pci_set_power_state(struct pci_dev *dev,
>  }
>  
>  pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
> - 
> +
> +/**
> + * pci_preferred_state - Choose the preferred power state of a PCI device
> + * @dev: PCI device to be put into the low power state
> + * @sp: Information aboutabout what the driver would prefer to do with
> + *	the device if there were no platform-implemeted policy.
> + *
> + * Returns PCI power state suitable for given device and given suspend policy.
> + * The policy, however, is only used if platform_pci_choose_state() fails or is
> + * not present.  Otherwise, it is assumed that platform_pci_choose_state()
> + * implements the right policy.
> + */
> +
> +pci_power_t pci_preferred_state(struct pci_dev *dev, enum suspend_policy sp)
> +{
> +	pci_power_t ret;
> +
> +	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> +		return PCI_D0;
> +
> +	ret = (sp == SP_TURN_OFF) ? PCI_D3hot : PCI_D0;
> +	if (platform_pci_choose_state) {
> +		pci_power_t platform_ret = platform_pci_choose_state(dev);
> +
> +		if (platform_ret != PCI_POWER_ERROR)
> +			ret = platform_ret;
> +	}
> +	return ret;
> +}
> +
> +EXPORT_SYMBOL(pci_preferred_state);

I don't get it. How is driver supposed to use this? How does the
driver decide between SP_TURN_OFF and SP_TURN_ON?

...and it seems to be clearer to just inline this in the driver... or
pass  PCI_D3hot/PCI_D0 to it, instead of inventing yet another
define...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
