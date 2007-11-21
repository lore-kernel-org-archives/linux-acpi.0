From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.24-rc3-mm1 - Kernel Panic on IO-APIC
Date: Wed, 21 Nov 2007 14:22:32 -0500
Message-ID: <200711211422.32908.lenb@kernel.org>
References: <20071120204525.ff27ac98.akpm@linux-foundation.org> <4743CC0B.9000508@linux.vnet.ibm.com> <20071120221839.faab108e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49400 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbXKUTYX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Nov 2007 14:24:23 -0500
In-Reply-To: <20071120221839.faab108e.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Balbir Singh <balbir@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>

On Wednesday 21 November 2007 01:18, Andrew Morton wrote:
> On Wed, 21 Nov 2007 11:41:23 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> > SMP alternatives: switching to UP code
> > ACPI: Core revision 20070126
> > ..MP-BIOS bug: 8254 timer not connected to IO-APIC

did previous kernels print this too?

> > Kernel panic - not syncing: IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter
> 
> ACPI or x86 breakage, I guess.

If you suspect ACPI breakage, then try "acpi=off" or "acpi=noirq".

thanks,
-Len
