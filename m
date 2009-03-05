From: Eric Paris <eparis@redhat.com>
Subject: Re: linux-next acpi changes make vmware server unusable
Date: Wed, 04 Mar 2009 20:51:03 -0500
Message-ID: <1236217863.3569.18.camel@localhost.localdomain>
References: <1236203700.3569.11.camel@localhost.localdomain>
	 <1236213871.28145.1.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:43121 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbZCEBuG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Mar 2009 20:50:06 -0500
In-Reply-To: <1236213871.28145.1.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Brown, Len" <len.brown@intel.com>

On Thu, 2009-03-05 at 08:44 +0800, Lin Ming wrote:
> On Thu, 2009-03-05 at 05:55 +0800, Eric Paris wrote:
> > I built a linux-next kernel yesterday and discovered that the free
> > vmware server 2 would start to boot the kernel and very quickly just
> > power off.  vmware gave some crap message about the MBR being wrong,
> > which obviously wasn't the case since grub started and the kernel
> > started booting.  Looking at the last line on the serial console for the
> > new kernel and the next line in a working kernel I knew the next output
> > was supposed to be in the ACPI code.  I bisected drivers/acpi and found
> > that d6c349993fc7c9dabf873796c4e82bb94544b3ce is first bad commit.
> 
> Would you please try below patch?

linux-next + this patch boots just fine.

Thanks!!

-Eric


>     ACPICA: Check for non-zero address before being converted to GAS
>     
>     Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
>  drivers/acpi/acpica/tbfadt.c |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
> index 042d239..af8fbe1 100644
> --- a/drivers/acpi/acpica/tbfadt.c
> +++ b/drivers/acpi/acpica/tbfadt.c
> @@ -625,12 +625,14 @@ static void acpi_tb_setup_fadt_registers(void)
>  		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
>  				 fadt_pm_info_table[i].source);
>  
> -		acpi_tb_init_generic_address(fadt_pm_info_table[i].target,
> -					     source64->space_id,
> -					     pm1_register_byte_width,
> -					     source64->address +
> -					     (fadt_pm_info_table[i].
> -					      register_num *
> -					      pm1_register_byte_width));
> +		if (source64->address) {
> +			acpi_tb_init_generic_address(fadt_pm_info_table[i].
> +						     target, source64->space_id,
> +						     pm1_register_byte_width,
> +						     source64->address +
> +						     (fadt_pm_info_table[i].
> +						      register_num *
> +						      pm1_register_byte_width));
> +		}
>  	}
>  }
> 
> 
> > 
> > I have no idea what vmware is doing, or what we are doing, but before
> > that patch I was able to boot and after it, vmware just shuts itself
> > off.
> > 
> > -Eric
> > 
> > 
> 

