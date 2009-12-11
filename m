From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: support customizing ACPI control methods at runtime
Date: Fri, 11 Dec 2009 01:51:10 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912110150310.6502@localhost.localdomain>
References: <1259731860.2029.1221.camel@rzhang1-desktop>
 <200912021134.58846.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:51139 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756939AbZLKGvI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2009 01:51:08 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUH006L271C1OGO@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 11 Dec 2009 00:51:12 -0600 (CST)
In-reply-to: <200912021134.58846.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


On Wed, 2 Dec 2009, Thomas Renninger wrote:

> On Wednesday 02 December 2009 06:31:00 Zhang Rui wrote:
> > 
> > Introduce a new debugfs I/F (/sys/kernel/debug/acpi/custom_method) for ACPI,
> > which can be used to customize the ACPI control methods at runtime.
> Still no kernel tainting on a successful override?
> On purpose or unintended?

unintended.

Rui, please send a follow-on patch to taint,
just like when we override the DSDT.

thanks,
-Len Brown, Intel Open Source Technology Center

