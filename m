From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_os_allocate(GFP_KERNEL) (was Re: acpi_evaluate_integer broken
 by design)
Date: Thu, 18 Dec 2008 01:07:08 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812180104500.17738@localhost.localdomain>
References: <20081125110508.GA1943@elf.ucw.cz>
 <20081215214140.9031d4c8.akpm@linux-foundation.org>
 <200812161634.25838.rjw@sisk.pl> <200812170040.07977.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:59949 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbYLRGHN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Dec 2008 01:07:13 -0500
In-reply-to: <200812170040.07977.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, pavel@suse.cz, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>



-- Len Brown, Intel Open Source Technology Center

> In fact, we should be using GFP_ATOMIC already while devices are being
> suspended, so we can switch from GFP_KERNEL to GFP_ATOMIC even before
> interrupts are enabled.

true.  it makes me wonder if tinkering with ACPI
is a bad idea -- for it will address only one user of kmalloc.
