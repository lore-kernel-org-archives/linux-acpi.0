From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 1/1] acpi:apei:handle GSIV and GPIO notification types
Date: Thu, 16 Mar 2017 14:25:49 +0000
Message-ID: <58CAA06D.7010900@arm.com>
References: <86258A5CC0A3704780874CF6004BA8A62DCB6D39@lhreml502-mbx>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbdCPO0H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Mar 2017 10:26:07 -0400
In-Reply-To: <86258A5CC0A3704780874CF6004BA8A62DCB6D39@lhreml502-mbx>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "bp@suse.de" <bp@suse.de>, "mingo@kernel.org" <mingo@kernel.org>, "prarit@redhat.com" <prarit@redhat.com>, "tbaicar@codeaurora.org" <tbaicar@codeaurora.org>, "punit.agrawal@arm.com" <punit.agrawal@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "fu.wei@linaro.org" <fu.wei@linaro.org>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, John Garry <john.garry@huawei.com>, "xuwei (O)" <xuwei5@hisilicon.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>

On 13/03/17 13:16, Shiju Jose wrote:
> System Controller Interrupts are received by ACPI's error device,
> which in turn notifies the GHES code. The same is true of
> APEI's GSIV and GPIO notification types.
> Add support for GSIV and GPIO sharing the SCI
> register/unregister/notifier code.Rename the list and notifier
> to show this is no longer just SCI, but anything from the
> Hardware Error Device.

Reviewed-by: James Morse <james.morse@arm.com>


... what looks like an existing bug:

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index b192b42..fd39929 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1068,10 +1072,12 @@ static int ghes_remove(struct platform_device *ghes_dev)
>  		free_irq(ghes->irq, ghes);
>  		break;
>  	case ACPI_HEST_NOTIFY_SCI:
> +	case ACPI_HEST_NOTIFY_GSIV:
> +	case ACPI_HEST_NOTIFY_GPIO:
>  		mutex_lock(&ghes_list_mutex);

>  		list_del_rcu(&ghes->list);

Suspiciously, there is no synchronize_rcu() between this list_del_rcu() and the
kfree(ghes) at the bottom of the function. It looks like 81e88fdc432a lifted it
into the NOTIFY_NMI path. I will send a separate fix.


> -		if (list_empty(&ghes_sci))
> -			unregister_acpi_hed_notifier(&ghes_notifier_sci);
> +		if (list_empty(&ghes_hed))
> +			unregister_acpi_hed_notifier(&ghes_notifier_hed);
>  		mutex_unlock(&ghes_list_mutex);
>  		break;
>  	case ACPI_HEST_NOTIFY_NMI:
> 


Thanks,

James
