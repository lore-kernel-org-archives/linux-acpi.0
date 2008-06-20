From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 04/70] misc,acpi,backlight: compal Laptop Extras
Date: Fri, 20 Jun 2008 14:48:19 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806201447150.3027@localhost.localdomain>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
 <45fea4a84325d5724ffe480ae6f0d1658d520141.1213947349.git.len.brown@intel.com>
 <1213956830.5049.10.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:36254 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbYFTSsZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 14:48:25 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R002T2YWNEUE1@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 13:48:24 -0500 (CDT)
In-reply-to: <1213956830.5049.10.camel@dax.rpnet.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-acpi@vger.kernel.org, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>



> There was an update to this patch which dropped the lcd_level attribute
> which might as well be applied before merging since the backlight class
> handles all of that and there is no point in duplicating it.

oh good, i had forgotton about that - i've got it now.

Subject: [PATCH -mm 1/1] misc,acpi,backlight: Compal Laptop Extras - 
remove unnecessary attribute

thanks,
-Len
 
