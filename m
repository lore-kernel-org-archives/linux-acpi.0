From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC] fix asus_hides_smbus_lpc_ich6() for resume
Date: Thu, 13 Mar 2008 21:44:08 -0700
Message-ID: <20080314044408.GB17961@suse.de>
References: <1205466549.5127.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41029 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbYCNElK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Mar 2008 00:41:10 -0400
Content-Disposition: inline
In-Reply-To: <1205466549.5127.2.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Fri, Mar 14, 2008 at 11:49:09AM +0800, Shaohua Li wrote:
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9010f54..821ad02 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1016,6 +1016,8 @@ enum pci_fixup_pass {
>  	pci_fixup_final,	/* Final phase of device fixups */
>  	pci_fixup_enable,	/* pci_enable_device() time */
>  	pci_fixup_resume,	/* pci_enable_device() time */
> +	pci_fixup_suspend,
> +	pci_fixup_resume_later,

Please document when these quirks are run.

And why "_later"?  What's wrong with the normal resume time?

thanks,

greg k-h
