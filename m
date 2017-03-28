From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH] acpi: apei: check for pending errors when probing HED
 type GHES entries
Date: Tue, 28 Mar 2017 16:00:17 -0600
Message-ID: <ffbdbfba-9b52-a4cb-d310-5ef0f3020e95@redhat.com>
References: <1490732054-4720-1-git-send-email-tbaicar@codeaurora.org>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:35156 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbdC1WAc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2017 18:00:32 -0400
Received: by mail-qt0-f180.google.com with SMTP id x35so76406545qtc.2
        for <linux-acpi@vger.kernel.org>; Tue, 28 Mar 2017 15:00:26 -0700 (PDT)
In-Reply-To: <1490732054-4720-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>, rjw@rjwysocki.net, lenb@kernel.org, bp@suse.de, prarit@redhat.com, bhelgaas@google.com, punit.agrawal@arm.com, mingo@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, shiju.jose@huawei.com, James.Morse@arm.com

On 03/28/2017 02:14 PM, Tyler Baicar wrote:
> If a HED type error occurs prior to GHES probing, the kernel will
> never report the error. The HED driver will see that no notifiers
> are registers, and clear the interrupt.

..."registers" or "registered"?

> This becomes a more serious problem with firmware that supports
> GHESv2 acknowledgements from the kernel. The firmware will populate
> the error and wait for the kernel ack. But since the kernel will
> never process the error we get into a state that the firmware will
> not send any more errors and the kernel will never see or ack the
> original error.
> 
> Check for pending errors when probing HED type GHES entries to
> avoid the above situation.
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


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
