From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2] ACPI: SBS: Move SBS HC callback to faster Notify queue
Date: Thu, 31 Dec 2009 03:25:13 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912310325070.17125@localhost.localdomain>
References: <20091230125303.11962.12105.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:45621 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbZLaIZ3 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 31 Dec 2009 03:25:29 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KVI00CXVCQ3I0J2@vms173019.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Thu, 31 Dec 2009 02:25:16 -0600 (CST)
In-reply-to: <20091230125303.11962.12105.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

ERROR: trailing whitespace
#27: FILE: drivers/acpi/ec.c:538:
+^I^I^Ireturn acpi_os_execute((copy->func) ? $

total: 1 errors, 0 warnings, 17 lines checked

