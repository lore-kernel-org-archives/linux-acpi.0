From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Configure cpuidle governors by default
Date: Fri, 21 Sep 2007 22:23:57 -0400
Message-ID: <200709212223.57886.lenb@kernel.org>
References: <20070913203917.GA1183@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34933 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbXIVCYN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Sep 2007 22:24:13 -0400
In-Reply-To: <20070913203917.GA1183@linux-os.sc.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org, abelay@novell.com

Applied.
Hey, what a great idea:-)

thanks,
-Len

On Thursday 13 September 2007 16:39, Venki Pallipadi wrote:
> 
> Quoting Len "Do not give an option to users to shoot themselves in the foot".
> 
> Remove the configurability of ladder and menu governors as they are
> needed for default policy of cpuidle. That way users will not be able to
> have cpuidle without any policy loosing all C-state power savings.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> Index: linux-2.6.23-rc6/drivers/cpuidle/Kconfig
> ===================================================================
> --- linux-2.6.23-rc6.orig/drivers/cpuidle/Kconfig
> +++ linux-2.6.23-rc6/drivers/cpuidle/Kconfig
> @@ -1,4 +1,3 @@
> -menu "CPU idle PM support"
>  
>  config CPU_IDLE
>  	bool "CPU idle PM support"
> @@ -10,30 +9,13 @@ config CPU_IDLE
>  	  If you're using a mobile platform that supports CPU idle PM (e.g.
>  	  an ACPI-capable notebook), you should say Y here.
>  
> -if CPU_IDLE
> -
> -comment "Governors"
> -
>  config CPU_IDLE_GOV_LADDER
> -	tristate "'ladder' governor"
> +	bool
>  	depends on CPU_IDLE
>  	default y
> -	help
> -	  This cpuidle governor promotes and demotes through the supported idle
> -	  states using residency time and bus master activity as metrics.  This
> -	  algorithm was originally introduced in the old ACPI processor driver.
>  
>  config CPU_IDLE_GOV_MENU
> -	tristate "'menu' governor"
> +	bool
>  	depends on CPU_IDLE && NO_HZ
>  	default y
> -	help
> -	  This cpuidle governor evaluates all available states and chooses the
> -	  deepest state that meets all of the following constraints: BM activity,
> -	  expected time until next timer interrupt, and last break event time
> -	  delta.  It is designed to minimize power consumption.  Currently
> -	  dynticks is required.
> -
> -endif	# CPU_IDLE
>  
> -endmenu
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
