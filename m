From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] Improve acpi_dbg_level= documentation
Date: Thu, 19 Apr 2007 08:04:55 -0700
Message-ID: <46278517.7010403@oracle.com>
References: <200704181221.37897.ak@suse.de>	 <20070418080812.0f7f559a.randy.dunlap@oracle.com>	 <200704181626.21213.lenb@kernel.org> <1176968315.9072.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:23718 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766777AbXDSPE3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Apr 2007 11:04:29 -0400
In-Reply-To: <1176968315.9072.11.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <ak@suse.de>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

Zhang Rui wrote:
> On Wed, 2007-04-18 at 12:21 +0200, Andi Kleen wrote: 
>> First it was documented twice.
>>
>> Since this is a fairly important option document it properly.
>> I kept myself looking for this information again and again.
>>
>> In particular the individual bits are fairly important. And add some 
>> warnings.
>>
> That's right. Thanks for pointing out.
> Does the patch below make sense?

Yes, thanks.
A few comments below.

> On Wed, 2007-04-18 at 16:26 -0400, Len Brown wrote:
>> (though in looking at it, I think it is incorrect for
>> sysfs to use debug_level and debug_layer instead of
>> acpi_dbg_level and acpi_dbg_layer, which would match
>> the actual name of the kernel boot parameters)
> 
> Now we use acpi.debug_level and acpi.debug_layer as kernel boot
> parameters instead of acpi_dbg_level and acpi_dbg_layer.
> But the document is not updated in time.
> 
> This is the patch to update document for ACPI debug option.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  Documentation/kernel-parameters.txt |   30 ++++++++++++++++++++++++++----
>  1 files changed, 26 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6.21-rc7/Documentation/kernel-parameters.txt
> ===================================================================
> --- linux-2.6.21-rc7.orig/Documentation/kernel-parameters.txt	2007-04-18 15:22:49.000000000 +0800
> +++ linux-2.6.21-rc7/Documentation/kernel-parameters.txt	2007-04-19 15:21:17.000000000 +0800
> @@ -181,19 +181,41 @@ and is between 256 and 4096 characters. 
>  			that require a timer override, but don't have
>  			HPET
>  
> -	acpi_dbg_layer=	[HW,ACPI]
> +	acpi.dbg_layer=	[HW,ACPI]
>  			Format: <int>
>  			Each bit of the <int> indicates an ACPI debug layer,
>  			1: enable, 0: disable. It is useful for boot time
>  			debugging. After system has booted up, it can be set
> -			via /proc/acpi/debug_layer.
> +			via /sys/module/acpi/parameters/debug_layer.
> +			CONFIG_ACPI_DEBUG must be enabled for this to produce any output.
> +			Available bits (add the numbers together) to enable debug output
> +			for specific parts of the ACPI subsystem:
> +			0x01 utilities 0x02 hardware 0x04 events 0x08 tables
> +			0x10 namespace 0x20 parser 0x40 dispatcher
> +			0x80 executer 0x100 resources 0x200 acpica debugger
> +			0x400 os services 0x800 acpica disassembler

Add period at end above                                            ^

> +			The number can be in decimal or prefixed with 0x in hex.
> +			Warning: Many of these options can produce a lot of
> +			output and make your system unusable. Be very careful.
>  
> -	acpi_dbg_level=	[HW,ACPI]
> +	acpi.dbg_level=	[HW,ACPI]
>  			Format: <int>
>  			Each bit of the <int> indicates an ACPI debug level,
>  			1: enable, 0: disable. It is useful for boot time
>  			debugging. After system has booted up, it can be set
> -			via /proc/acpi/debug_level.
> +			via /sys/module/acpi/parameters/debug_level.
> +			CONFIG_ACPI_DEBUG must be enabled for this to produce any output.
> +			Available bits (add the numbers together) to enable defferent

                                                                         different

> +			debug output levels of the ACPI subsystem:
> +			0x01 error 0x02 warn 0x04 init 0x08 debug object
> +			0x10 info 0x20 init names 0x40 parse 0x80 load
> +			0x100 dispatch 0x200 execute 0x400 names 0x800 operation region
> +			0x1000 bfield 0x2000 tables 0x4000 values 0x8000 objects
> +			0x10000 resources 0x20000 user requests 0x40000 package

Add period at end above.

> +			The number can be in decimal or prefixed with 0x in hex.
> +			Warning: Many of these options can produce a lot of
> +			output and make your system unusable. Be very careful.
> +
>  
>  	acpi_fake_ecdt	[HW,ACPI] Workaround failure due to BIOS lacking ECDT
>  


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
