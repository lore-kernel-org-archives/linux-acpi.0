From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] mailbox: PCC: Fix return value of pcc_mbox_request_channel()
Date: Fri, 21 Oct 2016 23:31:18 +0200
Message-ID: <9431714.tmtHQX6MJq@vostro.rjw.lan>
References: <1476487221-20337-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476487221-20337-1-git-send-email-hotran@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Prakash Prashanth <pprakash@codeaurora.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On Friday, October 14, 2016 04:20:21 PM Hoan Tran wrote:
> When CONFIG_PCC is disabled, pcc_mbox_request_channel() needs to
> return ERR_PTR(-ENODEV), not a NULL pointer, as the callers of
> this function use IS_ERR() to check for error code.
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>
> Signed-off-by: Hoan Tran <hotran@apm.com>
> ---
>  include/acpi/pcc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index 17a940a..8caa79c 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -21,7 +21,7 @@ extern struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
>  static inline struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
>  							 int subspace_id)
>  {
> -	return NULL;
> +	return ERR_PTR(-ENODEV);
>  }
>  static inline void pcc_mbox_free_channel(struct mbox_chan *chan) { }
>  #endif
> 

Applied.

Thanks,
Rafael
