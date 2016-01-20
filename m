From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH 4/4] acpi: cppc: replace writeX/readX to PCC with relaxed version
Date: Wed, 20 Jan 2016 17:18:15 -0500
Message-ID: <CAJ5Y-eY3=7DoXjp2t-zs7dHhN4VfZ7pnZusxpn6zD6GhUzKSbg@mail.gmail.com>
References: <1452883415-24452-1-git-send-email-pprakash@codeaurora.org> <1452883415-24452-5-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36116 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965089AbcATWSg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2016 17:18:36 -0500
Received: by mail-lb0-f174.google.com with SMTP id oh2so13262470lbb.3
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jan 2016 14:18:35 -0800 (PST)
In-Reply-To: <1452883415-24452-5-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>

On 15 January 2016 at 13:43, Prashanth Prakash <pprakash@codeaurora.org> wrote:
> We do not have a strict read/write order requirement while accessing
> PCC subspace. The only requirement is all access should be committed
> before triggering the PCC doorbell to transfer the ownership of PCC
> to the platform and this requirement is enforced by the PCC driver.
>
> Profiling on a many core system shows improvement of about 1.8us on
> average per freq change request(about 10% improvement on average).
> Since these operations are executed while holding the pcc_lock,
> reducing this time helps the CPPC implementation to scale much
> better as the number of cores increases.
>
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> ---
>  drivers/acpi/cppc_acpi.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>

Acked-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>

> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index b85759d..87936d7 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -119,10 +119,10 @@ static int send_pcc_cmd(u16 cmd)
>         }
>
>         /* Write to the shared comm region. */
> -       writew(cmd, &generic_comm_base->command);
> +       writew_relaxed(cmd, &generic_comm_base->command);
>
>         /* Flip CMD COMPLETE bit */
> -       writew(0, &generic_comm_base->status);
> +       writew_relaxed(0, &generic_comm_base->status);
>
>         /* Ring doorbell */
>         ret = mbox_send_message(pcc_channel, &cmd);
> @@ -604,16 +604,16 @@ static int cpc_read(struct cpc_reg *reg, u64 *val)
>
>                 switch (reg->bit_width) {
>                 case 8:
> -                       *val = readb(vaddr);
> +                       *val = readb_relaxed(vaddr);
>                         break;
>                 case 16:
> -                       *val = readw(vaddr);
> +                       *val = readw_relaxed(vaddr);
>                         break;
>                 case 32:
> -                       *val = readl(vaddr);
> +                       *val = readl_relaxed(vaddr);
>                         break;
>                 case 64:
> -                       *val = readq(vaddr);
> +                       *val = readq_relaxed(vaddr);
>                         break;
>                 default:
>                         pr_debug("Error: Cannot read %u bit width from PCC\n",
> @@ -635,16 +635,16 @@ static int cpc_write(struct cpc_reg *reg, u64 val)
>
>                 switch (reg->bit_width) {
>                 case 8:
> -                       writeb(val, vaddr);
> +                       writeb_relaxed(val, vaddr);
>                         break;
>                 case 16:
> -                       writew(val, vaddr);
> +                       writew_relaxed(val, vaddr);
>                         break;
>                 case 32:
> -                       writel(val, vaddr);
> +                       writel_relaxed(val, vaddr);
>                         break;
>                 case 64:
> -                       writeq(val, vaddr);
> +                       writeq_relaxed(val, vaddr);
>                         break;
>                 default:
>                         pr_debug("Error: Cannot write %u bit width to PCC\n",
> --
> Qualcomm Technologies, Inc. on behalf
> of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc.
> is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
>
