From: Len Brown <lenb@kernel.org>
Subject: Re: [Resend][PATCH] ACPI / ACPICA: Fix reference counting problems
 with GPE handlers
Date: Sat, 07 Aug 2010 10:32:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1008071030460.5575@localhost.localdomain>
References: <201008032355.14414.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:55397 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0HGOca (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Aug 2010 10:32:30 -0400
Received: from localhost.localdomain ([unknown] [74.104.157.58])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L6S00DN5DPO40A1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Aug 2010 09:32:27 -0500 (CDT)
In-reply-to: <201008032355.14414.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>

thanks for the update.

applied to acpi-test on top of the acpica branch.

thanks,
Len Brown, Intel Open Source Technology Center

