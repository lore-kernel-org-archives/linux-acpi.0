From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH] GHES: correct page protection flags in
 ghes_ioremap_pfn_...()
Date: Fri, 07 Sep 2012 08:12:59 +0100
Message-ID: <5049BA9B0200007800099923@nat28.tlf.novell.com>
References: <5049B2FF02000078000998F3@nat28.tlf.novell.com>
 <1347001356.4673.3.camel@yhuang-mobile.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:59754 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911Ab2IGHMG convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:4:1>);
	Fri, 7 Sep 2012 03:12:06 -0400
In-Reply-To: <1347001356.4673.3.camel@yhuang-mobile.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-acpi@vger.kernel.org

>>> On 07.09.12 at 09:02, Huang Ying <ying.huang@intel.com> wrote:
> On Fri, 2012-09-07 at 07:40 +0100, Jan Beulich wrote:
>> At least for Xen Dom0 it is very relevant to set the _PAGE_IO bit when
>> ioremap-ing (non-RAM) areas, as that flag suppresses the PFN -> MFN
>> translation otherwise done in PV guests. (The offending commit was
>> 81e88fdc432a1552401d6e91a984dcccce72b8dc.)
> 
> If my understanding were correct, ghes_ioremap_pfn_nmi normally only map
> RAM.

But not RAM in the sense of what is seen as usable memory in the
E820 map. What you're mapping here is reserved memory, and that
is (from the perspective of the kernel and Xen) non-RAM. The fact
that it is RAM from a machine perspective is manifested by the
mapping not needing to be done UC or alike.

Jan

