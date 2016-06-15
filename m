From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH] mailbox: pcc: Add PCC request and free channel
 declarations
Date: Wed, 15 Jun 2016 09:55:06 -0600
Message-ID: <a249986e-dcd2-5b51-4707-6bd38fa17912@codeaurora.org>
References: <1465945963-22353-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33944 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbcFOPzL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2016 11:55:11 -0400
In-Reply-To: <1465945963-22353-1-git-send-email-hotran@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hoan Tran <hotran@apm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org, lho@apm.com, Duc Dang <dhdang@apm.com>

Hi Hoan,

On 6/14/2016 5:12 PM, Hoan Tran wrote:
> As PCC will be used by other clients not only CPPC.
> This change exports pcc_mbox_request_channel() and pcc_mbox_free_channel()
> declarations
>
> Signed-off-by: Hoan Tran <hotran@apm.com>
> ---
>  include/acpi/cppc_acpi.h       | 4 ----
>  include/linux/mailbox_client.h | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index dad8af3..819b4b9 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -130,8 +130,4 @@ extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
>  extern int acpi_get_psd_map(struct cpudata **);
>  
> -/* Methods to interact with the PCC mailbox controller. */
> -extern struct mbox_chan *
> -	pcc_mbox_request_channel(struct mbox_client *, unsigned int);
> -
>  #endif /* _CPPC_ACPI_H*/
> diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
> index 41e2af8..2758d18 100644
> --- a/include/linux/mailbox_client.h
> +++ b/include/linux/mailbox_client.h
> @@ -50,4 +50,8 @@ void mbox_client_txdone(struct mbox_chan *chan, int r); /* atomic */
>  bool mbox_client_peek_data(struct mbox_chan *chan); /* atomic */
>  void mbox_free_channel(struct mbox_chan *chan); /* may sleep */
>  
> +/* Methods to interact with the PCC mailbox controller. */
> +struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *, int);
> +void pcc_mbox_free_channel(struct mbox_chan *chan);
> +
Since these APIs are specific to PCC, may be we should introduce a new header for pcc clients
instead of adding to the common mailbox_client header.
>  #endif /* __MAILBOX_CLIENT_H */

Thanks,
Prashanth
