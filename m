From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: eliminate unused variable warning for !ACPI_SLEEP
Date: Sat, 11 Dec 2010 01:00:19 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012110058320.28169@x980>
References: <4CFE583902000078000266E9@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:39094 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab0LKGAW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 01:00:22 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD9006MX20LAAN7@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 00:00:22 -0600 (CST)
In-reply-to: <4CFE583902000078000266E9@vpn.id2.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-acpi@vger.kernel.org

applied,
though i'd rather see a pach that makes unreasonable/unlikely
config combinations such as ACPI && !ACPI_SLEEP impossible.

thanks,
Len Brown, Intel Open Source Technology Center
