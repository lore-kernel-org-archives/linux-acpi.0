From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 03/13] ACPI/IPMI: Fix race caused by the unprotected ACPI IPMI transfers
Date: Thu, 25 Jul 2013 01:38:15 +0200
Message-ID: <1520893.BbRK6T3F73@vostro.rjw.lan>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1374566394.git.lv.zheng@intel.com> <970a8a7108e4c95ce09e34eee03eb5731645729f.1374566394.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <970a8a7108e4c95ce09e34eee03eb5731645729f.1374566394.git.lv.zheng@intel.com>
Sender: stable-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Tuesday, July 23, 2013 04:09:15 PM Lv Zheng wrote:
> This patch fixes races caused by unprotected ACPI IPMI transfers.
> 
> We can see the following crashes may occur:
> 1. There is no tx_msg_lock held for iterating tx_msg_list in
>    ipmi_flush_tx_msg() while it is parellel unlinked on failure in
>    acpi_ipmi_space_handler() under protection of tx_msg_lock.
> 2. There is no lock held for freeing tx_msg in acpi_ipmi_space_handler()
>    while it is parellel accessed in ipmi_flush_tx_msg() and
>    ipmi_msg_handler().
> 
> This patch enhances tx_msg_lock to protect all tx_msg accesses to solve
> this issue.  Then tx_msg_lock is always held around complete() and tx_msg
> accesses.
> Calling smp_wmb() before setting msg_done flag so that messages completed
> due to flushing will not be handled as 'done' messages while their contents
> are not vaild.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Cc: Zhao Yakui <yakui.zhao@intel.com>
> Reviewed-by: Huang Ying <ying.huang@intel.com>
> ---
>  drivers/acpi/acpi_ipmi.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index b37c189..527ee43 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -230,11 +230,14 @@ static void ipmi_flush_tx_msg(struct acpi_ipmi_device *ipmi)
>  	struct acpi_ipmi_msg *tx_msg, *temp;
>  	int count = HZ / 10;
>  	struct pnp_dev *pnp_dev = ipmi->pnp_dev;
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&ipmi->tx_msg_lock, flags);
>  	list_for_each_entry_safe(tx_msg, temp, &ipmi->tx_msg_list, head) {
>  		/* wake up the sleep thread on the Tx msg */
>  		complete(&tx_msg->tx_complete);
>  	}
> +	spin_unlock_irqrestore(&ipmi->tx_msg_lock, flags);
>  
>  	/* wait for about 100ms to flush the tx message list */
>  	while (count--) {
> @@ -268,13 +271,12 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
>  			break;
>  		}
>  	}
> -	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
>  
>  	if (!msg_found) {
>  		dev_warn(&pnp_dev->dev,
>  			 "Unexpected response (msg id %ld) is returned.\n",
>  			 msg->msgid);
> -		goto out_msg;
> +		goto out_lock;
>  	}
>  
>  	/* copy the response data to Rx_data buffer */
> @@ -286,10 +288,14 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
>  	}
>  	tx_msg->rx_len = msg->msg.data_len;
>  	memcpy(tx_msg->data, msg->msg.data, tx_msg->rx_len);
> +	/* tx_msg content must be valid before setting msg_done flag */
> +	smp_wmb();

That's suspicious.

If you need the write barrier here, you'll most likely need a read barrier
somewhere else.  Where's that?

>  	tx_msg->msg_done = 1;
>  
>  out_comp:
>  	complete(&tx_msg->tx_complete);
> +out_lock:
> +	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
>  out_msg:
>  	ipmi_free_recv_msg(msg);
>  }

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
