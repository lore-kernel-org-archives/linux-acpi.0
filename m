From: "Yinghai Lu" <yinghai@kernel.org>
Subject: Re: [PATCH 7/7] x86: print out irq nr for msi/ht -v2
Date: Thu, 25 Sep 2008 10:20:21 -0700
Message-ID: <86802c440809251020h54d1e42ck67b542f17e928bd7@mail.gmail.com>
References: <1222323223-23529-1-git-send-email-yhlu.kernel@gmail.com>
	 <20080925084212.GE4519@elte.hu> <20080925091211.GA4922@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20080925091211.GA4922@elte.hu>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 25, 2008 at 2:12 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
>> > v2: fix hpet compiling
>
> still bad:
>
> arch/x86/kernel/hpet.c: In function 'hpet_late_init':
> arch/x86/kernel/hpet.c:828: error: 'dev' undeclared (first use in this function)
> arch/x86/kernel/hpet.c:828: error: (Each undeclared identifier is reported only once
> arch/x86/kernel/hpet.c:828: error: for each function it appears in.)
>
> we've got some changes in this area (per cpu hpet).
>

looks there is some merge problem.

Index: linux-2.6/arch/x86/kernel/hpet.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/hpet.c
+++ linux-2.6/arch/x86/kernel/hpet.c
@@ -467,6 +467,9 @@ static int hpet_setup_irq(struct hpet_de
        irq_set_affinity(dev->irq, cpumask_of_cpu(dev->cpu));
        enable_irq(dev->irq);

+       printk(KERN_DEBUG "hpet: %s is using irq %#x aka %d for MSI\n",
+                        dev->name, dev->irq, dev->irq);
+
        return 0;
 }

the change should be in hpet_setup_irq instead of hpet_late_init

the patch can be applied to tip/master cleanly.

YH
