From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: PME via interrupt or SCI mechanism?
Date: Mon, 12 Sep 2011 10:10:03 -0700
Message-ID: <20110912171003.GA7939@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

As I mentioned at LPC, I have a USB host controller that is failing to
wakeup from D3 when a new USB device is connected to an external hub.
The system is in S0 at this point.

You mentioned that there were two ways for hardware to generate PMEs:
either through the standard PCI interrupt process, or via an ACPI SCI
call.

I think the hardware engineers want Linux to set up the PCI device to
generate PMEs via an SCI call, but I'm not sure if Linux is.  I've tried
turning on ACPI debugging (with level and layers both set to 0xffffffff
so I can see all debugging), and I don't see any output at all from ACPI
functions like acpi_ev_sci_xrupt_handler when the host controller comes
out of D3.  (It does come out of D3 if I plug in the device within 10
seconds of PCI suspend, for whatever reason.)

Is there a way to tell if SCI is being used by a PCI device to generate
PMEs?

You also mentioned that Linux has to choose whether to use standard
interrupts or an SCI to generate PMEs.  You said Linux asks the BIOS if
the hardware can use interrupts to generate PMEs, and it always uses
interrupt-based PME generation if the BIOS says yes.

Do you know where that code is?  I'd like to see how the BIOS responds
to that call, and perhaps get the BIOS guys to fix their response if the
hardware is supposed to only use SCIs to generate PMEs.

Sarah Sharp
