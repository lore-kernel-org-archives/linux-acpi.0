From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI / PM: Blacklist another machine that needs
 acpi_sleep=nonvs
Date: Mon, 25 Oct 2010 20:14:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010252013270.18670@localhost.localdomain>
References: <201010172101.21576.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:65001 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab0JZAOz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 20:14:55 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAV00BOPFCNOF35@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 19:14:53 -0500 (CDT)
In-reply-to: <201010172101.21576.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Emanuele Bigiarini <pulmro@gmail.com>

Rather than a black list of machines that can not survive saving NVS,
I wonder how long a white list of machines requiring NVS save would be?

applied.

thanks,
Len Brown, Intel Open Source Technology Center

