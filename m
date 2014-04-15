From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 3/5] acpi_processor: do not mark present at boot but not onlined CPU as onlined
Date: Tue, 15 Apr 2014 07:48:30 +0200
Message-ID: <1612053.dzUdn6OW1L@vostro.rjw.lan>
References: <1397488277-14865-1-git-send-email-imammedo@redhat.com> <1397488277-14865-4-git-send-email-imammedo@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54846 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750983AbaDOFcX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Apr 2014 01:32:23 -0400
In-Reply-To: <1397488277-14865-4-git-send-email-imammedo@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Igor Mammedov <imammedo@redhat.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, bp@suse.de, paul.gortmaker@windriver.com, JBeulich@suse.com, prarit@redhat.com, drjones@redhat.com, toshi.kani@hp.com, riel@redhat.com, gong.chen@linux.intel.com, andi@firstfloor.org, lenb@kernel.org, linux-acpi@vger.kernel.org

On Monday, April 14, 2014 05:11:15 PM Igor Mammedov wrote:
> acpi_processor_add() assumes that present at boot CPUs
> are always onlined, it is not so if a CPU failed to become
> onlined. As result acpi_processor_add() will mark such CPU
> device as onlined in sysfs and following attempts to
> online/offline it using /sys/device/system/cpu/cpuX/online
> attribute will fail.
> 
> Do not poke into device internals in acpi_processor_add()
> and touch "struct device { .offline }" attribute, since
> for CPUs onlined at boot it's set by:
>   topology_init() -> arch_register_cpu() -> register_cpu()
> before ACPI device tree is parsed, and for hotplugged
> CPUs it's set when userspace onlines CPU via sysfs.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>  - fix regression in v1 leading to NULL pointer dereference
>    on CPU unplug, do not remove "pr->dev = dev;"

Yeah.

Does this patch depend on any other patches in the series?

I don't think so, but just asking.

If it doesn't, why is it part of this series at all?

> ---
>  drivers/acpi/acpi_processor.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index c29c2c3..42d66f8 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -404,7 +404,6 @@ static int acpi_processor_add(struct acpi_device *device,
>  		goto err;
>  
>  	pr->dev = dev;
> -	dev->offline = pr->flags.need_hotplug_init;
>  
>  	/* Trigger the processor driver's .probe() if present. */
>  	if (device_attach(dev) >= 0)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
