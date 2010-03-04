From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH 3/4] ipmi: Convert tracking of the ACPI device pointer
	to a PNP device
Date: Thu, 04 Mar 2010 17:20:10 +0800
Message-ID: <1267694410.3613.96.camel@localhost.localdomain>
References: <20100304033146.30205.68689.stgit@bob.kio>
	 <20100304034420.30205.7749.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33658 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575Ab0CDJWG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Mar 2010 04:22:06 -0500
In-Reply-To: <20100304034420.30205.7749.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@hp.com>
Cc: "minyard@acm.org" <minyard@acm.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>

On Thu, 2010-03-04 at 11:44 +0800, Myron Stowe wrote:
> Convert PNP patch (git 9e368fa011d4e0aa050db348d69514900520e40b) to
> maintain a pointer to a PNP device, 'pnp_dev', instead of the ACPI
> device, 'acpi_dev', that is currently being tracked with PNP based
> IPMI device discovery.

Hi, Myron
	Now the IPMI interface defined in ACPI namespace is detected by using
PNP device driver. But it seems that this still belongs to ACPI
detection mechanism. At the same time IPMI device defined in ACPI
namespace is also used to enable the communication between ACPI and IPMI
device. In such case it will be better to know whether the IPMI
interface is discovered by using ACPI detection mechanism , which can be
realized by comparing the info->dev with acpi_dev->dev.
     Can we still use the acpi_dev->dev to track the IPMI device
discovery?

thanks.
     Yakui
        
> 
> Signed-off-by: Myron Stowe <myron.stowe@hp.com>
> ---
> 
>  drivers/char/ipmi/ipmi_si_intf.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 806ae83..37c6912 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -1934,7 +1934,7 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
>  		info->irq_setup = std_irq_setup;
>  	}
>  
> -	info->dev = &acpi_dev->dev;
> +	info->dev = &dev->dev;
>  	pnp_set_drvdata(dev, info);
>  
>  	return try_smi_init(info);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

