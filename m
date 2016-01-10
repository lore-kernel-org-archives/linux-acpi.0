From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
Date: Sun, 10 Jan 2016 12:07:14 +0100
Message-ID: <20160110110714.GA22896@pd.tnic>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <1446857519-5908-2-git-send-email-lho@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:43030 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754885AbcAJLHZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Jan 2016 06:07:25 -0500
Content-Disposition: inline
In-Reply-To: <1446857519-5908-2-git-send-email-lho@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Loc Ho <lho@apm.com>
Cc: dougthompson@xmission.com, mchehab@osg.samsung.com, tomasz.nowicki@linaro.org, fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, jcm@redhat.com, patches@apm.com, Tuan Phan <tphan@apm.com>

On Fri, Nov 06, 2015 at 05:51:58PM -0700, Loc Ho wrote:
> The function acpi_gsi_to_irq should returns 0 on success as upper function
> caller expect an 0 for sucesss.
> 
> Signed-off-by: Tuan Phan <tphan@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  drivers/acpi/gsi.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
> index fa4585a..0ed1003 100644
> --- a/drivers/acpi/gsi.c
> +++ b/drivers/acpi/gsi.c
> @@ -43,7 +43,7 @@ static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
>   *
>   * irq location updated with irq value [>0 on success, 0 on failure]
>   *
> - * Returns: linux IRQ number on success (>0)
> + * Returns: 0 on success
>   *          -EINVAL on failure
>   */
>  int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> @@ -56,7 +56,7 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>  	 * *irq == 0 means no mapping, that should
>  	 * be reported as a failure
>  	 */
> -	return (*irq > 0) ? *irq : -EINVAL;
> +	return (*irq > 0) ? 0 : -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);

That function can be simplified. It should be made to return the irq
number on success and 0 on failure. No need for that *irq output
argument.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
