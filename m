From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/Processor: Add CPU_STARTING_FROZEN check in the acpi_cpu_soft_notify()
Date: Thu, 31 Jul 2014 23:20:04 +0200
Message-ID: <1560513.OlLhy0HTTU@vostro.rjw.lan>
References: <1406798426-16483-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406798426-16483-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thursday, July 31, 2014 05:20:26 PM Lan Tianyu wrote:
> The callback of CPU_STARTING event can't sleep and so acpi_cpu_soft_notify()
> return directly when CPU_STARTING event is triggered. But cpu hotplug also
> happens during S2RAM. The action will become CPU_STARTING_FROZEN. This
> patch is to fix missing check the frozen event.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

There is work to restructure the handling of CPU_TASKS_FROZEN under way
and Chen Gong is driving it.  That's likely to conflict with the last
two patches from you.  Can you pleaes coordinate with Gong?

Rafael


> ---
>  drivers/acpi/processor_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 4fcbd67..66e2249 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -125,7 +125,7 @@ static int acpi_cpu_soft_notify(struct notifier_block *nfb,
>  	 * CPU_STARTING and CPU_DYING must not sleep. Return here since
>  	 * acpi_bus_get_device() may sleep.
>  	 */
> -	if (action == CPU_STARTING || action == CPU_DYING)
> +	if ((action & ~CPU_TASKS_FROZEN) == CPU_STARTING || action == CPU_DYING)
>  		return NOTIFY_DONE;
>  
>  	if (!pr || acpi_bus_get_device(pr->handle, &device))
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
