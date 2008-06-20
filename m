From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 04/70] misc,acpi,backlight: compal Laptop Extras
Date: Fri, 20 Jun 2008 14:52:30 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806201449340.3027@localhost.localdomain>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
 <45fea4a84325d5724ffe480ae6f0d1658d520141.1213947349.git.len.brown@intel.com>
 <20080620114804.GA8637@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:42189 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbYFTSwp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 14:52:45 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R007AUYSD1Y73@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 13:45:50 -0500 (CDT)
In-reply-to: <20080620114804.GA8637@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>



> >  wlan - wlan subsystem state: contains 0 or 1 (rw)
> >  bluetooth - bluetooth subsystem state: contains 0 or 1 (rw)

> Could we please not add any more drivers with custom radio control 
> options? rfkill is a pretty small amount of code.

good catch Matthew,
I agree, we never want to add custom knobs to platform drivers when
we've (finally) succeeded in adding a generic API.

What do you suggest for the best example of rfkill implementation
that should be copied here?

Cezary,
I'm okay with just deleting these custom knobs to get this driver
moving along, if the generic hooks are not ready before
the merge window.

thanks,
-Len

