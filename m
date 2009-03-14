From: Len Brown <lenb@kernel.org>
Subject: Re: patch for video.c driver
Date: Sat, 14 Mar 2009 03:55:06 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903140314200.23716@localhost.localdomain>
References: <20090312154741.GA1055@hygelac>
 <1236910092.2807.103.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:43464 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbZCNHzS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Mar 2009 03:55:18 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGH00M1QKNXQTP6@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 14 Mar 2009 02:55:11 -0500 (CDT)
In-reply-to: <1236910092.2807.103.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Terence,

First, I'm delighted to hear from nvidia -- thanks
for reaching out to the Linux community.

a couple of observations...

drivers/acpi/*.c in general, and video.c in particular,
are meant to implement what is documented in the ACPI specification.

Linux has moved the vendor specific drivers (that may use ACPI,
or use vendor-specific ACPI extensions)
to drivers/platform/x86/*.c

That is where I'd generally expect an nvidia-specific ACPI extension to 
live.

Is there any public documentationon how NVIF is supposed to operate?

I have a new snappy Sony laptop that has both nvidia and intel graphics,
and it has an NVIF.  I'm certain that Linux has no idea how to
switch between "Stamina" and "Speed" modes...

But I also have a Lenovo T61 with only Intel graphics,
and it still has an NVIF.  (presumably Lenovo ships one
BIOS for both their Intel and Nvidia based T61's...)
What happens with NVIF in this case?

thanks,
-Len

