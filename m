From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/3] ACPI: thinkpad-acpi: fix LED handling on older
 ThinkPads
Date: Wed, 04 Jun 2008 00:57:02 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806040056060.14187@localhost.localdomain>
References: <1212546971-29736-1-git-send-email-hmh@hmh.eng.br>
 <1212546971-29736-4-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:39818 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbYFDE5G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jun 2008 00:57:06 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K1X00GOF9G6YEUJ@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 03 Jun 2008 23:50:31 -0500 (CDT)
In-reply-to: <1212546971-29736-4-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

oh i see -- i had a conflict b/c i applied this to a branch
which didn't have the recent upstream const patch.

applied.

thanks,
-len


