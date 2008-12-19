From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2.6.28-rc6] ACPICA: don't cond_resched() when
 irqs_disabled()
Date: Fri, 19 Dec 2008 13:24:25 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812191322110.3745@localhost.localdomain>
References: <20081126135508.GA1891@localhost>
 <alpine.LFD.2.00.0812190016120.6312@localhost.localdomain>
 <1229670120.3990.11.camel@yakui_zhao.sh.intel.com>
 <alpine.LFD.2.00.0812190326000.6312@localhost.localdomain>
 <20081219110145.GA14076@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44007 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbYLSSYe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 13:24:34 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KC400IQ9Z4VRCG3@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Dec 2008 12:24:32 -0600 (CST)
In-reply-to: <20081219110145.GA14076@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>




On Fri, 19 Dec 2008, Wu Fengguang wrote:

> Hi Len,
> 
> FYI: this patch from Lin Ming will generate the following messages:
> 
> on closing lid =>                                                                                                                
>                                                                                                                                  
> [ 8993.764829] irq status before SMI: enable                                                                                     
> [ 8993.768028] irq status after SMI: disable, value: 0xF3                                                                        
>                                                                                                                                      
> on opening lid =>                                                                                                                    
>                                                                                                                                      
> [ 8987.590636] irq status before SMI: enable                                                                                         
> [ 8987.669829] irq status after SMI: enable, value: 0xF3                                                                             
> 
> ---
>  drivers/acpi/executer/exregion.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> --- linux-2.6.orig/drivers/acpi/executer/exregion.c
> +++ linux-2.6/drivers/acpi/executer/exregion.c
> @@ -300,8 +300,20 @@ acpi_ex_system_io_space_handler(u32 func
>  
>  	case ACPI_WRITE:
>  
> +		if (address == 0xB2) {
> +			printk("irq status before SMI: %s\n",
> +				irqs_disabled() ? "disable" : "enable");
> +		}
> +
>  		status = acpi_os_write_port((acpi_io_address) address,
>  					    (u32) * value, bit_width);
> +
> +		if (address == 0xB2) {
> +			printk("irq status after SMI: %s, value: 0x%X\n",
> +				irqs_disabled() ? "disable" : "enable",
> +				(u32) *value);
> +		}
> +
>  		break;
>  
>  	default:
> 
> We are now exploring how the Windows execution path manages to avoid this bug.

sigh.

It might be prudent for us to WARN_ON() the IRQ state
being different before and after any IO write -- in case
others are running into this too.

-- Len Brown, Intel Open Source Technology Center

