From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] ACPI / IPMI: change warning to debug on timeout
Date: Fri, 24 Mar 2017 21:55:07 -0500
Message-ID: <537c0d7a-fd95-2e7f-be07-9e3ca79ca07a@acm.org>
References: <1490283150-24000-1-git-send-email-okaya@codeaurora.org>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490283150-24000-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Why would a timeout for a message be expected?  The BMC should
at least respond with an error for an incorrect message.

-corey

On 03/23/2017 10:32 AM, Sinan Kaya wrote:
> Getting timeout message from BMC when trying to read from a non-existent
> FRU. This is expected but warning is not.
>
> Let's reduce the warning to debug.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>   drivers/acpi/acpi_ipmi.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index 747c2ba..1b64419 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -429,8 +429,7 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
>   	if (msg->recv_type == IPMI_RESPONSE_RECV_TYPE &&
>   	    msg->msg.data_len == 1) {
>   		if (msg->msg.data[0] == IPMI_TIMEOUT_COMPLETION_CODE) {
> -			dev_WARN_ONCE(dev, true,
> -				      "Unexpected response (timeout).\n");
> +			dev_dbg_once(dev, "Unexpected response (timeout).\n");
>   			tx_msg->msg_done = ACPI_IPMI_TIMEOUT;
>   		}
>   		goto out_comp;
