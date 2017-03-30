From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH V2] acpi: apei: check for pending errors when probing
 HED type GHES entries
Date: Thu, 30 Mar 2017 18:30:38 +0100
Message-ID: <58DD40BE.9000506@arm.com>
References: <1490802880-10239-1-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933259AbdC3RbB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Mar 2017 13:31:01 -0400
In-Reply-To: <1490802880-10239-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, bp@suse.de, prarit@redhat.com, bhelgaas@google.com, punit.agrawal@arm.com, mingo@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, shiju.jose@huawei.com, ahs3@redhat.com

Hi Tyler,

On 29/03/17 16:54, Tyler Baicar wrote:
> If a HED type error occurs prior to GHES probing, the kernel will
> never report the error. The HED driver will see that no notifiers
> are registered, and clear the interrupt.
> 
> This becomes a more serious problem with firmware that supports
> GHESv2 acknowledgements from the kernel. The firmware will populate
> the error and wait for the kernel ack. But since the kernel will
> never process the error we get into a state that the firmware will
> not send any more errors and the kernel will never see or ack the
> original error.
> 
> Check for pending errors when probing HED type GHES entries to
> avoid the above situation.

Isn't this a problem for the other notification types too?

It looks like SEI can indicate the notification is non-fatal even if we haven't
done the ghes_probe() yet and fail to find the CPER records.

Would moving the OSC call to set the APEI bit later solve this, or is it
specific to the way AMLs Notify() works?


Thanks,

James


> 
> This patch is based on Shiju's patch that adds support for GSIV
> and GPIO notification types:
> https://patchwork.kernel.org/patch/9628817/
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/acpi/apei/ghes.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index fd39929..cf5e938 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1035,6 +1035,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
>  			register_acpi_hed_notifier(&ghes_notifier_hed);
>  		list_add_rcu(&ghes->list, &ghes_hed);
>  		mutex_unlock(&ghes_list_mutex);
> +		ghes_proc(ghes);
>  		break;
>  	case ACPI_HEST_NOTIFY_NMI:
>  		ghes_nmi_add(ghes);
> 

