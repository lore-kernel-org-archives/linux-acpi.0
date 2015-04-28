From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Tue, 28 Apr 2015 13:38:41 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880270F835@SHSMSX101.ccr.corp.intel.com>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427448178-20689-6-git-send-email-bp@alien8.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, linux-edac <linux-edac@vger.kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I was talking about this patch.

> From: Borislav Petkov [mailto:bp@alien8.de]
> Sent: Friday, March 27, 2015 5:23 PM
> Subject: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
> 
> From: Jiri Kosina <jkosina@suse.cz>
> 
> Since GHES sources are global, we theoretically need only a single CPU
> reading them per NMI instead of a thundering herd of CPUs waiting on a
> spinlock in NMI context for no reason at all.
> 
> Do that.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  drivers/acpi/apei/ghes.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 94a44bad5576..2bfd53cbfe80 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -729,10 +729,10 @@ static struct llist_head ghes_estatus_llist;
>  static struct irq_work ghes_proc_irq_work;
> 
>  /*
> - * NMI may be triggered on any CPU, so ghes_nmi_lock is used for
> - * mutual exclusion.
> + * NMI may be triggered on any CPU, so ghes_in_nmi is used for
> + * having only one concurrent reader.
>   */
> -static DEFINE_RAW_SPINLOCK(ghes_nmi_lock);
> +static atomic_t ghes_in_nmi = ATOMIC_INIT(0);
> 
>  static LIST_HEAD(ghes_nmi);
> 
> @@ -840,7 +840,9 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>  	struct ghes *ghes;
>  	int sev, ret = NMI_DONE;
> 
> -	raw_spin_lock(&ghes_nmi_lock);
> +	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
> +		return ret;
> +

if (atomic_cmpxchg(&ghes_in_nmi, 0, 1))
	return ret;

>  	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
>  		if (ghes_read_estatus(ghes, 1)) {
>  			ghes_clear_estatus(ghes);
> @@ -863,7 +865,7 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>  #ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	irq_work_queue(&ghes_proc_irq_work);
>  #endif
> -	raw_spin_unlock(&ghes_nmi_lock);
> +	atomic_dec(&ghes_in_nmi);

atomic_set(&ghes_in_nmi, 0);

It seems most of the drivers (under drivers/) are written in this way.
While the user of atomic_add_unless() is rare.

Can this work for you?

Thanks and best regards
-Lv

>  	return ret;
>  }
> 
> --
> 2.3.3
