From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/3] ACPI processor: Fix section mismatch for
 processor_add()
Date: Wed, 16 Dec 2009 13:15:15 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912161314230.6089@localhost.localdomain>
References: <1256575458-19269-1-git-send-email-trenn@suse.de>
 <1256575458-19269-4-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:16393 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759451AbZLPSPW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 13:15:22 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUR004AAC1H89J0@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 12:15:18 -0600 (CST)
In-reply-to: <1256575458-19269-4-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>

applied the acpi_processor_add_fs() hunk,
as we already had the acpi_processor_add hunk

thanks,
Len Brown, Intel Open Source Technology Center

