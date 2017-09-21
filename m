From: gengdongjiu <gengdj.1984@gmail.com>
Subject: Re: [PATCH v2] acpi: apei: remove the unused dead-code for SEA
 notification type
Date: Fri, 22 Sep 2017 03:55:56 +0800
Message-ID: <CAMj-D2CwPCjpMokyFC71ha9cgLaNbxkN3OpTa1ygoTXigSiDbQ@mail.gmail.com>
References: <1505300558-1242-1-git-send-email-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33019 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbdIUTz5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Sep 2017 15:55:57 -0400
Received: by mail-vk0-f68.google.com with SMTP id j189so1751310vka.0
        for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2017 12:55:57 -0700 (PDT)
In-Reply-To: <1505300558-1242-1-git-send-email-gengdongjiu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: rjw@rjwysocki.net, Tyler Baicar <tbaicar@codeaurora.org>, Borislav Petkov <bp@suse.de>, Punit Agrawal <punit.agrawal@arm.com>, Shiju Jose <shiju.jose@huawei.com>, linux-acpi@vger.kernel.org, zhengqiang10@huawei.com

HI Borislav, Tyler, Rafael,
    sorry to disturb you. whether it is possible you can give a review
for this patch and below patch, seems it is pending long time. thank
you very much in advance for your time.

   https://patchwork.kernel.org/patch/9952493/

2017-09-13 19:02 GMT+08:00 Dongjiu Geng <gengdongjiu@huawei.com>:
> In current code logic, the two functions ghes_sea_add() and
> ghes_sea_remove() are only called when CONFIG_ACPI_APEI_SEA
> is defined. If not, it will return errors in the ghes_probe()
> and not continue. If the probe is failed, the ghes_sea_remove()
> also has no chance to be called.
>
> Hence, remove the unnecessary handling when CONFIG_ACPI_APEI_SEA
> is not defined.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>
> ---
> It is ever discussed here:
> https://lkml.org/lkml/2017/9/8/623
> ---
>  drivers/acpi/apei/ghes.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d661d452b238..c15a08db2c7c 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -813,7 +813,6 @@ static struct notifier_block ghes_notifier_hed = {
>         .notifier_call = ghes_notify_hed,
>  };
>
> -#ifdef CONFIG_ACPI_APEI_SEA
>  static LIST_HEAD(ghes_sea);
>
>  /*
> @@ -848,19 +847,6 @@ static void ghes_sea_remove(struct ghes *ghes)
>         mutex_unlock(&ghes_list_mutex);
>         synchronize_rcu();
>  }
> -#else /* CONFIG_ACPI_APEI_SEA */
> -static inline void ghes_sea_add(struct ghes *ghes)
> -{
> -       pr_err(GHES_PFX "ID: %d, trying to add SEA notification which is not supported\n",
> -              ghes->generic->header.source_id);
> -}
> -
> -static inline void ghes_sea_remove(struct ghes *ghes)
> -{
> -       pr_err(GHES_PFX "ID: %d, trying to remove SEA notification which is not supported\n",
> -              ghes->generic->header.source_id);
> -}
> -#endif /* CONFIG_ACPI_APEI_SEA */
>
>  #ifdef CONFIG_HAVE_ACPI_APEI_NMI
>  /*
> --
> 2.14.1
>
