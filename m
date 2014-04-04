From: Guenter Roeck <linux@roeck-us.net>
Subject: Adding interrupt support to gpio-ich driver (possibly via SCI)
Date: Fri, 04 Apr 2014 09:25:50 -0700
Message-ID: <533EDD0E.8010304@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Peter Tyser <ptyser@xes-inc.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi all,

I have an application where I would need interrupt support for the gpio-ich driver.
More specifically, in my application some of the GPIO pins are used to report
interrupt status from a couple of connected chips. This is with a Panther Point
PCH (QM77).

I see that the gpio pins in question (in the 0..15 range) do support interrupts,
but it looks like the only configuration options are to generate SMI, SCI, or NMI.

Is there a clean way to use any of those to implement interrupt support
for this driver ? I thought about hijacking the SCI interrupt by registering
an interrupt handler with acpi_install_sci_handler(), but that would restrict
the driver to kernel only (or the acpi function would have to be exported),
and I have no idea if it would work or, more importantly, if it would be
the best approach to solve the problem, or if the result would be acceptable.
I can figure out the "working" part, but that would not help much if I would
have to carry the patch locally because it is not acceptable for upstream
integration.

Side note: gpio-ich is not currently enabled for Panther Point; that will be
a one-line separate patch for the mfd/lpc_ich driver.

Thanks,
Guenter
