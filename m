From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH V2] acpi:apei:handle GSIV and GPIO notification types
Date: Tue, 18 Apr 2017 18:35:21 +0200
Message-ID: <20170418163521.c6bg73p43sjllxnr@pd.tnic>
References: <86258A5CC0A3704780874CF6004BA8A62DCBFF56@lhreml502-mbs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44109 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754869AbdDRQfj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 12:35:39 -0400
Content-Disposition: inline
In-Reply-To: <86258A5CC0A3704780874CF6004BA8A62DCBFF56@lhreml502-mbs>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "prarit@redhat.com" <prarit@redhat.com>, "tbaicar@codeaurora.org" <tbaicar@codeaurora.org>, "punit.agrawal@arm.com" <punit.agrawal@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "james.morse@arm.com" <james.morse@arm.com>, "fu.wei@linaro.org" <fu.wei@linaro.org>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, John Garry <john.garry@huawei.com>, "xuwei (O)" <xuwei5@hisilicon.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>

Just nitpicks below.

On Thu, Mar 16, 2017 at 04:08:17PM +0000, Shiju Jose wrote:
> System Controller Interrupts are received by ACPI's error device,
> which in turn notifies the GHES code. The same is true of
> APEI's GSIV and GPIO notification types.
> Add support for GSIV and GPIO sharing the SCI
> register/unregister/notifier code.Rename the list and notifier
> to show this is no longer just SCI, but anything from the
> Hardware Error Device.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> [james.morse@arm.com: rewrote commit log]
> Signed-off-by: James Morse <james.morse@arm.com>
> CC: James Morse <james.morse@arm.com>
> CC: Hanjun Guo <guohanjun@huawei.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index b192b42..fd39929 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -89,14 +89,14 @@
>  module_param_named(disable, ghes_disable, bool, 0);
>  
>  /*
> - * All error sources notified with SCI shares one notifier function,
> + * All error sources notified with HED shares one notifier function,

s/shares one notifier function/share a single notifier callback/

Also, let's write out here what HED stands for.

>   * so they need to be linked and checked one by one.  This is applied
>   * to NMI too.

This sentence wants to say "This holds true for NMIs too." I presume?

>   *
>   * RCU is used for these lists, so ghes_list_mutex is only used for
>   * list changing, not for traversing.
>   */
> -static LIST_HEAD(ghes_sci);
> +static LIST_HEAD(ghes_hed);
>  static DEFINE_MUTEX(ghes_list_mutex);
>  
>  /*
> @@ -702,14 +702,14 @@ static irqreturn_t ghes_irq_func(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static int ghes_notify_sci(struct notifier_block *this,
> +static int ghes_notify_hed(struct notifier_block *this,
>  				  unsigned long event, void *data)

Align args at opening brace.

>  {
>  	struct ghes *ghes;
>  	int ret = NOTIFY_DONE;
>  
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(ghes, &ghes_sci, list) {
> +	list_for_each_entry_rcu(ghes, &ghes_hed, list) {
>  		if (!ghes_proc(ghes))
>  			ret = NOTIFY_OK;
>  	}
> @@ -718,8 +718,8 @@ static int ghes_notify_sci(struct notifier_block *this,
>  	return ret;
>  }
>  
> -static struct notifier_block ghes_notifier_sci = {
> -	.notifier_call = ghes_notify_sci,
> +static struct notifier_block ghes_notifier_hed = {
> +	.notifier_call = ghes_notify_hed,
>  };
>  
>  #ifdef CONFIG_HAVE_ACPI_APEI_NMI
> @@ -966,6 +966,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
>  	case ACPI_HEST_NOTIFY_POLLED:
>  	case ACPI_HEST_NOTIFY_EXTERNAL:
>  	case ACPI_HEST_NOTIFY_SCI:
> +	case ACPI_HEST_NOTIFY_GSIV:
> +	case ACPI_HEST_NOTIFY_GPIO:
>  		break;

<-- \n here for readability.

>  	case ACPI_HEST_NOTIFY_NMI:
>  		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) {
> @@ -1026,10 +1028,12 @@ static int ghes_probe(struct platform_device *ghes_dev)
>  		}
>  		break;

ditto.

>  	case ACPI_HEST_NOTIFY_SCI:
> +	case ACPI_HEST_NOTIFY_GSIV:
> +	case ACPI_HEST_NOTIFY_GPIO:
>  		mutex_lock(&ghes_list_mutex);
> -		if (list_empty(&ghes_sci))
> -			register_acpi_hed_notifier(&ghes_notifier_sci);
> -		list_add_rcu(&ghes->list, &ghes_sci);
> +		if (list_empty(&ghes_hed))
> +			register_acpi_hed_notifier(&ghes_notifier_hed);
> +		list_add_rcu(&ghes->list, &ghes_hed);
>  		mutex_unlock(&ghes_list_mutex);
>  		break;

ditto.

>  	case ACPI_HEST_NOTIFY_NMI:
> @@ -1068,10 +1072,12 @@ static int ghes_remove(struct platform_device *ghes_dev)
>  		free_irq(ghes->irq, ghes);
>  		break;
>  	case ACPI_HEST_NOTIFY_SCI:
> +	case ACPI_HEST_NOTIFY_GSIV:
> +	case ACPI_HEST_NOTIFY_GPIO:
>  		mutex_lock(&ghes_list_mutex);
>  		list_del_rcu(&ghes->list);
> -		if (list_empty(&ghes_sci))
> -			unregister_acpi_hed_notifier(&ghes_notifier_sci);
> +		if (list_empty(&ghes_hed))
> +			unregister_acpi_hed_notifier(&ghes_notifier_hed);
>  		mutex_unlock(&ghes_list_mutex);
>  		break;

ditto.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
