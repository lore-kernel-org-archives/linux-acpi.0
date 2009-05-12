From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] x86: introduce io_apic_irq_attr -v2
Date: Tue, 12 May 2009 08:17:07 -0700
Message-ID: <86802c440905120817j5d102aa2i43e7d8f8f8ba10b2@mail.gmail.com>
References: <4A01C35C.7060207@kernel.org> <4A01C406.2040303@kernel.org>
	 <20090511082834.GD5636@elte.hu> <4A087F35.2000903@kernel.org>
	 <20090511213755.GB21232@elte.hu> <4A08ACD3.2070401@kernel.org>
	 <20090512103236.GC11714@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090512103236.GC11714@elte.hu>
Sender: linux-pci-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 12, 2009 at 3:32 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Yinghai Lu <yinghai@kernel.org> wrote:
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_attr->=
ioapic =A0 =A0 =3D apic;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_attr->=
ioapic_pin =3D mp_irqs[i].dstirq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_attr->=
trigger =A0 =A0=3D irq_trigger(i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_attr->=
polarity =A0 =3D irq_polarity(i);
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_attr->=
ioapic =A0 =A0 =3D apic;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_attr->=
ioapic_pin =3D mp_irqs[i].dstirq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_attr->=
trigger =A0 =A0=3D irq_trigger(i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_attr->=
polarity =A0 =3D irq_polarity(i);
>
> Shouldnt this be factored out ino a helper function?
>
set_io_apic_irq_attr()?

YH
