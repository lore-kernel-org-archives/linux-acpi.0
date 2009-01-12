From: Ingo Molnar <mingo@elte.hu>
Subject: Re: PCI, ACPI, IRQ, IOAPIC: reroute PCI interrupt to legacy boot
	interrupt equivalent
Date: Mon, 12 Jan 2009 12:37:20 +0100
Message-ID: <20090112113720.GB21051@elte.hu>
References: <alpine.LFD.2.00.0901091743310.20020@localhost.localdomain> <496B24E5.1070804@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:59647 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643AbZALLhh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Jan 2009 06:37:37 -0500
Content-Disposition: inline
In-Reply-To: <496B24E5.1070804@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Assmann <sassmann@suse.de>
Cc: Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Olaf Dabrunz <od@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Sven Dietrich <sdietrich@novell.com>


* Stefan Assmann <sassmann@suse.de> wrote:

> Why can these IRQ lines be brought down by Boot Interrupts? Because 
> there's no handler installed on the primary IO-APIC IRQ line that can 
> take care of them and after too many unhandled IRQs the line will be 
> shut down by the kernel.

The failure mode can be quite nasty: ranging from non-working USB (and 
other) devices to hard lockups due to screaming IRQs.

	Ingo
