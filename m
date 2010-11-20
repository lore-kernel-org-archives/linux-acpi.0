From: Len Brown <lenb@kernel.org>
Subject: Re: linux acpi info
Date: Fri, 19 Nov 2010 21:30:35 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1011192130040.9745@x980>
References: <4CD93339.5000806@tjse.jus.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:53533 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564Ab0KTCbE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Nov 2010 21:31:04 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LC5006SAWB24AR5@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Nov 2010 20:30:51 -0600 (CST)
In-reply-to: <4CD93339.5000806@tjse.jus.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wilhelm de Araujo Rodrigues <willy@tjse.jus.br>
Cc: linux-acpi@vger.kernel.org

It is a bug in vmware.

cheers,
Len Brown, Intel Open Source Technology Center

On Tue, 9 Nov 2010, Wilhelm de Araujo Rodrigues wrote:

> log messages in reverse order
> 
> 
> 
> Nov  9 07:44:45 vpl-expre-cte0000 kernel: [    0.577697] ACPI: PCI Root Bridge
> [PCI0] (0000:00)
> Nov  9 07:44:45 vpl-expre-cte0000 kernel: [    0.472498] ACPI: Using IOAPIC
> for interrupt routing
> Nov  9 07:44:45 vpl-expre-cte0000 kernel: [    0.472125] ACPI: (supports S0 S1
> S4 S5)
> Nov  9 07:44:45 vpl-expre-cte0000 kernel: [    0.471925] ACPI: Interpreter
> enabled
> Nov  9 07:44:45 vpl-expre-cte0000 kernel: [    0.470125] ACPI: If
> "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org
> Nov  9 07:44:45 vpl-expre-cte0000 kernel: [    0.469877] ACPI: Please send DMI
> info above to linux-acpi@vger.kernel.org
> Nov  9 07:44:45 vpl-expre-cte0000 kernel: [    0.469672] ACPI: DMI BIOS Date:
> 09/22/2009
> Nov  9 07:44:45 vpl-expre-cte0000 kernel: [    0.469445] ACPI: DMI BIOS
> Vendor: Phoenix Technologies LTD
> Nov  9 07:44:45 vpl-expre-cte0000 kernel: [    0.468764] ACPI: DMI Board Name:
> 440BX Desktop Reference Platform
> Nov  9 07:44:45 vpl-expre-cte0000 kernel: [    0.468524] ACPI: DMI Product
> Version: None
> Nov  9 07:44:45 vpl-expre-cte0000 kernel: [    0.468295] ACPI: DMI Product
> Name: VMware Virtual Platform
> Nov  9 07:44:45 vpl-expre-cte0000 kernel: [    0.468081] ACPI: DMI System
> Vendor: VMware, Inc.
> Nov  9 07:44:45 vpl-expre-cte0000 kernel: [    0.467835] ACPI: BIOS
> _OSI(Linux) query ignored
> 

