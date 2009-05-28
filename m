From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]: ACPI: Skip the power state check in power transition
Date: Wed, 27 May 2009 21:43:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905272143180.25587@localhost.localdomain>
References: <1242106060.3773.216.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:34930 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798AbZE1Bnt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2009 21:43:49 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKB00338ZGY4QN1@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 27 May 2009 20:43:49 -0500 (CDT)
In-reply-to: <1242106060.3773.216.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

I agree with Matthew and Bjorn.
This is the right thing to do, but we should take it a step further and
simplify the code.

thanks,
Len Brown, Intel Open Source Technology Center

