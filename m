From: Len Brown <lenb@kernel.org>
Subject: Re: Linux doesn't shutdown (turn off) the computer
Date: Wed, 19 May 2010 23:46:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005192340540.2921@localhost.localdomain>
References: <phlm97-dol.ln1@tux.abusar.org.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:37993 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab0ETDrL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2010 23:47:11 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P00DUV95YCHS8@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 19 May 2010 22:46:51 -0500 (CDT)
In-reply-to: <phlm97-dol.ln1@tux.abusar.org.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-15?Q?D=E2niel_Fraga?= <fragabr@gmail.com>
Cc: linux-acpi@vger.kernel.org

if you boot with "debug" on the command line, you should get
KERN_DEBUG messages on your console.

shut down with
# poweroff

and the last thing you see printed should be:
acpi_power_off called since that is where pm_power_off() goes.

If that doesn't work, send your .config

thanks,
Len Brown, Intel Open Source Technology Center

