From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: add standard linux WARN() output to ACPI warnings
Date: Tue, 24 Jun 2008 23:10:31 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806242310000.3014@localhost.localdomain>
References: <20080620095247.GA24557@elte.hu>
 <20080620135639.GA5073@damson.getinternet.no> <20080620142224.GF8135@elte.hu>
 <alpine.LFD.1.10.0806242231120.3014@localhost.localdomain>
 <20080624194915.11d6aee9@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:55085 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbYFYDKx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jun 2008 23:10:53 -0400
In-reply-to: <20080624194915.11d6aee9@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Vegard Nossum <vegard.nossum@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>, Yinghai Lu <yhlu.kernel@gmail.com>



> Please do not use warn_on_slowpath() directly!
> Please use WARN_ON() or WARN(). The later has printk semantics so this
> could turn into
> 
> WARN(1, "ACPI Error (%s-%0d): \n", module_name, line_number);

> 
> and kerneloops.org and various other tools will pick up the printk like
> arguments as part of the warning message.

cool, will do.

thanks,
-Len

