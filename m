From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: replace acpi_integer by u64
Date: Thu, 28 Jan 2010 01:49:32 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001280148530.8886@localhost.localdomain>
References: <1264647199.25564.18.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:35924 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab0A1Gtf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jan 2010 01:49:35 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWY00KIV2YMPV46@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 28 Jan 2010 00:49:34 -0600 (CST)
In-reply-to: <1264647199.25564.18.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

do we want to delete it from actypes.h in this patch too?


applied to acpi-test.

thanks,
Len Brown, Intel Open Source Technology Center

