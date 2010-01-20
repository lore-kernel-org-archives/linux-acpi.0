From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: processor: restrict early _PDC to opt-in platforms
Date: Tue, 19 Jan 2010 23:47:19 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001192344240.4265@localhost.localdomain>
References: <20100119235541.GL11010@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:35544 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab0ATErV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2010 23:47:21 -0500
In-reply-to: <20100119235541.GL11010@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

thanks for the focused patch, Alex.

If we expect to run into this issue more, perhaps
we should add a modparam to help handle debugging
and 2.6.33 DMI list maintenance.  The param and
the DMI list can both go away when we think we have
the real fix in 2.6.34.

applied.

thanks,
Len Brown, Intel Open Source Technology Center

