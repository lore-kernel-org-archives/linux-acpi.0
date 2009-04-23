From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] HPET: stop soliciting hpet=force users on ICH4M
Date: Thu, 23 Apr 2009 16:19:04 -0700
Message-ID: <1240528744.4529.9153.camel@localhost.localdomain>
References: <alpine.LFD.2.00.0904222223200.21119@localhost.localdomain>
	 <alpine.LFD.2.00.0904231917030.15843@localhost.localdomain>
	 <alpine.LFD.2.00.0904231918510.15843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39775 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931AbZDWXWA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Apr 2009 19:22:00 -0400
In-Reply-To: <alpine.LFD.2.00.0904231918510.15843@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>


Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On Thu, 2009-04-23 at 16:19 -0700, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> The HPET in the ICH4M is not documented in the data sheet
> because it was not officially validated.
> 
> While it is fine for hackers to continue to use "hpet=force"
> to enable the hardware that they have, it is not prudent to
> solicit additional "hpet=force" users on this hardware.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/kernel/quirks.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
> index e95022e..7563b31 100644
> --- a/arch/x86/kernel/quirks.c
> +++ b/arch/x86/kernel/quirks.c
> @@ -261,8 +261,6 @@ static void old_ich_force_enable_hpet_user(struct pci_dev *dev)
>  {
>  	if (hpet_force_user)
>  		old_ich_force_enable_hpet(dev);
> -	else
> -		hpet_print_force_info();
>  }
>  
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_1,

