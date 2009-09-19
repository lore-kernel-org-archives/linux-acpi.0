From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 6/8] hwmon driver for ACPI 4.0 power meters
Date: Sat, 19 Sep 2009 01:32:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909190130440.22030@localhost.localdomain>
References: <200909181941.n8IJf91g002548@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:51387 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbZISFco (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Sep 2009 01:32:44 -0400
Received: from localhost.localdomain ([74.104.157.165])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KQ70082TE2NV763@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 19 Sep 2009 00:32:48 -0500 (CDT)
In-reply-to: <200909181941.n8IJf91g002548@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, djwong@us.ibm.com, pavel@ucw.cz, rui.zhang@intel.com

applied.

Even though there is no way right now to test if we got this right,
I'm told that we'll see support for this feature in platforms soon,
so in the spirit of "release early and often", I think this
driver should go upstream now.

thanks,
Len Brown, Intel Open Source Technology Center

