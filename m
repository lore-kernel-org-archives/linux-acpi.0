From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC][PATCH] ACPI: battery: add power_{now,
 avg} properties to power_class
Date: Tue, 16 Dec 2008 12:41:41 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812161237220.4414@localhost.localdomain>
References: <20081216162756.12100.49260.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:52339 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757585AbYLPRmD (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 16 Dec 2008 12:42:03 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KBZ00DZ8D5UATB0@vms044.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Tue, 16 Dec 2008 11:41:55 -0600 (CST)
In-reply-to: <20081216162756.12100.49260.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org


On Tue, 16 Dec 2008, Alexey Starikovskiy wrote:

> +What:	current_{now,avg} attributes for batteries, reporting in energy units
> +When:	2.6.29
> +Why:	Batteries, reporting in energy units, will report (dis)charge rate as
> +	power (Watts), and not as current (Amperes), thus new power_{now,avg}
> +	attributes should be used for such batteries to avoid the confusion.
> +Who:	Alexey Starikovskiy <astarikovskiy@suse.de>

I think that a single kernel release cycle is too quick
for a user/kernel API change  unless you're trying to fix
something that is new and you have a pretty good idea
that nobody is using it yet.  Kernel programmers typically
want to talk about O(6 months) and Linus comes back and
talks aboutg O(10 years)...

-- Len Brown, Intel Open Source Technology Center
