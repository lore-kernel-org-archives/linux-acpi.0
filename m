From: Len Brown <lenb@kernel.org>
Subject: Re: [patch] ACPI: make debug command-line arguments work again
Date: Thu, 18 Dec 2008 23:51:13 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812182349370.6312@localhost.localdomain>
References: <200811131630.14781.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:56883 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbYLSEvd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Dec 2008 23:51:33 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KC30072MXHLOHY0@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 18 Dec 2008 22:51:27 -0600 (CST)
In-reply-to: <200811131630.14781.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Randy Dunlap <rdunlap@xenotime.net>


> This should go in 2.6.28; otherwise there'll be no way to turn on
> ACPI debugging.

i just ran into this...
had thought we shipped this patch already -- time to do it now, i guess...

I like Bjorn's default better, and I like Thomas' syntax better,
so I'll combine them.

thanks,
-- Len Brown, Intel Open Source Technology Center

