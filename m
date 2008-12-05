From: Robin Elfrink <elfrink@introweb.nl>
Subject: DMI info
Date: Fri, 05 Dec 2008 09:29:58 +0100
Message-ID: <4938E686.6090503@introweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay.introweb.nl ([80.65.96.45]:65246 "EHLO relay.introweb.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbYLEIy7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Dec 2008 03:54:59 -0500
Received: from relay.introweb.nl (unknown [192.168.4.41])
	by fallback.mailcluster.introweb.intern (Postfix #82) with ESMTP id 7F67445B137
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2008 09:31:32 +0100 (CET)
Received: from smtp.introweb.nl (unknown [192.168.4.33])
	by forward.introweb.nl (Postfix #41) with ESMTP id D5FBBDB1A
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2008 09:29:58 +0100 (CET)
Received: from [192.168.0.26] (mail.introweb.net [80.65.97.195])
	(Authenticated sender: robin)
	by mail.introweb.nl (Postfix) with ESMTP id E94E533C24
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2008 09:32:06 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,


As requested in kernel output:

[    0.636451] ACPI: EC: Look up EC in DSDT
[    0.640204] ACPI: BIOS _OSI(Linux) query ignored
[    0.640206] ACPI: DMI System Vendor: Dell Inc.
[    0.640208] ACPI: DMI Product Name: PowerEdge R300
[    0.640209] ACPI: DMI Product Version:
[    0.640211] ACPI: DMI Board Name: 0TY179
[    0.640212] ACPI: DMI BIOS Vendor: Dell Inc.
[    0.640213] ACPI: DMI BIOS Date: 08/15/2008
[    0.640215] ACPI: Please send DMI info above to
linux-acpi@vger.kernel.org
[    0.640217] ACPI: If "acpi_osi=Linux" works better, please notify
linux-acpi@vger.kernel.org
[    0.640454] ACPI: Interpreter enabled
[    0.640462] ACPI: (supports S0 S4 S5)
[    0.640471] ACPI: Using IOAPIC for interrupt routing
[    0.644648] ACPI: PCI Root Bridge [PCI0] (0000:00)


No need to use 'acpi_osi=Linux'.

This is Ubuntu 8.10 live, running from an USB stick, on a brand new Dell
PowerEdge R300. FreeBSD page faults on the raid controller, Linux just
runs :)


Robin
