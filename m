From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: io-apic breaks suspend unless acpi_skip_timer_override
Date: Sun, 10 Sep 2006 22:20:45 +0100
Message-ID: <20060910212045.GA9278@srcf.ucam.org>
References: <20060910141533.GA6594@srcf.ucam.org> <20060910205803.GA1966@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:2233 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751028AbWIJVUt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Sep 2006 17:20:49 -0400
Content-Disposition: inline
In-Reply-To: <20060910205803.GA1966@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, Sep 10, 2006 at 10:58:03PM +0200, Pavel Machek wrote:

> Do you mean suspend-to-RAM? Can you try beeping patch?

Yes, suspend to RAM. I'll look at trying to work out where it blows up, 
though I suspect it's successfully getting back into C code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
