From: Len Brown <lenb@kernel.org>
Subject: Re: state of some x86 acpi patches
Date: Fri, 02 Jan 2009 17:28:17 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901021727340.3590@localhost.localdomain>
References: <4947FF4C.80706@goop.org> <20081216192534.GB843@elte.hu>
 <alpine.LFD.2.00.0812311821110.3854@localhost.localdomain>
 <495C677F.6080707@goop.org> <20090102153957.GA1180@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:59065 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbZABW2W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jan 2009 17:28:22 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KCV00KTX7R89BW3@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 02 Jan 2009 16:28:21 -0600 (CST)
In-reply-to: <20090102153957.GA1180@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Yinghai Lu <yinghai@kernel.org>, linux-acpi@vger.kernel.org

> yes, that end result is the desired state of things. We did run with this 
> for several months and resolved all the cases that needed fixing, but 
> dropped them when the ACPI tree moved out from under us.
> 
> Can resurrect it if Len feels OK about the concept. Len, you shouldnt 
> worry about conflicts - we can do it after the ACPI changes of this merge 
> window are upstream so there should be no conflict trouble at all. How 
> does that sound?

Sounds great!

thanks,
Len Brown, Intel Open Source Technology Center
