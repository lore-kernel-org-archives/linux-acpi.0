From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH] GHES: correct page protection flags in
 ghes_ioremap_pfn_...()
Date: Fri, 07 Sep 2012 09:12:03 +0100
Message-ID: <5049C87302000078000999D5@nat28.tlf.novell.com>
References: <5049B2FF02000078000998F3@nat28.tlf.novell.com>
 <20120907071836.GB16591@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:60713 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab2IGILK convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:5:1>);
	Fri, 7 Sep 2012 04:11:10 -0400
In-Reply-To: <20120907071836.GB16591@gchen.bj.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, ying.huang@intel.com, Len Brown <lenb@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-acpi@vger.kernel.org

>>> On 07.09.12 at 09:18, Chen Gong <gong.chen@linux.intel.com> wrote:
> On Fri, Sep 07, 2012 at 07:40:31AM +0100, Jan Beulich wrote:
>> Date:	Fri, 07 Sep 2012 07:40:31 +0100
>> From: Jan Beulich <JBeulich@suse.com>
>> To: Len Brown <lenb@kernel.org>
>> Cc: ying.huang@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
>>  linux-acpi@vger.kernel.org 
>> Subject: [PATCH] GHES: correct page protection flags in
>>  ghes_ioremap_pfn_...()
>> X-Mailer: Novell GroupWise Internet Agent 12.0.0 
>> 
>> At least for Xen Dom0 it is very relevant to set the _PAGE_IO bit when
>> ioremap-ing (non-RAM) areas, as that flag suppresses the PFN -> MFN
>> translation otherwise done in PV guests. (The offending commit was
>> 81e88fdc432a1552401d6e91a984dcccce72b8dc.)
>>
> 
> Oh, right. In virtual environment, physical address is virtualized, too.
> We need to tell *ioremap* to map in proper address space. But I want
> to do if you can update all related mappings for APEI tables? I'm not sure
> if all APEI tables are affected by this issue.

The other mappings that I found might be relevant use ioremap(),
i.e. don't specify protection flags on their own.

Jan

