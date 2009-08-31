From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Clarify resource conflict message
Date: Mon, 31 Aug 2009 13:19:38 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908311305110.19451@localhost.localdomain>
References: <200908301546.22827.jdelvare@suse.de>
 <9b2b86520908301410i31b69f71s27809788d3b1f103@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:23374 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbZHaRT6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Aug 2009 13:19:58 -0400
Received: from localhost.localdomain ([74.104.157.165])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KP9004Q444SWBX0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 31 Aug 2009 12:19:41 -0500 (CDT)
In-reply-to: <9b2b86520908301410i31b69f71s27809788d3b1f103@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Thomas Renninger <trenn@suse.de>

> > The message "ACPI: Device needs an ACPI driver" is misleading...

> > ACPI: Device may still be supported by an ACPI driver

> I would drop the word "still", but otherwise I think this is a good idea.

I agree we need to clarify this message.

Right now we have (copied from a recent bug report):

w83627ehf: Found W83627EHG chip at 0x290
ACPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI region SEN1
[0x295-0x296]
ACPI: Device needs an ACPI driver

This results in people filing bugs against ACPI because their sensor
driver does not load -- we've seen several already.

I'm okay with the 1st ACPI line -- it tells somebody who cares exactly
what is going on.

"Device needs an ACPI driver", however, fails to tell the administrator
what they can do about it.  We should probably mention that they
can test "acpi_enforce_resources=lax".  However, we should probably
put a big WARNING - using-at-own-risk note in the dmesg when
that option is actually used.

And then what is the next course of action -- possible inclusion
on a white-list if they conflict turns out to be benign,
or (less likely) possible development of a missing ACPI driver?

We could have quite a few bug reports filed on this,
so wording is important.

thanks,
-Len Brown, Intel Open Source Technology Center
