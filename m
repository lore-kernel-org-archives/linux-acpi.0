From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] wmi: Free the allocated acpi objects through
 wmi_get_event_data
Date: Thu, 3 Dec 2009 10:01:03 -0800
Message-ID: <20091203100103.ba1ec972.randy.dunlap@oracle.com>
References: <20091203172745.02f66489@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet11.oracle.com ([141.146.126.233]:44415 "EHLO
	acsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbZLCSCN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2009 13:02:13 -0500
In-Reply-To: <20091203172745.02f66489@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <lenb@kernel.org>, Frans Pop <elendil@planet.nl>, Matthew Garrett <mjg@redhat.com>

On Thu, 3 Dec 2009 17:27:45 +0100 Anisse Astier wrote:

> 
> These function allocate an acpi object by calling wmi_get_event_data, which
> then calls acpi_evaluate_object, and it is not freed afterwards
> 
> Signed-off-by: Anisse Astier <anisse@astier.eu>
> ---
>  drivers/platform/x86/dell-wmi.c |    1 +
>  drivers/platform/x86/hp-wmi.c   |    2 ++
>  drivers/platform/x86/wmi.c      |    2 +-
>  3 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
> index 5f4a0e6..cd48a2f 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -121,6 +121,7 @@ static void dell_wmi_notify(u32 value, void *context)
>  			printk(KERN_INFO "dell-wmi: Unknown key %x pressed\n",
>  			       buffer[1] & 0xFFFF);
>  	}
> +	kfree(obj);
>  }
>  
>  static int __init dell_wmi_input_setup(void)
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index 8868610..8eba327 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -316,6 +316,8 @@ static void hp_wmi_notify(u32 value, void *context)
>  			       eventcode);
>  	} else
>  		printk(KERN_INFO "HP WMI: Unknown response received\n");
> +
> +	kfree(obj);
>  }
>  
>  static int __init hp_wmi_input_setup(void)
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 177f8d7..b486048 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -511,7 +511,7 @@ EXPORT_SYMBOL_GPL(wmi_remove_notify_handler);
>   * wmi_get_event_data - Get WMI data associated with an event
>   *
>   * @event - Event to find
> - * &out - Buffer to hold event data
> + * &out - Buffer to hold event data. out.pointer should be freed with kfree()
>   *
>   * Returns extra data associated with an event in WMI.
>   */
> -- 

Hi,

All of the kernel-doc in wmi.c is in the correct format except for this (above)
function.  Please fix it to use the expected kernel-doc notation:

 * @event: Event to find
 * @out: Buffer to hold event data. out.pointer should be freed with kfree()


thanks,
---
~Randy
