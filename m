From: Len Brown <lenb@kernel.org>
Subject: Re: Medion Akoya 1210: BIOS _OSI(Linux) query ignored
Date: Sat, 17 Jan 2009 20:22:45 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901172021570.20606@localhost.localdomain>
References: <1232232793.6996.3.camel@cereza>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:65118 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbZARBWw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Jan 2009 20:22:52 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KDN001417TXF324@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 17 Jan 2009 19:22:51 -0600 (CST)
In-reply-to: <1232232793.6996.3.camel@cereza>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frank Rehberger <Frank.Rehberger@web.de>
Cc: linux-acpi@vger.kernel.org

you can ignore these messages.
they are deleted from the latest kernel.

(unless "acpi_osi=Linux" actually makes some functional improvement
 on this system)

thanks,
--
Len Brown, Intel Open Source Technology Center

On Sat, 17 Jan 2009, Frank Rehberger wrote:

> Hi, 
> 
> the "Medion Akoya 1210" is a re-branded MSI-Wind U100, it seems the ACPI
> is not supported correctly. I get the following message
> in /var/log/messages.
> 
> 
> Jan 14 14:32:07 cereza kernel: [    0.791904] ACPI: BIOS _OSI(Linux)
> query ignored
> Jan 14 14:32:07 cereza kernel: [    0.791911] ACPI: DMI System Vendor:
> MEDION
> Jan 14 14:32:07 cereza kernel: [    0.791915] ACPI: DMI Product Name:
> E1210
> Jan 14 14:32:07 cereza kernel: [    0.791919] ACPI: DMI Product Version:
> Ver.001
> Jan 14 14:32:07 cereza kernel: [    0.791923] ACPI: DMI Board Name:
> E1210
> Jan 14 14:32:07 cereza kernel: [    0.791928] ACPI: DMI BIOS Vendor:
> American Me
> gatrends Inc.
> Jan 14 14:32:07 cereza kernel: [    0.791932] ACPI: DMI BIOS Date:
> 06/26/2008
> Jan 14 14:32:07 cereza kernel: [    0.791936] ACPI: Please send DMI info
> above to linux-acpi@vger.kernel.org
> Jan 14 14:32:07 cereza kernel: [    0.791942] ACPI: If "acpi_osi=Linux"
> works better, please notify linux-acpi@vger.kernel.org
> Jan 14 14:32:07 cereza kernel: [    0.797629] ACPI: Interpreter enabled
> Jan 14 14:32:07 cereza kernel: [    0.797635] ACPI: (supports S0 S1 S3
> S4 S5)
> Jan 14 14:32:07 cereza kernel: [    0.797676] ACPI: Using IOAPIC for
> interrupt routing
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
