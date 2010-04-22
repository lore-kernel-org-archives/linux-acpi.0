From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] pci: Ensure we re-enable devices on resume
Date: Thu, 22 Apr 2010 20:14:49 +0200
Message-ID: <201004222014.49206.rjw@sisk.pl>
References: <1271943051-2671-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33009 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753434Ab0DVSOe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Apr 2010 14:14:34 -0400
In-Reply-To: <1271943051-2671-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, achiang@canonical.com

On Thursday 22 April 2010, Matthew Garrett wrote:
> If the firmware puts a device back into D0 state at resume time, we'll
> update its state in resume_noirq and thus skip the platform resume code.
> Calling that code twice should be safe and we ought to avoid getting to
> that point anyway, so remove the check and also allow the platform pci
> code to be called for D0.
> 
> Fixes USB not being powered after resume on recent Lenovo machines.

OK ...

> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/pci/pci.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5ea587e..3749912 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -679,7 +679,7 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
>   */
>  int __pci_complete_power_transition(struct pci_dev *dev, pci_power_t state)
>  {
> -	return state > PCI_D0 ?
> +	return state >= PCI_D0 ?
>  			pci_platform_power_transition(dev, state) : -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(__pci_complete_power_transition);
> @@ -716,10 +716,6 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  		 */
>  		return 0;
>  
> -	/* Check if we're already there */
> -	if (dev->current_state == state)
> -		return 0;
> -

If my memory serves me right, this check is actually there for a reason,
although I don't remember _what_ exactly the reason is right now.  Sigh.

[/me puts a note for himself to _always_ add specific comments into the code
 in such cases.]

>  	__pci_start_power_transition(dev, state);
>  
>  	/* This device is quirked not to be put into D3, so
> 

Well, I'd say let's try that.  If it breaks things, we'll know relatively quickly. ;-)

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
