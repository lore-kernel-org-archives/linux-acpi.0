From: Len Brown <lenb@kernel.org>
Subject: RE: [PATCH] ACPI: resume: re-enable SCI-enable workaround
Date: Sat, 16 May 2009 01:49:30 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905160137210.4571@localhost.localdomain>
References: <20090507105821.GA5864@hash.localnet>
 <d3f22a0905122245h15786220g31ad0dcb8caa3a38@mail.gmail.com>
 <1242192968.14626.40.camel@minggr.sh.intel.com>
 <200905131015.45635.rjw@sisk.pl>
 <b6c5339f0905130830k3549095dv3eee08d7d3155a37@mail.gmail.com>
 <alpine.LFD.2.00.0905152233180.4571@localhost.localdomain>
 <4911F71203A09E4D9981D27F9D8308582DB914DF@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:59240 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbZEPFtr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 01:49:47 -0400
In-reply-to: <4911F71203A09E4D9981D27F9D8308582DB914DF@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Bob Copeland <me@bobcopeland.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Lin, Ming M" <ming.m.lin@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "Zhao, Yakui" <yakui.zhao@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


> >The BIOS bug workaround mistakenly got disabled
> >when we followed the ACPI specification more closely
> >by ignoring OS updates to that bit.
> 
> Not exactly. ACPICA has always preserved the SCI_EN bit. Linux apparently has a "linux-only" patch to ACPICA that disables this.
> 
> The recent version of ACPICA change the #define enough such that the patch no longer works.

"We" here means Linux, and thus the description is accurate.

The fact is that in 2.6.29 Linux had
ACPI_PM1_CONTROL_PRESERVED_BITS 0x0200
and when "we" updated it to 0x201 via the ACPICA update,
the workaround in the Linux resume code became a NOP.

-Len
