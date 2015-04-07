From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / HOTPLUG: fix device->physical_node_lock deadlock
Date: Tue, 07 Apr 2015 13:22:52 +0200
Message-ID: <5219717.RxvSXtBaZ8@vostro.rjw.lan>
References: <1428397392-26200-1-git-send-email-xiexiuqi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60856 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750983AbbDGK63 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2015 06:58:29 -0400
In-Reply-To: <1428397392-26200-1-git-send-email-xiexiuqi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Xie XiuQi <xiexiuqi@huawei.com>
Cc: lenb@kernel.org, guohanjun@huawei.com, hanjun.guo@linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, April 07, 2015 05:03:12 PM Xie XiuQi wrote:
> I meet a deadlock during cpu hotplug. The code path is bellow:
> 
> Call Trace:
>  [<ffffffff816e373c>] dump_stack+0x19/0x1b
>  [<ffffffff810fd85a>] validate_chain.isra.43+0xf4a/0x1120
>  [<ffffffff810236c9>] ? sched_clock+0x9/0x10
>  [<ffffffff810ca8bd>] ? sched_clock_local+0x1d/0x80
>  [<ffffffff810caa88>] ? sched_clock_cpu+0xa8/0x100
>  [<ffffffff810fe846>] __lock_acquire+0x3c6/0xb70
>  [<ffffffff810caa88>] ? sched_clock_cpu+0xa8/0x100
>  [<ffffffff810ff7e2>] lock_acquire+0xa2/0x1f0
>  [<ffffffff813ba132>] ? acpi_scan_is_offline+0x2c/0xa3
>  [<ffffffff816e7a14>] mutex_lock_nested+0x94/0x3f0
>  [<ffffffff813ba132>] ? acpi_scan_is_offline+0x2c/0xa3
>  [<ffffffff813ba132>] ? acpi_scan_is_offline+0x2c/0xa3
>  [<ffffffff810fe0fd>] ? trace_hardirqs_on+0xd/0x10
>  [<ffffffff813ba132>] acpi_scan_is_offline+0x2c/0xa3	--> LOCK (DEADLOCK)

Is it the same device, actually?  acpi_container_offline() walks the *children*
of the container while acpi_bus_offline() locks the container itself.

Is it not the case?

>  [<ffffffff813fdac8>] acpi_container_offline+0x32/0x4e
>  [<ffffffff81469e59>] container_offline+0x19/0x20
>  [<ffffffff81462955>] device_offline+0x95/0xc0
>  [<ffffffff813b9e53>] acpi_bus_offline+0xbc/0x126	--> LOCK
>  [<ffffffff813bb83d>] acpi_device_hotplug+0x236/0x46b
>  [<ffffffff813b4c75>] acpi_hotplug_work_fn+0x1e/0x29
>  [<ffffffff810a6c10>] process_one_work+0x220/0x710
>  [<ffffffff810a6ba4>] ? process_one_work+0x1b4/0x710
>  [<ffffffff810a721b>] worker_thread+0x11b/0x3a0
>  [<ffffffff810a7100>] ? process_one_work+0x710/0x710
>  [<ffffffff810b061d>] kthread+0xed/0x100
>  [<ffffffff810b0530>] ? insert_kthread_work+0x80/0x80
>  [<ffffffff816f663c>] ret_from_fork+0x7c/0xb0
>  [<ffffffff810b0530>] ? insert_kthread_work+0x80/0x80
> 
> This deadlock was introduced by commit caa73ea
> ("ACPI / hotplug / driver core: Handle containers in a special way").
> 
> In this patch, we just introduced a lockless version __acpi_scan_is_offline()
> for acpi_container_offline(), to avoid this deadlock.

So why is this a correct approach?  Why can acpi_container_offline() suddenly
call __acpi_scan_is_offline() without the lock?

> Cc: <stable@vger.kernel.org> # v3.14+
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> ---
>  drivers/acpi/container.c |  2 +-
>  drivers/acpi/internal.h  |  1 +
>  drivers/acpi/scan.c      | 15 ++++++++++++---
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
> index c8ead9f..43bda3b2 100644
> --- a/drivers/acpi/container.c
> +++ b/drivers/acpi/container.c
> @@ -50,7 +50,7 @@ static int acpi_container_offline(struct container_dev *cdev)
>  
>  	/* Check all of the dependent devices' physical companions. */
>  	list_for_each_entry(child, &adev->children, node)
> -		if (!acpi_scan_is_offline(child, false))
> +		if (!__acpi_scan_is_offline(child, false))
>  			return -EBUSY;
>  
>  	return 0;
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 56b321a..3b7a07b 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -80,6 +80,7 @@ void acpi_apd_init(void);
>  acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src);
>  bool acpi_queue_hotplug_work(struct work_struct *work);
>  void acpi_device_hotplug(struct acpi_device *adev, u32 src);
> +bool __acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
>  bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
>  
>  /* --------------------------------------------------------------------------
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index bbca783..ea55a9a 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -293,13 +293,12 @@ acpi_device_modalias_show(struct device *dev, struct device_attribute *attr, cha
>  }
>  static DEVICE_ATTR(modalias, 0444, acpi_device_modalias_show, NULL);
>  
> -bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
> +/* Must be called under physical_node_lock. */
> +bool __acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
>  {
>  	struct acpi_device_physical_node *pn;
>  	bool offline = true;
>  
> -	mutex_lock(&adev->physical_node_lock);
> -
>  	list_for_each_entry(pn, &adev->physical_node_list, node)
>  		if (device_supports_offline(pn->dev) && !pn->dev->offline) {
>  			if (uevent)
> @@ -309,7 +308,17 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
>  			break;
>  		}
>  
> +	return offline;
> +}
> +
> +bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
> +{
> +	bool offline = true;
> +
> +	mutex_lock(&adev->physical_node_lock);
> +	offline = __acpi_scan_is_offline(adev, uevent);
>  	mutex_unlock(&adev->physical_node_lock);
> +
>  	return offline;
>  }
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
