From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Most interrupts are edge-triggered, non-APIC system
Date: Tue, 6 Jun 2006 00:38:30 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6A6BA2D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:11808 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932097AbWFFEik convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2006 00:38:40 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, joliveirinha@gmail.com, Stephen Hemminger <shemminger@osdl.org>

Bjorn speaks the truth.

>>   ACPI: setting ELCR to 0200 (from 0c20)

BTW. you can verify the final setting of the ELCR from user space
like so:

# inb 0x4d0
0x00
# inb 0x4d1
0x0E

In this example, it means the ELCR is 0x0E00,
so IRQs 11, 10, 9  are level triggered and the rest are edge.

cheers,
-Len 
