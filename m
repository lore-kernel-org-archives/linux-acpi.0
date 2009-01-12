From: Jon Masters <jcm@redhat.com>
Subject: Re: PCI, ACPI, IRQ, IOAPIC: reroute PCI interrupt to legacy boot
	interrupt equivalent
Date: Mon, 12 Jan 2009 14:25:49 -0500
Message-ID: <1231788349.4094.21.camel@perihelion.bos.jonmasters.org>
References: <alpine.LFD.2.00.0901091743310.20020@localhost.localdomain>
	 <496B24E5.1070804@suse.de>  <200901121151.53195.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:42772 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbZALT0S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Jan 2009 14:26:18 -0500
In-Reply-To: <200901121151.53195.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Stefan Assmann <sassmann@suse.de>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Olaf Dabrunz <od@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Sven Dietrich <sdietrich@novell.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "Maciej W. Rozycki" <macro@linux-mips.org>

On Mon, 2009-01-12 at 11:51 -0700, Bjorn Helgaas wrote:
> (I added Eric, Maciej, and Jon because they participated in
> previous discussion here: http://lkml.org/lkml/2008/6/2/269)

Thanks. You know what I'd really like even more than being on the CC?
I'd *love* someone to post a link to documentation on how this actually
is supposed to work. We had to guess last time because none of the
public documentation actually explains this. The guys at SuSE likely
received some docs, but I'm not sure where from or the title thereof.

If we all knew how this was supposed to work then we might have a much
better likelihood of fixing this behavior. It's only going to get worse
over time - we want to get threaded IRQs upstream (I'm about to be
poking at that again over here) and that'll mean mainline has to learn
to deal with these boot interrupts just as much as RT does today.

Jon.


