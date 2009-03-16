From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/9] sony-laptop for 2.6.30
Date: Mon, 16 Mar 2009 01:10:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903160106440.6195@localhost.localdomain>
References: <1235882445-2404-1-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:53767 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbZCPFLN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 01:11:13 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGL00C4N2DXVB71@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 16 Mar 2009 00:10:46 -0500 (CDT)
In-reply-to: <1235882445-2404-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

I snapped these up when i was traveling -- I think
I didn't get a chance to reply.

a couple of nits for next time...

Subject: [PATCH a/b] [sony-laptop] bla bla bla
should be:
Subject: [PATCH a/b] sony-laptop: bla bla bla

because everything between []'s get deleted by git-am

Also, some of the From: and Signed-off-by's were not quite right.
If you're not the original author, then the From: for the author
should be the first line in the body.  It doesn't again go down
by the Signed-off-by:.  Also, the orignal author should have
the 1st signed-off-by line, as they're generally intended to
show the path that the patch took to the kernel...

thanks,
Len Brown, Intel Open Source Technology Center
