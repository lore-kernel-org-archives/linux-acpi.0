From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [RFC 1/1] ACPI: pci_irq, add PRT_ quirk for IBM Bartolo
Date: Fri, 13 May 2011 09:18:47 +0200
Message-ID: <4DCCDB57.70706@suse.cz>
References: <4C87A62E.30108@gmail.com> <1302598086-3622-1-git-send-email-jslaby@suse.cz> <20110412085622.43488ed9@jbarnes-desktop> <20110412155921.GA531@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110412155921.GA531@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Jiri Slaby <jirislaby@gmail.com>, Robert Hancock <hancockrwd@gmail.com>, lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 04/12/2011 05:59 PM, Matthew Garrett wrote:
> On Tue, Apr 12, 2011 at 08:56:22AM -0700, Jesse Barnes wrote:
>> I'll defer to the ACPI experts, Len or Matthew have you checked this
>> one out?
> 
> Windows appears to work without this, so it seems likely that we're 
> doing something wrong in some other sense, but I don't think we have a 
> good idea as to what we're doing wrong...

I changed the irq assignment like (to take the lowest
available/non-conflicting IRQ):
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -557,7 +557,7 @@ static int acpi_pci_link_allocate(struct
          * the use of IRQs 9, 10, 11, and >15.
          */
         for (i = (link->irq.possible_count - 1); i >= 0; i--) {
-            if (acpi_irq_penalty[irq] >
+            if (acpi_irq_penalty[irq] >=
                 acpi_irq_penalty[link->irq.possible[i]])
                 irq = link->irq.possible[i];
         }


And with this change it works _without_ acpi=noirq.

Does it help somehow?

dmesg then shows a difference like:
 serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
-ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
-PCI: setting IRQ 11 as level-triggered
-serial 0000:00:09.0: PCI INT A -> Link[LNKB] -> GSI 11 (level, low) ->
IRQ 11
-0000:00:09.0: ttyS4 at I/O 0x1898 (irq = 11) is a 16550A
-0000:00:09.0: ttyS5 at I/O 0x1890 (irq = 11) is a 16550A
+ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
+PCI: setting IRQ 10 as level-triggered
+serial 0000:00:09.0: PCI INT A -> Link[LNKB] -> GSI 10 (level, low) ->
IRQ 10
+0000:00:09.0: ttyS4 at I/O 0x1898 (irq = 10) is a 16550A
+0000:00:09.0: ttyS5 at I/O 0x1890 (irq = 10) is a 16550A
 ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
+PCI: setting IRQ 11 as level-triggered
 serial 0000:00:0b.0: PCI INT A -> Link[LNKA] -> GSI 11 (level, low) ->
IRQ 11
 0000:00:0b.0: ttyS6 at I/O 0x18c0 (irq = 11) is a 16550A
 0000:00:0b.0: ttyS7 at I/O 0x18b8 (irq = 11) is a 16550A

thanks,
-- 
js
suse labs
