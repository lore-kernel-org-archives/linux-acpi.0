From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 12/15] PNPACPI: ignore _PRS interrupt numbers larger than
 PNP_IRQ_NR
Date: Mon, 02 Jun 2008 01:23:32 +0200
Message-ID: <48432F74.1010507@keyaccess.nl>
References: <20080530224853.976744229@ldl.fc.hp.com> <20080530224933.755433659@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:35751 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbYFAXUT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Jun 2008 19:20:19 -0400
In-Reply-To: <20080530224933.755433659@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

On 31-05-08 00:49, Bjorn Helgaas wrote:

> ACPI Extended Interrupt Descriptors can encode 32-bit interrupt
> numbers, so an interrupt number may exceed the size of the bitmap
> we use to track possible IRQ settings.
> 
> To avoid corrupting memory, complain and ignore too-large interrupt
> numbers.
> 
> There's similar code in pnpacpi_parse_irq_option(), but I didn't
> change that because the small IRQ descriptor can only encode
> IRQs 0-15, which do not exceed bitmap size.
> 
> In the future, we could handle IRQ numbers greater than PNP_IRQ_NR
> by replacing the bitmap with a table or list.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Rene Herman <rene.herman@gmail.com>

Rene.
