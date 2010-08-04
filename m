From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: acpi_os_read_memory() from interrupt context
Date: Wed, 4 Aug 2010 11:19:23 -0600
Message-ID: <201008041119.23633.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0186.atlanta.hp.com ([15.193.32.63]:2734 "EHLO
	g6t0186.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab0HDRTs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Aug 2010 13:19:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devel@acpica.org

Linux reads some ACPI registers from interrupt context.  For example,
we read the PM1 Status register in the SCI interrupt handler via
this path:

    acpi_irq
      acpi_ev_sci_xrupt_handler
        acpi_ev_fixed_event_detect
          acpi_hw_register_read
            acpi_hw_read_multiple
              acpi_read

But acpi_read() takes a generic address structure, and if that
address happens to be in memory space (not I/O port space), we use
acpi_os_read_memory().  In Linux, that uses ioremap() to map the
address, and that doesn't work from interrupt context.

I can imagine fixing this by doing the ioremap() at boot-time
rather than at interrupt-time, but most of this interrupt path
is in the ACPI CA, not in Linux itself, so it would probably
require some redesign in the CA.

Any suggestions?

Bjorn
