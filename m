From: Len Brown <lenb@kernel.org>
Subject: Re: [Resend][PATCH] ACPI / EC: Remove race between EC driver and
 suspend process (rev. 3)
Date: Wed, 03 Mar 2010 16:49:01 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1003031644410.1044@localhost.localdomain>
References: <201002272140.36891.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:43900 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756723Ab0CCVta (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2010 16:49:30 -0500
In-reply-to: <201002272140.36891.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

For the record, Rafael, Alexey and I discusseed this a bit further...

We reasoned that this failure is impossible during the Suspend-to-RAM 
path, and the failure is specific to the hibernate reboot kernel handoff
to the resume image.

On a related note, we had trouble justifying the existence
of the current EC .suspend and .resume routines.

thanks,
Len Brown, Intel Open Source Technology Center

