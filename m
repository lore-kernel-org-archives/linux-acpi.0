From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: processor: only call _PDC on physically present
 processors
Date: Tue, 19 Jan 2010 23:42:29 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001192340140.4265@localhost.localdomain>
References: <20100114201214.GH4545@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:33612 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab0ATEmh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2010 23:42:37 -0500
In-reply-to: <20100114201214.GH4545@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: shemminger@linux-foundation.org, ming.m.lin@intel.com, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

A couple reasons to not get excited about this solution.

I don't like the processor enumeration code moving to a file called 
processor_pdc.c.

Too big for rc4 -- a logical revert to evaluate PDC when
we did in 2.6.32 would be more attractive at this point.


thanks,
Len Brown, Intel Open Source Technology Center

