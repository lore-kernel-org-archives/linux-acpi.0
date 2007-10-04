From: Len Brown <lenb@kernel.org>
Subject: Re: dmesg
Date: Thu, 4 Oct 2007 13:44:12 -0400
Message-ID: <200710041344.12233.lenb@kernel.org>
References: <47044790.1010306@stud.unibas.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33657 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756405AbXJDRoa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Oct 2007 13:44:30 -0400
In-Reply-To: <47044790.1010306@stud.unibas.ch>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Sicher <Michael.Sicher@stud.unibas.ch>
Cc: linux-acpi@vger.kernel.org, yakui.zhao@intel.com

On Wednesday 03 October 2007 21:53, Michael Sicher wrote:
> Hello
> This is the content after a dmesg. (Attachment) Somewhere I were pleased 
> to send you this...I hope you will help me eliminate those errors...

Do you refer to these?

ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x05] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)


ACPI Exception (processor_core-0783): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0783): AE_NOT_FOUND, Processor Device is not present [20070126]

This is from Linux being too verbose about not finding processor #2 and #3,
which I agree we should fix, per bugzilla:

http://bugzilla.kernel.org/show_bug.cgi?id=8630
and I think Yakui will be putting a patch in that bug report soon.

If something isn't working, please point that out.

thanks,
-Len
