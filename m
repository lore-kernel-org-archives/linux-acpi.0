From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] mailbox: pcc: Add PCC request and free channel declarations
Date: Thu, 23 Jun 2016 02:49:34 +0200
Message-ID: <2673488.DmxRkxKR3W@vostro.rjw.lan>
References: <1466111378-4390-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466111378-4390-1-git-send-email-hotran@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hoan Tran <hotran@apm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, pprakash@codeaurora.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org, lho@apm.com, Duc Dang <dhdang@apm.com>
List-Id: linux-acpi@vger.kernel.org

On Thursday, June 16, 2016 02:09:38 PM Hoan Tran wrote:
> Exports pcc_mbox_request_channel() and pcc_mbox_free_channel()
> declarations into a pcc.h header file.
> 
> v2
>  * Introduce pcc.h header file for pcc client methods
> 
> v1
>  * Initial
> 
> Signed-off-by: Hoan Tran <hotran@apm.com>

Ashwin, Prakash, any comments anyone?

> ---
>  include/acpi/cppc_acpi.h |  7 +------
>  include/acpi/pcc.h       | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 6 deletions(-)
>  create mode 100644 include/acpi/pcc.h
> 
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 259683a..ab1da43 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -15,10 +15,9 @@
>  #define _CPPC_ACPI_H
>  
>  #include <linux/acpi.h>
> -#include <linux/mailbox_controller.h>
> -#include <linux/mailbox_client.h>
>  #include <linux/types.h>
>  
> +#include <acpi/pcc.h>
>  #include <acpi/processor.h>
>  
>  /* Only support CPPCv2 for now. */
> @@ -131,8 +130,4 @@ extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
>  extern int acpi_get_psd_map(struct cpudata **);
>  
> -/* Methods to interact with the PCC mailbox controller. */
> -extern struct mbox_chan *
> -	pcc_mbox_request_channel(struct mbox_client *, unsigned int);
> -
>  #endif /* _CPPC_ACPI_H*/
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> new file mode 100644
> index 0000000..17a940a
> --- /dev/null
> +++ b/include/acpi/pcc.h
> @@ -0,0 +1,29 @@
> +/*
> + * PCC (Platform Communications Channel) methods
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2
> + * of the License.
> + */
> +
> +#ifndef _PCC_H
> +#define _PCC_H
> +
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox_client.h>
> +
> +#ifdef CONFIG_PCC
> +extern struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
> +						  int subspace_id);
> +extern void pcc_mbox_free_channel(struct mbox_chan *chan);
> +#else
> +static inline struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
> +							 int subspace_id)
> +{
> +	return NULL;
> +}
> +static inline void pcc_mbox_free_channel(struct mbox_chan *chan) { }
> +#endif
> +
> +#endif /* _PCC_H */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
