From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Fri, 20 Jun 2008 13:27:14 +0100
Message-ID: <20080620122714.GA9332@srcf.ucam.org>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806201353.59083.rjw@sisk.pl> <20080620115714.GC8637@srcf.ucam.org> <200806201422.12659.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58690 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbYFTM1Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 08:27:24 -0400
Content-Disposition: inline
In-Reply-To: <200806201422.12659.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Fri, Jun 20, 2008 at 02:22:11PM +0200, Rafael J. Wysocki wrote:

> Ah, indeed, thanks for the hint.  This is the output of

Right. My recollection of this is somewhat hazy, so here's something I 
wrote a couple of years ago:

"If you dig through the DSDT code for the 6125, you'll find a bit where 
it writes 0x14 to 0xfec00000 and then checks whether offset 0x12 from 
there is 1. In other words, it's checking if pin 2 of the io-apic is 
masked. If it's not masked (that is, offset 0x12 is 0 and irq 2 is 
enabled) it sets another bit in a register. This is then checked by the 
thermal zone code which as a result sets the thermal trip temperatures 
to 16 degrees Celsius. This bites when the acpi_skip_timer_override 
option is used in Linux."

I have no idea what this code is for, but it's pretty clear that Windows 
sets it up in such a way that this isn't true.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
