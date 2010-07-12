From: Len Brown <lenb@kernel.org>
Subject: Re: [Resend][PATCH 0/4] ACPI: Avoid executing _PRW twice for all
 devices
Date: Mon, 12 Jul 2010 14:37:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1007121434040.25332@localhost.localdomain>
References: <201007080041.38627.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:44963 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab0GLSiQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jul 2010 14:38:16 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L5G00LARJRADS74@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 12 Jul 2010 13:38:05 -0500 (CDT)
In-reply-to: <201007080041.38627.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Lin Ming <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>


> [3/4] - Simplifies code in acpi_ev_initialize_gpe_block(), which only is a
>         cosmetic thing, but worth doing IMO.

FYI, this one had a white-space issue on the line with the "enabled:" 
label -- the patch was missing some tabs and spaces that were in the tree;
but that was the only problem with it.

> Please apply.

done.

thanks,
-Len Brown, Intel Open Source Technology Center

