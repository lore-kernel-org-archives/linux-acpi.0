From: Len Brown <lenb@kernel.org>
Subject: Re: XEON E5420 and Namespace lookup failure
Date: Tue, 03 Feb 2009 14:57:04 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902031446130.5607@localhost.localdomain>
References: <20081108222454.GA29284@frix.fri.uniza.sk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:29624 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbZBCUDS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2009 15:03:18 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-2.01 (built Jun 13 2007; 32bit))
 with ESMTPA id <0KEI007RXA37LNH6@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 03 Feb 2009 13:57:08 -0600 (CST)
In-reply-to: <20081108222454.GA29284@frix.fri.uniza.sk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Strazovec <bubak@frix.fri.uniza.sk>
Cc: linux-acpi@vger.kernel.org, peters@rosina.sk

> Hello, I have problem with Namespace lookup failure on E5420. Thus acpi not
> functional (cpufrequ via p-states, etc...).
> 
> Does anyone know about some patch or some hint?

from the dmesg:

Linux version 2.6.27-gentoo-r2_cargo
...
ACPI: SSDT CFE5F800, 00D8 (r1 HP      CPU0CST        1 INTL 20061109)
Parsing all Control Methods:
Table [SSDT](id 00C6) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Error (psargs-0358): [CS03] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0530): Method parse/execution failed [\_PR_.CPU0._CST] 
(Node ffff88012f860a10), AE_NOT_FOUND
processor ACPI0007:00: registered as cooling_device0
ACPI: SSDT CFE5F900, 00D8 (r1 HP      CPU1CST        1 INTL 20061109)
Parsing all Control Methods:
Table [SSDT](id 00CB) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Error (psargs-0358): [CS03] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0530): Method parse/execution failed [\_PR_.CPU1._CST] 
(Node ffff88012f860a30), AE_NOT_FOUND
processor ACPI0007:01: registered as cooling_device1
ACPI: SSDT CFE5FA00, 00D8 (r1 HP      CPU2CST        1 INTL 20061109)
Parsing all Control Methods:
Table [SSDT](id 00D0) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Error (psargs-0358): [CS03] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0530): Method parse/execution failed [\_PR_.CPU2._CST] 
(Node ffff88012f860ad0), AE_NOT_FOUND
processor ACPI0007:02: registered as cooling_device2
ACPI: SSDT CFE5FB00, 00D8 (r1 HP      CPU3CST        1 INTL 20061109)
Parsing all Control Methods:
Table [SSDT](id 00D5) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Error (psargs-0358): [CS03] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0530): Method parse/execution failed [\_PR_.CPU3._CST] 
(Node ffff88012f8609f0), AE_NOT_FOUND

Most of ACPI is actually functioning properly on this machine,
having configured your interrupts etc.

It looks like this box is trying to present some C-states
via _CST, and that is failing.  I don't see any messages
related to P-states -- is acpi_cpufreq included in your .config?

Please start by confirming that 2.6.28 still has this issue.
If it does, then please open a bug report here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the dmesg (uncompressed is fine)
along with the output from
acpidump > acpidump.out
acpidump -a 0xCFE5F800 -l 0x00D8 > ssdt.out

thanks,
--
Len Brown, Intel Open Source Technology Center

