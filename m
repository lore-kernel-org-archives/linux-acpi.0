From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RESEND PATCH v7] acpi: apei: remove the unused dead-code for
 SEA/NMI notification type
Date: Sun, 22 Oct 2017 11:38:31 +0200
Message-ID: <CAJZ5v0gAGv2XSfvqx7Dyu1w8csUmoJ96wR667WZp4Dq_beyKHw@mail.gmail.com>
References: <1508655253-20785-1-git-send-email-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:55753 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbdJVJic (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Oct 2017 05:38:32 -0400
In-Reply-To: <1508655253-20785-1-git-send-email-gengdongjiu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Prarit Bhargava <prarit@redhat.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Oct 22, 2017 at 8:54 AM, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> For the SEA notification, the two functions ghes_sea_add() and
> ghes_sea_remove() are only called when CONFIG_ACPI_APEI_SEA
> is defined. If not, it will return errors in the ghes_probe()
> and not continue. If the probe is failed, the ghes_sea_remove()
> also has no chance to be called. Hence, remove the unnecessary
> handling when CONFIG_ACPI_APEI_SEA is not defined.
>
> For the NMI notification, it has the same issue as SEA notification,
> so also remove the unused dead-code for it.
>
> Cc: Tyler Baicar <tbaicar@codeaurora.org>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> Reviewed-by: Borislav Petkov <bp@suse.de>

I applied one of the previous iterations.

Do I need to replace it with this version?

> ---
>  drivers/acpi/apei/ghes.c | 33 +++++----------------------------
>  1 file changed, 5 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d661d45..3eee30a 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -849,17 +849,8 @@ static void ghes_sea_remove(struct ghes *ghes)
>         synchronize_rcu();
>  }
>  #else /* CONFIG_ACPI_APEI_SEA */
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
> +static inline void ghes_sea_add(struct ghes *ghes) { }
> +static inline void ghes_sea_remove(struct ghes *ghes) { }
>  #endif /* CONFIG_ACPI_APEI_SEA */
>
>  #ifdef CONFIG_HAVE_ACPI_APEI_NMI
> @@ -1061,23 +1052,9 @@ static void ghes_nmi_init_cxt(void)
>         init_irq_work(&ghes_proc_irq_work, ghes_proc_in_irq);
>  }
>  #else /* CONFIG_HAVE_ACPI_APEI_NMI */
> -static inline void ghes_nmi_add(struct ghes *ghes)
> -{
> -       pr_err(GHES_PFX "ID: %d, trying to add NMI notification which is not supported!\n",
> -              ghes->generic->header.source_id);
> -       BUG();
> -}
> -
> -static inline void ghes_nmi_remove(struct ghes *ghes)
> -{
> -       pr_err(GHES_PFX "ID: %d, trying to remove NMI notification which is not supported!\n",
> -              ghes->generic->header.source_id);
> -       BUG();
> -}
> -
> -static inline void ghes_nmi_init_cxt(void)
> -{
> -}
> +static inline void ghes_nmi_add(struct ghes *ghes) { }
> +static inline void ghes_nmi_remove(struct ghes *ghes) { }
> +static inline void ghes_nmi_init_cxt(void) { }
>  #endif /* CONFIG_HAVE_ACPI_APEI_NMI */
>
>  static int ghes_probe(struct platform_device *ghes_dev)
> --
> 2.10.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
