From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 7/7] x86: print out irq nr for msi/ht -v2
Date: Thu, 25 Sep 2008 09:00:24 -0600
Message-ID: <200809250900.24736.bjorn.helgaas@hp.com>
References: <1222323223-23529-1-git-send-email-yhlu.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755017AbYIYP16@vger.kernel.org>
In-Reply-To: <1222323223-23529-1-git-send-email-yhlu.kernel@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 25 September 2008 12:13:43 am Yinghai Lu wrote:
> v2: fix hpet compiling
> 
> Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
> ---
>  arch/x86/kernel/hpet.c    |    3 +++
>  arch/x86/kernel/io_apic.c |    7 +++++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> index 422c577..686505a 100644
> --- a/arch/x86/kernel/hpet.c
> +++ b/arch/x86/kernel/hpet.c
> @@ -467,6 +467,9 @@ static int hpet_setup_irq(struct hpet_dev *dev)
>  	irq_set_affinity(dev->irq, cpumask_of_cpu(dev->cpu));
>  	enable_irq(dev->irq);
>  
> +	printk(KERN_DEBUG "hpet: %s is using irq %#x aka %d for MSI\n",
> +			 dev->name, dev->irq, dev->irq);
> +

Why do we want to print the irq as hex?  Do we do that anywhere else?
I think we should pick one format and stick with it, and I think
decimal is the logical choice because it's the most common.
