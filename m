From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM/Sleep, ACPI: Teach acpi_cpu_soft_notify() to handle CPU hotplug in suspend/resume path
Date: Sun, 4 Mar 2012 23:33:18 +0100
Message-ID: <201203042333.18501.rjw@sisk.pl>
References: <20120228155137.3061.97133.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54779 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179Ab2CDW3M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 Mar 2012 17:29:12 -0500
In-Reply-To: <20120228155137.3061.97133.stgit@srivatsabhat.in.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: lenb@kernel.org, deepthi@linux.vnet.ibm.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tuesday, February 28, 2012, Srivatsa S. Bhat wrote:
> acpi_cpu_soft_notify handles only CPU_ONLINE and CPU_DEAD events. However,
> during a system-wide suspend/hibernation operation, CPU_ONLINE_FROZEN and
> CPU_DEAD_FROZEN events are sent as part of CPU hotplug.
> 
> Those events are really no different from regular CPU hotplug in this context,
> and hence acpi shouldn't ignore them. So, teach acpi_cpu_soft_notify() to
> handle those events as well.
> 
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
> I am no ACPI expert! So requesting a thorough review of this patch..

Well, as far as I can tell, it _looks_ correct.  That said, I don't think
anyone will really tell you on the basis of code review alone, this requires
testing.

Since Len hasn't been very responsive recently, I can take this patch into
linux-pm/linux-next and see what the feedback is.

Thanks,
Rafael


>  drivers/acpi/processor_driver.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 2801b41..3a87b13 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -422,6 +422,12 @@ static int acpi_cpu_soft_notify(struct notifier_block *nfb,
>  	unsigned int cpu = (unsigned long)hcpu;
>  	struct acpi_processor *pr = per_cpu(processors, cpu);
>  
> +	/*
> +	 * Regular CPU hotplug, and CPU hotplug as part of the suspend/resume
> +	 * sequence are really no different for us. So, let us handle both.
> +	 */
> +	action &= ~CPU_TASKS_FROZEN;
> +
>  	if (action == CPU_ONLINE && pr) {
>  		/* CPU got physically hotplugged and onlined the first time:
>  		 * Initialize missing things
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

