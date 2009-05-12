From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86: introduce io_apic_irq_attr -v2
Date: Tue, 12 May 2009 12:32:36 +0200
Message-ID: <20090512103236.GC11714@elte.hu>
References: <4A01C35C.7060207@kernel.org> <4A01C406.2040303@kernel.org> <20090511082834.GD5636@elte.hu> <4A087F35.2000903@kernel.org> <20090511213755.GB21232@elte.hu> <4A08ACD3.2070401@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A08ACD3.2070401@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


* Yinghai Lu <yinghai@kernel.org> wrote:

> +				irq_attr->ioapic     = apic;
> +				irq_attr->ioapic_pin = mp_irqs[i].dstirq;
> +				irq_attr->trigger    = irq_trigger(i);
> +				irq_attr->polarity   = irq_polarity(i);

> +				irq_attr->ioapic     = apic;
> +				irq_attr->ioapic_pin = mp_irqs[i].dstirq;
> +				irq_attr->trigger    = irq_trigger(i);
> +				irq_attr->polarity   = irq_polarity(i);

Shouldnt this be factored out ino a helper function?

	Ingo
