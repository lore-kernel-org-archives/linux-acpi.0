From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH v2] wmi: Free the allocated acpi objects through
 wmi_get_event_data
Date: Fri, 4 Dec 2009 08:04:36 -0800
Message-ID: <20091204080436.cfebb82a.randy.dunlap@oracle.com>
References: <20091203172745.02f66489@destiny.ordissimo>
	<20091203100103.ba1ec972.randy.dunlap@oracle.com>
	<20091204101009.0dccacf3@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:21872 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757015AbZLDQGr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2009 11:06:47 -0500
In-Reply-To: <20091204101009.0dccacf3@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <lenb@kernel.org>, Frans Pop <elendil@planet.nl>, Matthew Garrett <mjg@redhat.com>

On Fri, 4 Dec 2009 10:10:09 +0100 Anisse Astier wrote:

> 
> These function allocate an acpi object by calling wmi_get_event_data, which
> then calls acpi_evaluate_object, and it is not freed afterwards.
> 
> And kernel doc is fixed for parameters of wmi_get_event_data.
> 
> Signed-off-by: Anisse Astier <anisse@astier.eu>

Ack and thanks for doing that.


> ---
> There it is,
> 
> Fixed the kernel doc in this patch.
> 
> Anisse
> 
>  drivers/platform/x86/dell-wmi.c |    1 +
>  drivers/platform/x86/hp-wmi.c   |    2 ++
>  drivers/platform/x86/wmi.c      |    4 ++--
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
> index 0f900cc..f235a98 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -180,6 +180,7 @@ static void dell_wmi_notify(u32 value, void *context)
>  			printk(KERN_INFO "dell-wmi: Unknown key %x pressed\n",
>  			       buffer[1] & 0xFFFF);
>  	}
> +	kfree(obj);
>  }
>  
>  static int __init dell_wmi_input_setup(void)
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index c284217..36109e1 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -377,6 +377,8 @@ static void hp_wmi_notify(u32 value, void *context)
>  			       eventcode);
>  	} else
>  		printk(KERN_INFO "HP WMI: Unknown response received\n");
> +
> +	kfree(obj);
>  }
>  
>  static int __init hp_wmi_input_setup(void)
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 177f8d7..87f4c97 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -510,8 +510,8 @@ EXPORT_SYMBOL_GPL(wmi_remove_notify_handler);
>  /**
>   * wmi_get_event_data - Get WMI data associated with an event
>   *
> - * @event - Event to find
> - * &out - Buffer to hold event data
> + * @event: Event to find
> + * @out: Buffer to hold event data. out->pointer should be freed with kfree()
>   *
>   * Returns extra data associated with an event in WMI.
>   */
> -- 
> 1.6.5.3
> 


---
~Randy
