From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: acpi_atomic_read() requirements
Date: Thu, 2 Sep 2010 19:34:52 -0600
Message-ID: <201009021934.52861.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:37141 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab0ICBfV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Sep 2010 21:35:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org

Hello,

You recently added acpi_atomic_read() and acpi_atomic_write().
These are similar to acpi_read() and acpi_write(), but differ
mainly in two ways:

  - The atomic ones can be used in interrupt context, because the
    ioremap() (which may block) can be done earlier by acpi_pre_map_gar()

  - The atomic ones do 64-bit accesses directly with readq() rather
    than splitting them into two 32-bit accesses as acpi_read() does.

It's obvious to me that you need the first property (usable in
interrupt context).  Do you also rely on the second property
(doing a single 64-bit access rather than two 32-bit accesses)?

I'm curious because there's another path that performs memory
accesses from interrupt context, using acpi_read() and
acpi_os_read_memory().  The ACPI IRQ handler reads the PM1
Status register to learn the interrupt source.  If this is
memory mapped (not in I/O port space), we currently panic
because ioremap() can't be called in interrupt context:

  http://marc.info/?l=linux-acpi&m=128094238920118&w=2

I wrote a patch that fixes this by premapping these areas so the
ioremap() happens at boot-time rather than interrupt-time.  This
works fine, but it ends up looking very much like the atomic
functions you added.  I'd like to integrate them somehow rather
than adding more code that does basically the same thing as your
code.

If your APEI code that uses acpi_atomic_read()/write() doesn't
require the single 64-bit access, it might be possible to keep
the premapping support, i.e., acpi_pre_map_gar(), change
acpi_os_read_memory() to check the acpi_iomaps list first and
only do the ioremap() if it doesn't find anything, remove
acpi_atomic_read(), and just use acpi_read() instead.

Bjorn
