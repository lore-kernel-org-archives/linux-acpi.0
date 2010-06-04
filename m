From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2] suspend: Move NVS save/restore code to generic suspend
 functionality
Date: Fri, 04 Jun 2010 15:11:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006041508190.4073@localhost.localdomain>
References: <1275078735-1866-1-git-send-email-mjg@redhat.com>
 <1275230238.14907.8.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:56984 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab0FDTLc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 15:11:32 -0400
In-reply-to: <1275230238.14907.8.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>


> Since the other patch 'ACPI / EC / PM: Fix race between EC transactions
> and system suspend' is now merged, this should be rebased on top of it
> (I did the opposite....)

Maxim,
Since your system needs both these fixes, and they are merged together
in the acpi git tree, it would be great if you could test that tree
and let me know if we got it right.

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test

thanks,
Len Brown, Intel Open Source Technology Center

