From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] acpi: clear PCIEXP_WAKE_STS on resume
Date: Tue, 28 Sep 2010 15:42:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009281540550.14962@localhost.localdomain>
References: <1285671624-7826-1-git-send-email-colin.king@canonical.com>
 <1285671624-7826-2-git-send-email-colin.king@canonical.com>
 <20100928083121.f76e8991.rdunlap@xenotime.net> <1285688763.2072.6.camel@lenovo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:45500 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486Ab0I1Tma (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 15:42:30 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H00AO32QGDL32@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 14:42:23 -0500 (CDT)
In-reply-to: <1285688763.2072.6.camel@lenovo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-acpi@vger.kernel.org

> .... Attached corrected patch.

Good find!

applied to acpi-test,
and I forwarded it to the ACPICA folks b/c it is a patch to ACPICA code.

thanks,
Len Brown, Intel Open Source Technology Center

