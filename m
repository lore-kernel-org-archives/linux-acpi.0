From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] x86: find nr_irqs_gsi with mp_ioapic_routing
Date: Fri, 06 Feb 2009 22:35:24 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902062221050.26256@localhost.localdomain>
References: <498CCEDB.8050708@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:26342 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbZBGDfh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Feb 2009 22:35:37 -0500
In-reply-to: <498CCEDB.8050708@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org




> Impact: find right nr_irqs_gsi on some systems.
> 
> one system has gap between gsi.
> [    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 4, version 0, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: IOAPIC (id[0x05] address[0xfeafd000] gsi_base[48])
> [    0.000000] IOAPIC[1]: apic_id 5, version 0, address 0xfeafd000, GSI 48-54
> [    0.000000] ACPI: IOAPIC (id[0x06] address[0xfeafc000] gsi_base[56])
> [    0.000000] IOAPIC[2]: apic_id 6, version 0, address 0xfeafc000, GSI 56-62
> ...
> [    0.000000] nr_irqs_gsi: 38

I've never seen gaps in GSIs.
I've never seen IOAPICs with 7 redirection table entries.

This system looks quite broken even before the probe for nr_irqs_gsi.
Do you have more information on it?

thanks,
-Len
--
Intel Open Source Technology Center
