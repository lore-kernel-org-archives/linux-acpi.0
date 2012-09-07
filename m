From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] GHES: correct page protection flags in
 ghes_ioremap_pfn_...()
Date: Fri, 07 Sep 2012 16:46:18 +0800
Message-ID: <1347007578.28607.13.camel@yhuang-dev>
References: <5049B2FF02000078000998F3@nat28.tlf.novell.com>
	 <1347001356.4673.3.camel@yhuang-mobile.sh.intel.com>
	 <5049BA9B0200007800099923@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11595 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066Ab2IGIqW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Sep 2012 04:46:22 -0400
In-Reply-To: <5049BA9B0200007800099923@nat28.tlf.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Len Brown <lenb@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-acpi@vger.kernel.org

On Fri, 2012-09-07 at 08:12 +0100, Jan Beulich wrote:
> >>> On 07.09.12 at 09:02, Huang Ying <ying.huang@intel.com> wrote:
> > On Fri, 2012-09-07 at 07:40 +0100, Jan Beulich wrote:
> >> At least for Xen Dom0 it is very relevant to set the _PAGE_IO bit when
> >> ioremap-ing (non-RAM) areas, as that flag suppresses the PFN -> MFN
> >> translation otherwise done in PV guests. (The offending commit was
> >> 81e88fdc432a1552401d6e91a984dcccce72b8dc.)
> > 
> > If my understanding were correct, ghes_ioremap_pfn_nmi normally only map
> > RAM.
> 
> But not RAM in the sense of what is seen as usable memory in the
> E820 map. What you're mapping here is reserved memory, and that
> is (from the perspective of the kernel and Xen) non-RAM. The fact
> that it is RAM from a machine perspective is manifested by the
> mapping not needing to be done UC or alike.

I think the key is to keep these memory range map consistent between
each other.  BIOS may map these memory cached.  ACPI may mapped them as
cached (see acpi_os_ioremap) too.

Best Regards,
Huang Ying



