From: Huang Ying <ying.huang@intel.com>
Subject: RE: [PATCH 2/2] ACPICA: support Generic Address Structure
 bit_offset in acpi_read/write
Date: Thu, 01 Dec 2011 08:49:11 +0800
Message-ID: <1322700551.4849.66.camel@yhuang-dev>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
	 <201111172127.40664.rjw@sisk.pl> <1321578279.13860.108.camel@yhuang-dev>
	 <201111181025.58650.rjw@sisk.pl> <1321861880.13860.128.camel@yhuang-dev>
	 <987664A83D2D224EAE907B061CE93D53027D89B5A9@orsmsx505.amr.corp.intel.com>
	 <1322532903.4849.24.camel@yhuang-dev>
	 <0207C53569FE594381A4F2EB66570B2A018ED45AA8@orsmsx508.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3794 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369Ab1LAAtP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Nov 2011 19:49:15 -0500
In-Reply-To: <0207C53569FE594381A4F2EB66570B2A018ED45AA8@orsmsx508.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Russell King <linux@arm.linux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bondd@us.ibm.com" <bondd@us.ibm.com>, Myron Stowe <myron.stowe@redhat.com>

On Thu, 2011-12-01 at 05:54 +0800, Luck, Tony wrote:
> > But as this code may be used in general acpi_read/write path too in the
> > future, can you verify whether it is harmless on ia64?
> 
> This might be a problem on ia64 - it is s/w responsibility to make sure
> that we don't map the same underlying physical address using different
> cache attributes - e.g. we must not map memory both cacheable and uncacheable
> at the same time.  Accessing such a mis-attributed page will result in a
> machine check.
> 
> So I'd worry that if the memory in question was being used as uncacheable,
> this code might result in a cached access, which would crash the machine.

+static void __iomem *acpi_map(phys_addr_t pg_off, unsigned long pg_sz)
+{
+	unsigned long pfn;
+
+	pfn = pg_off >> PAGE_SHIFT;
+	if (page_is_ram(pfn)) {
+		if (pg_sz > PAGE_SIZE)
+			return NULL;
+		return (void __iomem __force *)kmap(pfn_to_page(pfn));
+	} else
+		return ioremap(pg_off, pg_sz);
+}

Is it possible to use the page_is_ram() and kamp() path in the patch to avoid the situation you mentioned?

Best Regards,
Huang Ying


