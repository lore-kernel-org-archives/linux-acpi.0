From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch] PNPACPI: ignore the producer/consumer bit for extended IRQ descriptors
Date: Mon, 25 Aug 2008 12:15:43 +0200
Message-ID: <20080825101543.GC26610@one.firstfloor.org>
References: <200808220947.18253.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:50752 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047AbYHYKNZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Aug 2008 06:13:25 -0400
Content-Disposition: inline
In-Reply-To: <200808220947.18253.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andi Kleen <andi@firstfloor.org>, Adam M Belay <abelay@mit.edu>, Matthieu CASTET <matthieu.castet@parrot.com>, Li Shaohua <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Fri, Aug 22, 2008 at 09:47:17AM -0600, Bjorn Helgaas wrote:
> The Extended Interrupt descriptor has a producer/consumer bit, but
> it's not clear what that would mean, and existing BIOSes use the bit
> inconsistently.  This patch makes Linux PNPACPI ignore the bit.

Added thanks. Will put in the next 2.6.27 update.

-Andi
