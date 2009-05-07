From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 7/7] x86/pci: update pirq_enable_irq to setup io apic
	routing -v2
Date: Thu, 7 May 2009 16:12:22 +0200
Message-ID: <20090507141222.GI481@elte.hu>
References: <4A01C35C.7060207@kernel.org> <4A01C46E.8000501@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:57393 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbZEGONf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 May 2009 10:13:35 -0400
Content-Disposition: inline
In-Reply-To: <4A01C46E.8000501@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>


* Yinghai Lu <yinghai@kernel.org> wrote:

> 
> so we could set io apic routing only when enable device irq.
> 
> also could make setup_IO_APIC_irqs and setup_ioapic_dest only handle
> first ioapic...
> 
> v2: remove one one not needed style change.
>     merge the patch only setup io_apic for acpi on in setup_IO_APIC_irqs
> 
> [ Impact: make mptable irq enable more like acpi is used, and numa_irq_desc could get correct node when acpi=off ]
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  arch/x86/kernel/apic/io_apic.c |  148 ++++++++++++++++++++---------------------
>  arch/x86/pci/irq.c             |   84 ++++++++---------------
>  2 files changed, 103 insertions(+), 129 deletions(-)

Jesse, did this patch have your Acked-by?

	Ingo
