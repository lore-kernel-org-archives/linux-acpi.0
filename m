From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: platform for testing ACPI CPU hotplug?
Date: Mon, 30 Mar 2009 13:44:04 -0600
Message-ID: <200903301344.04851.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:19837 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755660AbZC3Tpq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2009 15:45:46 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@linux.intel.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi guys,

I don't think I have any platforms where I can exercise the ACPI
processor hotplug code, e.g., acpi_processor_hotplug_notify().
Can you point me to any?

I'm looking at drivers/acpi/processor_core.c with a view to removing
its use of the .start() method.  As far as I can tell, most of what's
currently in acpi_processor_start() could be folded into acpi_processor_add().

If you know of any big reasons why this couldn't be done, I'd like
to hear them, but mostly I'm just looking for a way to test any
changes I make in this area.

Thanks,
  Bjorn
