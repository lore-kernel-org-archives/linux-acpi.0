From: Andi Kleen <ak@suse.de>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Tue, 2 May 2006 08:14:48 +0200
Message-ID: <200605020814.49144.ak@suse.de>
References: <CFF307C98FEABE47A452B27C06B85BB652DDDD@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:42964 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932390AbWEBGPE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 May 2006 02:15:04 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB652DDDD@hdsmsx411.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>, sergio@sergiomb.no-ip.org, Kimball Murray <kimball.murray@gmail.com>, linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com, linux-acpi@vger.kernel.org


> >- Modify do_IRQ to get passed an interrupt vector# from the
> >  interrupt vector instead of an irq number, and then lookup
> >  the irq number in vector_irq.  This means we don't need
> >  a code stub per irq, and allows us to handle more irqs
> >  by simply increasing NR_IRQS.
> 
> isn't the vector number already on the stack from
> ENTRY(interrupt)
> 	pushl $vector-256

Yes - and interrupts/vectors are currently always identical. If we go
to per CPU IDTs I suspect the stubs will just need to be generated
at runtime and start passing interrupts.

-Andi
