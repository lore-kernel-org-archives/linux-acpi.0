From: Len Brown <len.brown@intel.com>
Subject: Re: How ACPI is actually implemented?
Date: Mon, 27 Nov 2006 00:55:39 -0500
Message-ID: <200611270055.40011.len.brown@intel.com>
References: <29545330611260935l507b7853g8ec3bb1597a3c884@mail.gmail.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33711 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1757041AbWK0Fwl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Nov 2006 00:52:41 -0500
In-Reply-To: <29545330611260935l507b7853g8ec3bb1597a3c884@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Benton <benton71@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sunday 26 November 2006 12:35, Eric Benton wrote:
> Hi,
> 
> I'm trying to figure out how ACPI is implemented, I don't know if this
> list is the right one to ask but I'm sure there are kind people in
> this place that will help me in my quest :)
> I tried to look for resources but I couldn't find too many. I'm
> interested to know how ACPI works in the hardware level... so, after a
> lot of reading I left with these questions, any knowledge provided is
> greatly appreciated.
> 
> By looking at /proc/irq and /proc/ioports I can see that ACPI is
> allocated with IRQ9 and I/O ports 0x400-0x42F.
> 1. How does exactly a hardware device generates an event?

Depends on the hardware device.
ACPI interrupts come in through the SCI -- System Control Interrupt,
aka the ACPI interrupt, as seen in /proc/interrupts.  But many events
can cause an SCI.  In particular, there is another level of interrupt
fan-out below the SCI called  a General Purpose Event (GPE) which
can have many sources.

> 2. How does the OS asks a device to change it's state? what *exactly* happens?

Not sure I understand the question.  Are you asking how an interrupt
is processed?  It comes in like a PCI interrupt, and depending on the
cause it is serviced differently.

eg. the SCI handler might run a GPE handler, which will run the _Lxx
method in AML, which might send a Notify() to an AML device object.
The OS might have registered a driver on that object which
will receive the event and do some action, such as sending an event
to user-space.  see button.c for an even simpler example.
 
> I read that the BIOS supplies all the ACPI tables.
> 3. Are they are being built in compile time (this is what I understand
> from the FAQ at Intel's website)?

the ACPI tables are built by the OEM and with an ASL->AML compiler
and are burned into the BIOS.

> 4. What happens If a new PCI device is being added to the system, how
> the DSDT is being updated? (If at all...)

The DSDT is static -- it is never updated.  However, it can be augmented by loading
an SSDT, or the AML can use the Load() operator to add additional code
at run-time.
 
> I saw a note about an ACPI Controller.
> 5. What exactly is the role of this controller? How it operates? And who
> 6. In general, I'm looking to find out what is the role (in respect to
> "talking with the hardware") of these entities: the driver, the
> device, the OS (including the CA)? Who reads/writes to the I/O ports.
> Who sets the IRQ? the controller? or is it the device itself? What
> happens exactly?

The platform dictates which IRQ is used for ACPI.  The OS generally
doesn't get to choose this.
IO ports can be read and written by the BIOS, by the BIOS AML
which is run on the BIOS' behalf by the OS AML interpreter,
or by the OS.
 
> I tried reading the ACPI spec, but it's 600+ pages that doesn't answer
> these questions...

read it a  couple of times, actually it does:-)
There is also a book called "Building the Power Efficient PC" from Intel Press
which might help you.

It would help if you could ask the most specific question possible,
as it is difficult to answer extremely open-ended questions
without writing a book.

-Len
