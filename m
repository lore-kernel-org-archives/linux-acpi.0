From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] GHES: correct page protection flags in
 ghes_ioremap_pfn_...()
Date: Fri, 07 Sep 2012 15:02:36 +0800
Message-ID: <1347001356.4673.3.camel@yhuang-mobile.sh.intel.com>
References: <5049B2FF02000078000998F3@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16515 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762Ab2IGHDT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Sep 2012 03:03:19 -0400
In-Reply-To: <5049B2FF02000078000998F3@nat28.tlf.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Len Brown <lenb@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-acpi@vger.kernel.org

On Fri, 2012-09-07 at 07:40 +0100, Jan Beulich wrote:
> At least for Xen Dom0 it is very relevant to set the _PAGE_IO bit when
> ioremap-ing (non-RAM) areas, as that flag suppresses the PFN -> MFN
> translation otherwise done in PV guests. (The offending commit was
> 81e88fdc432a1552401d6e91a984dcccce72b8dc.)

If my understanding were correct, ghes_ioremap_pfn_nmi normally only map
RAM.

Best Regards,
Huang Ying


