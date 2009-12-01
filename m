From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH] ACPI: support overriding an ACPI control method at
 runtime
Date: Mon, 30 Nov 2009 21:55:07 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911302153500.12472@localhost.localdomain>
References: <1259139678.10510.59.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:65012 "EHLO
	vms173001.mailsrvcs.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752274AbZLACzR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2009 21:55:17 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KTY0025GDFWODL3@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 30 Nov 2009 20:55:14 -0600 (CST)
In-reply-to: <1259139678.10510.59.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Thomas Renninger <trenn@suse.de>

sounds great!

I think the readme needs to be updated to make it clear that
any numer of methods can be overriden -- just that each individual
write to debugfs can implement a single method override.

Also, it would be good to make it clear how to un-do the change.
I believe that means the user needs to save the original AML
and override the override with the original.

thanks,
Len Brown, Intel Open Source Technology Center

