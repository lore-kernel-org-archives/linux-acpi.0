From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPICA: Do not hang at mutex forever if BIOS tries to
 release global lock
Date: Fri, 15 Oct 2010 22:25:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010152222150.2971@localhost.localdomain>
References: <201010081240.15203.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:33162 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab0JPCZa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Oct 2010 22:25:30 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAD00IFB2QGPV80@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 15 Oct 2010 21:25:29 -0500 (CDT)
In-reply-to: <201010081240.15203.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Moore, Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, stuart_hayes@dell.com

> There seem to be chipsets which can get this wrong (especially after a kexec
> boot on Linux).

<recording>

As kexec is fundamentally unreliable by design,
why should reliable software be modified for its beneift?

</recording>

-Len Brown, Intel Open Source Technology Center

