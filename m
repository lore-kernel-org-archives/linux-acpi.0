From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_battery_init() boot speed
Date: Wed, 15 Dec 2010 15:27:44 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012151517090.21167@x980>
References: <alpine.LFD.2.00.1012150308260.4878@x980>
 <20101215030054.0aae9e1e@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:62028 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966Ab0LOU1u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Dec 2010 15:27:50 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LDH0012YKUACFH1@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 15 Dec 2010 14:27:49 -0600 (CST)
In-reply-to: <20101215030054.0aae9e1e@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-acpi@vger.kernel.org


> wonder if this stuff is polling some battery property ?
> (like discharge rate or something)

Is there a simple way to get a profile that starts when
acpi_battery_init() is called and ends when it returns?

Note that acpi_battery_init() is not 900ms on all boxes --
I had to poke around to find a slow one.  My arrandale
laptop runs acpi_battery_init in 71 ms.

thanks,
-Len


