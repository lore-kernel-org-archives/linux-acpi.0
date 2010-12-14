From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3_v14] IPMI/ACPI: Install the ACPI IPMI opregion
Date: Tue, 14 Dec 2010 00:21:33 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012140020390.23573@x980>
References: <1291774218-6834-1-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:48788 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab0LNFVh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Dec 2010 00:21:37 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LDE006QGK817QT3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 13 Dec 2010 23:21:37 -0600 (CST)
In-reply-to: <1291774218-6834-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: minyard@acm.org, openipmi-developer@lists.sourceforge.net, linux-acpi@vger.kernel.org

Corey,
Most of the code is in drivers/acpi, but that depends on the ipmi part.
Shall I take all three patches in the acpi-test tree?

thanks,
Len Brown, Intel Open Source Technology Center
