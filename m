From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI OSI disaster on latest HP laptops - critical temperature
 shutdown
Date: Thu, 24 Jul 2008 20:04:32 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807241952270.6098@localhost.localdomain>
References: <200807241727.41715.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:42422 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbYGYAFN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jul 2008 20:05:13 -0400
In-reply-to: <200807241727.41715.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Christian Kornacker <ckornacker@suse.de>

Thomas,

re: OSI(Windows...)

Linux will continue to claim OSI compatibility with Windows
until the day when the majority of Linux systems
have passed a Linux compatibility test rather than
a Windows compatibility test.

Re: OSI(Linux)

I've looked at O(100) DSDT's that look at OSI(Linux),
and all but serveral systems from two vendors do it by mistake.
They simply copied it from the bugged Intel reference code.

OSI(Linux) will _never_ be restored to Linux, ever.

re: the HP BIOS bug at hand.

Linux deletes the entire thermal zone when we see this.
(arguably, we could have just disabled the CRT
and kept the rest of the thermal zone).
If HP cared about testing Linux on this laptop
and had tools such that they could actually
test Linux compatiblity, it would be pretty clear
from user-space that their thermal zone was missing.

thanks,
-Len



