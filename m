From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/3] ACPI: battery: add power_{now,
 avg} properties to power_class
Date: Tue, 17 Mar 2009 02:24:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903170220320.4473@localhost.localdomain>
References: <20090113235739.10548.20626.stgit@thinkpad>
 <alpine.LFD.2.00.0901161408450.5705@localhost.localdomain>
 <4970E0B6.5070306@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:47642 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762828AbZCQGYz (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 17 Mar 2009 02:24:55 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGN00KZ20G6C6V4@vms173007.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Tue, 17 Mar 2009 01:24:07 -0500 (CDT)
In-reply-to: <4970E0B6.5070306@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

On Fri, 16 Jan 2009, Alexey Starikovskiy wrote:

> 2.6.30?
> or 2.6.31?

Although we've had this patch in the test tree for a bit,
I don't think that any amount of aging in -next will help us here.

Is it possible to put the add the new attribute immediately,
get buy-in from the user-space guys,
and then remove the old attribute in a subsequent patch?

thanks,
Len Brown, Intel Open Source Technology Center
