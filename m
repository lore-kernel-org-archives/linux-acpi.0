From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND PATCH] ACPI: CPPC: Support PCC with interrupt flag
Date: Mon, 26 Sep 2016 14:56:02 +0200
Message-ID: <2457650.luWgNvV3g9@vostro.rjw.lan>
References: <1473875698-12402-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45667 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S933115AbcIZMtl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Sep 2016 08:49:41 -0400
In-Reply-To: <1473875698-12402-1-git-send-email-hotran@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: Len Brown <lenb@kernel.org>, pprakash@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>

On Wednesday, September 14, 2016 10:54:58 AM Hoan Tran wrote:
> For PCC mailbox with interrupt flag, CPPC should call mbox_chan_txdone()
> function to notify the mailbox framework about TX completion.
> 
> Signed-off-by: Hoan Tran <hotran@apm.com>
> Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>
> ---
>  drivers/acpi/cppc_acpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 3d1ae6d..d0d0504 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -311,7 +311,10 @@ static int send_pcc_cmd(u16 cmd)
>  	if (pcc_data.pcc_mrtt)
>  		last_cmd_cmpl_time = ktime_get();
>  
> -	mbox_client_txdone(pcc_data.pcc_channel, ret);
> +	if (pcc_data.pcc_channel->mbox->txdone_irq)
> +		mbox_chan_txdone(pcc_data.pcc_channel, ret);
> +	else
> +		mbox_client_txdone(pcc_data.pcc_channel, ret);
>  
>  end:
>  	if (cmd == CMD_WRITE) {
> 

Applied.

Thanks,
Rafael

