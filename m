From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 12:34:02 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30063F8D72@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:46776 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932266AbWCBRe1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Mar 2006 12:34:27 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Dave Jones <davej@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


>I have a dual core + HT platform. I disabled HT to have the 
>same situation as Dave.
>
>ACPI DSDT dump shows 4 objects in \_PR scope as below.
>
>    Scope (\_PR)
>    {
>        Processor (CPU0, 0x01, 0x00000410, 0x06) {}
>        Processor (CPU1, 0x02, 0x00000410, 0x06) {}
>        Processor (CPU2, 0x03, 0x00000410, 0x06) {}
>        Processor (CPU3, 0x04, 0x00000410, 0x06) {}
>    }
>
>Only 2 are marked enabled in the ACPI MADT..
>
>From boot log
>
>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
>Processor #0 15:4 APIC version 20
>ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
>Processor #2 15:4 APIC version 20
>ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
>ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
>
>But proc/acpi/processor also lists just 2 entries.

We were certainly on safer ground when we used
to completely ignore disabled entries.

-Len
