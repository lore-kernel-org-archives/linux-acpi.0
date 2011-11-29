From: Huang Ying <ying.huang@intel.com>
Subject: RE: [PATCH 2/2] ACPICA: support Generic Address Structure
 bit_offset in acpi_read/write
Date: Tue, 29 Nov 2011 10:15:03 +0800
Message-ID: <1322532903.4849.24.camel@yhuang-dev>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
	 <201111172127.40664.rjw@sisk.pl> <1321578279.13860.108.camel@yhuang-dev>
	 <201111181025.58650.rjw@sisk.pl> <1321861880.13860.128.camel@yhuang-dev>
	 <987664A83D2D224EAE907B061CE93D53027D89B5A9@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41725 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143Ab1K2CPG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Nov 2011 21:15:06 -0500
In-Reply-To: <987664A83D2D224EAE907B061CE93D53027D89B5A9@orsmsx505.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Russell King <linux@arm.linux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bondd@us.ibm.com" <bondd@us.ibm.com>, Myron Stowe <myron.stowe@redhat.com>

On Tue, 2011-11-29 at 07:03 +0800, Luck, Tony wrote:
> > Do you have time to take a look at the following patch:
> >
> > https://lkml.org/lkml/2011/11/7/567
> >
> > to check whether acpi_map/unmap implemented in patch works on ia64 and
> > ARM?
> 
> Ia64 won't care - it doesn't use (and won't ever use) any of these ACPI methods.
> It has some PAL functions for error injection.

Thanks.

But as this code may be used in general acpi_read/write path too in the
future, can you verify whether it is harmless on ia64?

Best Regards,
Huang Ying

