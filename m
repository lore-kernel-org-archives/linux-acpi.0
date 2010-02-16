From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 7/7] acpi: remove old blacklist entries
Date: Tue, 16 Feb 2010 03:19:43 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002160317570.21595@localhost.localdomain>
References: <201002022238.o12Mbx54018702@imap1.linux-foundation.org>
 <alpine.LFD.2.00.1002160253470.21595@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:62878 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab0BPITx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2010 03:19:53 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KXX008YWDSZS014@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 16 Feb 2010 02:19:52 -0600 (CST)
In-reply-to: <alpine.LFD.2.00.1002160253470.21595@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, arekm@maven.pl, feng.tang@intel.com, flinco@libero.it, mad_soft@inbox.ru, mjg@redhat.com, rjw@sisk.pl

> applied to acpi-test

un-applied.

Even if deleting the blacklist entries were correct,
which it more or less may be, the bug at hand is that
"acpi=ht" is now broken -- whether invoked via DMI
or cmdline; and this patch doesn't fix that.

Len Brown, Intel Open Source Technology Center

