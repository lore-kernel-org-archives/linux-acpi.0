From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] - Add IOAPIC NMI support on x86_64
Date: 19 Jun 2007 02:44:43 +0200
Message-ID: <p73vedkrcw4.fsf@bingen.suse.de>
References: <20070618215700.8097.77403.79754@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:51905 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762556AbXFRXsk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Jun 2007 19:48:40 -0400
In-Reply-To: <20070618215700.8097.77403.79754@attica.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Keller <jpk@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, steiner@sgi.com

John Keller <jpk@sgi.com> writes:

> Add support for IOAPIC NMI interrupts on x86_64.
> 
> Changes include the following:
> 
>   - Obtain the NMI IOAPIC info via an ACPI NMI SRC structure that is
>     part of the MADT, and program the IOAPIC redirection register.
>     The NMI SRC struct will contain the GSI of the NMI interrupt.
> 
>   - Setup irq_desc[] and irq_2_pin[] entries for the NMI interrupt irq,
>     which will be used by the generic mask/unmask routines. This will
>     allow a driver to enable/disable the NMI interrupt via
>     enable/disable_irq().

What's the motivation for this patch? 

-Andi
