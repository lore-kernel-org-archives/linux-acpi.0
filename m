From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI error on HP dc7800p
Date: Wed, 26 Nov 2008 22:15:02 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811262213270.3895@localhost.localdomain>
References: <b7bb26000811261819h19bb2792o4b09b0eac62150f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:48816 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYK0DPF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Nov 2008 22:15:05 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KAZ0077P2D32EZ1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 26 Nov 2008 21:15:04 -0600 (CST)
In-reply-to: <b7bb26000811261819h19bb2792o4b09b0eac62150f3@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sihan Goi <goister@gmail.com>
Cc: linux-acpi@vger.kernel.org



On Thu, 27 Nov 2008, Sihan Goi wrote:

> Hi,
> 
> I have a self compiled Linux kernel v2.6.22.19 that has ACPI built
> into the kernel. I have tested the kernel in several systems and they
> all work. However, on a HP dc7800p, the kernel hangs at the ACPI stage
> with the following messages:
> 
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> *hangs here*
> 
> Once I disable ACPI with the kernel parameters acpi=off pci=noacpi,
> the kernel boots up ok.
> 
> This is a pretty new desktop with a Core2 Vpro CPU so I'm pretty sure
> it has ACPI support. What could be the problem here?

try booting with "pci=nommconf", or try a newer kernel.

-Len

