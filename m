From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Add intel drm blacklist to intel_opregion_present detect
Date: Mon, 23 Aug 2010 16:18:49 +0200
Message-ID: <201008231618.50131.trenn@suse.de>
References: <1282563648-21935-1-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43283 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466Ab0HWON1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Aug 2010 10:13:27 -0400
In-Reply-To: <1282563648-21935-1-git-send-email-jlee@novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: mjg@redhat.com, linux-kernel@vger.kernel.org, gregkh@suse.de, jlee@novell.com, Dennis.Jansen@web.de, linux-acpi@vger.kernel.org

On Monday 23 August 2010 13:40:48 Lee, Chun-Yi wrote:
> There have some machines not support by i915 drm driver, e.g. MSI U110/U150,
> there are use poulsbo chip and drm driver not support it because legal issue.
> Those machines's acpi backlight control actually work fine and don't need apply
> the intel opregion support.
> So, add intel drm blacklist to intel_opregion_present, it can enable the acpi
> brightness interface on Poulsbo/Morrestown.
> 
> Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
...
> @@ -2567,7 +2584,14 @@ static int __init intel_opregion_present(void)
>  		pci_read_config_dword(dev, 0xfc, &address);
>  		if (!address)
>  			continue;
> -		return 1;
> +		for (i = 0; intel_drm_blacklist[i].device != 0; i++) {
> +			if (dev->device == intel_drm_blacklist[i].device) {
> +				in_blacklist = 1;
> +				break;
You can just return 0 here...
> +			}
> +		}
> +		if (!in_blacklist)
> +			return 1;
and get rid of in_blacklist variable.
Makes the code a bit easier to read.

      Thomas
