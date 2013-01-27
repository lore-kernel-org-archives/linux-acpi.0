From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Fix /proc/acpi/wakeup for devices w/o bus or parent
Date: Sun, 27 Jan 2013 23:46:25 +0100
Message-ID: <1577239.v3IDhcnSN4@vostro.rjw.lan>
References: <51053713.6090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:57380 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755199Ab3A0WkR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Jan 2013 17:40:17 -0500
In-Reply-To: <51053713.6090804@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Fleig <andreasfleig@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sunday, January 27, 2013 03:17:55 PM Andreas Fleig wrote:
> Fix /proc/acpi/wakeup for devices without bus or parent
> 
> This patch fixes printing the wakeup status for devices without a bus
> or parent, such as laptop lid switches and sleep buttons. These devices
> have an empty physical_node_list, because acpi_bind_one is never run
> for them.
> 
> Signed-off-by: Andreas Fleig <andreasfleig@gmail.com>

OK, I'm going to take this (but I'm going to fix white space while applying it).

Thanks,
Rafael


> ---
> diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
> index 27adb09..3623ea8 100644
> --- a/drivers/acpi/proc.c
> +++ b/drivers/acpi/proc.c
> @@ -314,7 +314,8 @@ acpi_system_wakeup_device_seq_show(struct seq_file 
> *seq, void *offset)
>   		if (!dev->physical_node_count)
>   			seq_printf(seq, "%c%-8s\n",
>   				dev->wakeup.flags.run_wake ?
> -				'*' : ' ', "disabled");
> +				'*' : ' ', device_may_wakeup(&dev->dev) ?
> +				"enabled" : "disabled");
>   		else {
>   			struct device *ldev;
>   			list_for_each_entry(entry, &dev->physical_node_list,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
