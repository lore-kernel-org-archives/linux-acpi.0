From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: EC: Accelerate query execution
Date: Thu, 24 Dec 2009 15:00:53 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912241500040.4159@localhost.localdomain>
References: <20091224083416.4896.63269.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:57739 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbZLXUBR (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 15:01:17 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GYXA9J1W48@vms173001.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 14:01:00 -0600 (CST)
In-reply-to: <20091224083416.4896.63269.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

applied to acpi-test, except for this hunk:

-/* #define DEBUG */
+#define DEBUG

thanks,
Len Brown, Intel Open Source Technology Center

