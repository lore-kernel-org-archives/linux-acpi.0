From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acer-wmi: Remove private workqueue
Date: Fri, 10 Oct 2008 23:59:51 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810102359440.7059@localhost.localdomain>
References: <20081010163335.1889.75138.stgit@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:65306 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbYJKEAD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 00:00:03 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8K00BLH33RTKM0@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Oct 2008 22:59:52 -0500 (CDT)
In-reply-to: <20081010163335.1889.75138.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

applied.

thanks,
-len

On Fri, 10 Oct 2008, Carlos Corbacho wrote:

> As per Dmitry Torokhov's suggestion, acer-wmi doesn't need a private
> workqueue, so remove it.
> 
> Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
>  drivers/misc/acer-wmi.c |   18 ++----------------
>  1 files changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
> index a6cb670..0532a2d 100644
> --- a/drivers/misc/acer-wmi.c
> +++ b/drivers/misc/acer-wmi.c
> @@ -930,8 +930,6 @@ static void acer_backlight_exit(void)
>  /*
>   * Rfkill devices
>   */
> -static struct workqueue_struct *rfkill_workqueue;
> -
>  static void acer_rfkill_update(struct work_struct *ignored);
>  static DECLARE_DELAYED_WORK(acer_rfkill_work, acer_rfkill_update);
>  static void acer_rfkill_update(struct work_struct *ignored)
> @@ -952,8 +950,7 @@ static void acer_rfkill_update(struct work_struct *ignored)
>  				RFKILL_STATE_SOFT_BLOCKED);
>  	}
>  
> -	queue_delayed_work(rfkill_workqueue, &acer_rfkill_work,
> -		round_jiffies_relative(HZ));
> +	schedule_delayed_work(&acer_rfkill_work, round_jiffies_relative(HZ));
>  }
>  
>  static int acer_rfkill_set(void *data, enum rfkill_state state)
> @@ -1018,17 +1015,7 @@ static int acer_rfkill_init(struct device *dev)
>  		}
>  	}
>  
> -	rfkill_workqueue = create_singlethread_workqueue("rfkill_workqueue");
> -	if (!rfkill_workqueue) {
> -		if (has_cap(ACER_CAP_BLUETOOTH)) {
> -			kfree(bluetooth_rfkill->data);
> -			rfkill_unregister(bluetooth_rfkill);
> -		}
> -		kfree(wireless_rfkill->data);
> -		rfkill_unregister(wireless_rfkill);
> -		return -ENOMEM;
> -	}
> -	queue_delayed_work(rfkill_workqueue, &acer_rfkill_work, HZ);
> +	schedule_delayed_work(&acer_rfkill_work, round_jiffies_relative(HZ));
>  
>  	return 0;
>  }
> @@ -1036,7 +1023,6 @@ static int acer_rfkill_init(struct device *dev)
>  static void acer_rfkill_exit(void)
>  {
>  	cancel_delayed_work_sync(&acer_rfkill_work);
> -	destroy_workqueue(rfkill_workqueue);
>  	kfree(wireless_rfkill->data);
>  	rfkill_unregister(wireless_rfkill);
>  	if (has_cap(ACER_CAP_BLUETOOTH)) {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
