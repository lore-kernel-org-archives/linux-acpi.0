From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]  ACPI:  Ignore AE_NOT_FOUND error of EC _REG method and
 continue to initialize EC
Date: Fri, 17 Oct 2008 02:05:36 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810170203360.3026@localhost.localdomain>
References: <1219886944.4116.64.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172073pub.verizon.net ([206.46.172.73]:55765 "EHLO
	vms172073pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbYJQGFj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Oct 2008 02:05:39 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172073.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8V00BFRCXEKW55@vms172073.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 17 Oct 2008 01:05:39 -0500 (CDT)
In-reply-to: <1219886944.4116.64.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: AndiKleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, joshuacov@googlemail.com, Alexey Starikovskiy <astarikovskiy@suse.de>

I'm inclined to include this b/c it fixes the problems at hand
and we don't have a better solution at the moment.

When we have a more general solution, we can always revert this.

thanks,
-Len

