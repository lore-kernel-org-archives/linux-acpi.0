From: Huang Ying <ying.huang@intel.com>
Subject: RE: [PATCH 2/2] ACPICA: support Generic Address Structure
 bit_offset in acpi_read/write
Date: Fri, 02 Dec 2011 09:48:15 +0800
Message-ID: <1322790495.4849.95.camel@yhuang-dev>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
	 <201111172127.40664.rjw@sisk.pl> <1321578279.13860.108.camel@yhuang-dev>
	 <201111181025.58650.rjw@sisk.pl> <1321861880.13860.128.camel@yhuang-dev>
	 <987664A83D2D224EAE907B061CE93D53027D89B5A9@orsmsx505.amr.corp.intel.com>
	 <1322532903.4849.24.camel@yhuang-dev>
	 <0207C53569FE594381A4F2EB66570B2A018ED45AA8@orsmsx508.amr.corp.intel.com>
	 <1322700551.4849.66.camel@yhuang-dev>
	 <0207C53569FE594381A4F2EB66570B2A018ED45DA7@orsmsx508.amr.corp.intel.com>
	 <1322701065.4849.69.camel@yhuang-dev>
	 <0207C53569FE594381A4F2EB66570B2A018ED45DCF@orsmsx508.amr.corp.intel.com>
	 <1322701894.4849.72.camel@yhuang-dev>
	 <0207C53569FE594381A4F2EB66570B2A018ED461AE@orsmsx508.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61462 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756328Ab1LBBsS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Dec 2011 20:48:18 -0500
In-Reply-To: <0207C53569FE594381A4F2EB66570B2A018ED461AE@orsmsx508.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Russell King <linux@arm.linux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bondd@us.ibm.com" <bondd@us.ibm.com>, Myron Stowe <myron.stowe@redhat.com>

On Fri, 2011-12-02 at 01:35 +0800, Luck, Tony wrote:
> >> That doesn't deal with long-lived mappings and changes that I just
> >> mentioned in last e-mail - but it does mean that callers of ioremap()
> >> don't need to worry ... they can call "blindly".
> >
> > I see.  So you think it is better to enclose page_is_ram() with #ifndef
> > CONFIG_IA64 in the patch, so that only ioremap() is used?
> 
> Functionally yes - though the aversion to #ifdef in the middle of code
> would imply some extra hoops.  Perhaps
> 
> #ifndef CONFIG_IA64
> #define can_use_kmap(pfn) page_is_ram(pfn)
> #else
> #define can_use_kmap(pfn) (0) /* ioremap() will take care of cache attributes */
> #endif
> 
> 
> ...
> 
> 		if (can_use_kmap(pfn)) {

Yes.  That is better.  I will do that.

Best Regards,
Huang Ying

