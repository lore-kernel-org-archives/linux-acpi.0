From: Len Brown <lenb@kernel.org>
Subject: Re: rc8 didn't include patch (was Re: 2.6.28-rc7 acpi error messages)
Date: Fri, 12 Dec 2008 01:39:52 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812120137440.27968@localhost.localdomain>
References: <E92FAF79A8BBC642A36EEE3AA7F152D82A17319337@GVW1089EXB.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:33170 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbYLLGjz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Dec 2008 01:39:55 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KBR00J6C3UIGSO1@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 12 Dec 2008 00:39:54 -0600 (CST)
In-reply-to: <E92FAF79A8BBC642A36EEE3AA7F152D82A17319337@GVW1089EXB.americas.hpqcorp.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Koornstra, Reinoud" <koornstra@hp.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> RC8 didn't include from Matthew Garret.
> Will the next version contain this patch?

nope.

That patch was based on a guess about what Windows does.
R8 isn't a time to patch Linux behaviour on all machines
based on speculation about what Windows does.

The "regression" is that we print an an error message
that we didn't used to print.  If we have to do anything
in rc8, we'd delete that warning message for now.

thanks,
Len Brown, Intel Open Source Technology Center

