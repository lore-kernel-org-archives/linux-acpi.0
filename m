From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP
 systems
Date: Tue, 8 Jul 2008 17:25:26 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0807081646270.27931@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl>
 <20080708112402.GA2301@alberich.amd.com> <200807081727.40605.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200807081727.40605.rjw@sisk.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andreas Herrmann <andreas.herrmann3@amd.com>, Ingo Molnar <mingo@elte.hu>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 8 Jul 2008, Rafael J. Wysocki wrote:

> > (B) The current approach to setup timer as ExtINT.
[...]
> > (B) ??? who tested this, Rafael
> 
> Yes, I tested this.

 There is some confusion here apparently -- you certainly have not tested
the timer as an ExtINTA interrupt during the course of this discussion,
because the "8259A Virtual Wire" through the local APIC has always worked
for you.  ExtINTA would be the next, fourth and final attempt before a
panic().

 For a reference, here is the list of configurations of the 8254 timer
interrupt in the order they are tried:

1. Native I/O APIC interrupt.

2. "8259A Virtual Wire" through the I/O APIC.

3. "8259A Virtual Wire" through the local APIC of the bootstrap processor.

4. ExtINTA ("Virtual Wire") through the local APIC of the BSP.

The configurations #1 and #2 are only tried if the firmware has supplied
information about how the IRQ0 or 8259A have been wired.  The #4 is only
reached in very rare cases where there is some special glue logic between
the 8259A and the APIC (seen before as a workaround for broken hardware;  
unlock_ExtINT_logic() is needed for that) or a given implementation of the
8259A is not a full one (hypothetical).

  Maciej
