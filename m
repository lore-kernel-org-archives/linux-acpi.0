From: Len Brown <lenb@kernel.org>
Subject: Re: linux-next acpi changes make vmware server unusable
Date: Sun, 15 Mar 2009 23:55:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903152355150.30317@localhost.localdomain>
References: <1236203700.3569.11.camel@localhost.localdomain>
 <1236213871.28145.1.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:35671 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbZCPD4D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Mar 2009 23:56:03 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGK00LGWYWVR8Q3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Mar 2009 22:55:48 -0500 (CDT)
In-reply-to: <1236213871.28145.1.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Eric Paris <eparis@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

this one is inserted into the acpica branch to fix the -next regression.

thanks,
Len Brown, Intel Open Source Technology Center

On Thu, 5 Mar 2009, Lin Ming wrote:

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
> 
> 
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
