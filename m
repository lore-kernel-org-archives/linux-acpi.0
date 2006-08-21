From: Andi Kleen <ak@suse.de>
Subject: Freeing ACPI tables after parsing
Date: Mon, 21 Aug 2006 11:46:53 +0200
Message-ID: <200608211146.53379.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:21704 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751812AbWHUJq5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Aug 2006 05:46:57 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, len.brown@intel.com
Cc: Natalie.Protasevich@unisys.com

[repost, this time with correct cc list]

AFAIK ACPI saves all information found in ACPI tables in memory
somewhere else (please correct me if I'm wrong on that)

I also found this comment in e820.h:

#define E820_ACPI       3 /* usable as RAM once ACPI tables have been read */

Currently I don't see any code that would free the ACPI tables after they
are read. During SLES10 testing we had some problems with the ACPI
tables on some Unisys systems being in a area where the kexec kernel
wanted to be loaded too. Also on other systems the ACPI tables are not
exactly at the end but in the middle of the memory map and for some applications
it might be better to have a lot of physical continuous memory.

So are there any plans to free the BIOS supplied ACPI tables after parsing
or is there some obstacle to that that I'm missing?

Thanks,
-Andi
 
