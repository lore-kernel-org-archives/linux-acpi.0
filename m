From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI acpi_processor_get_throttling_info taking excessive time?
Date: Tue, 27 Apr 2010 03:05:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004270301340.3999@localhost.localdomain>
References: <4BD4F0A5.7050208@sgi.com>
 <1272248522.25088.67.camel@rzhang1-desktop> <4BD5D81B.4020600@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:55162 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab0D0HFU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Apr 2010 03:05:20 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L1I00HHTX0SOUJ7@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 27 Apr 2010 02:05:19 -0500 (CDT)
In-reply-to: <4BD5D81B.4020600@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Jack Steiner <steiner@sgi.com>, Hedi Berriche <hedi@sgi.com>, Robin Holt <holt@sgi.com>

> ...I've added a new BZ:
> 
> 	https://bugzilla.kernel.org/show_bug.cgi?id=15856
> 
> and attached the console output I collected from:
> 
> ignore_loglevel acpi.debug_layer=0x2800001f acpi.debug_level=0x00000027
> 
> This took almost an hour to boot so adding all flags would not be
> practical.

I don't see any attachments to that bug report.

CONFIG_ACPI_DEBUG=y with
acpi.debug_layer=0x20000000 maxcpus=4 should do it.

Also, the output from acpidump.

thanks,
-Len Brown, Intel Open Source Technology Center

