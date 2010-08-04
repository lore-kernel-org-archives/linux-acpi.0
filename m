From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [Devel] acpi_os_read_memory() from interrupt context
Date: Wed, 4 Aug 2010 15:26:15 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858AC59CF57@orsmsx503.amr.corp.intel.com>
References: <201008041119.23633.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:33011 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213Ab0HDW03 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Aug 2010 18:26:29 -0400
In-Reply-To: <201008041119.23633.bjorn.helgaas@hp.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

If you need to pre-map the ACPI registers, I would expect the host to build a list of these during initialization as you mention, then lookup and use the appropriate mapping in acpi_os_read_memory.  The acpi_os memory interfaces are not generic memory interfaces; they are only used for memory-mapped ACPI registers, so it is entirely appropriate to do whatever you need to do to obtain a mapping for the registers when at interrupt level.



>-----Original Message-----
>From: devel-bounces@acpica.org [mailto:devel-bounces@acpica.org] On Behalf
>Of Bjorn Helgaas
>Sent: Wednesday, August 04, 2010 10:19 AM
>To: linux-acpi@vger.kernel.org; devel@acpica.org
>Subject: [Devel] acpi_os_read_memory() from interrupt context
>
>Linux reads some ACPI registers from interrupt context.  For example,
>we read the PM1 Status register in the SCI interrupt handler via
>this path:
>
>    acpi_irq
>      acpi_ev_sci_xrupt_handler
>        acpi_ev_fixed_event_detect
>          acpi_hw_register_read
>            acpi_hw_read_multiple
>              acpi_read
>
>But acpi_read() takes a generic address structure, and if that
>address happens to be in memory space (not I/O port space), we use
>acpi_os_read_memory().  In Linux, that uses ioremap() to map the
>address, and that doesn't work from interrupt context.
>
>I can imagine fixing this by doing the ioremap() at boot-time
>rather than at interrupt-time, but most of this interrupt path
>is in the ACPI CA, not in Linux itself, so it would probably
>require some redesign in the CA.
>
>Any suggestions?
>
>Bjorn
>_______________________________________________
>Devel mailing list
>Devel@acpica.org
>http://lists.acpica.org/listinfo/devel
