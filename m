From: Mike Houston <mikeserv@bmts.com>
Subject: Re: ACPI power off regression in 2.6.23-rc8 (NOT in rc7)
Date: Tue, 25 Sep 2007 21:39:31 -0400
Message-ID: <20070925213931.7c0c43bc.mikeserv@bmts.com>
References: <20070925065109.GA3080@localhost.localdomain>
	<20070925092755.GA4553@localhost.localdomain>
	<20070925095855.GA4982@localhost.localdomain>
	<200709251345.11370.rjw@sisk.pl>
	<20070925120202.GA5641@localhost.localdomain>
	<20070925150500.GA2632@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tomts4.bellnexxia.net ([209.226.175.10]:46298 "EHLO
	tomts4-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbXIZBqK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Sep 2007 21:46:10 -0400
In-Reply-To: <20070925150500.GA2632@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Damien Wyart <damien.wyart@free.fr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Torsten Kaiser <just.for.lkml@googlemail.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Frans Pop <elendil@planet.nl>, linux-acpi@vger.kernel.org

On Tue, 25 Sep 2007 17:05:00 +0200
Damien Wyart <damien.wyart@free.fr> wrote:

> > Will test this evening the patch you pointed in your next message.
> 
> Ok, with both patches (including the very latest one from Alexey ---
> tried the "stylistically correct" one), machine halts fine again.
> Thanks to all for having looked at this!

Same here, applying the two patches in this thread fixed the problem
for me, on my Intel 965P based system. It now does the acpi power off
correctly once again, and I have noticed no other problems with
2.6.23-rc8.

"move acpi_sleep_prepare outside of CONFIG_SUSPEND" and the last
"ACPI: suspend: fix ACPI_SLEEP states"

Thanks Alexey and Rafael.

Mike Houston
