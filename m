From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [RFC PATCH 2/4] firmware: dmi: Add function to look up a handle
 and return DIMM size
Date: Mon, 4 Dec 2017 14:03:16 -0800
Message-ID: <20171204220316.nl5m4lmyek7alvhb@agluck-desk>
References: <cover.1512070562.git.tony.luck@intel.com>
 <2fae02861e5c446c0cdd30ba3e00fad55db97807.1512070562.git.tony.luck@intel.com>
 <20171204213813.rm32qqeqchx37c5x@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:46289 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752642AbdLDWDT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Dec 2017 17:03:19 -0500
Content-Disposition: inline
In-Reply-To: <20171204213813.rm32qqeqchx37c5x@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jean Delvare <jdelvare@suse.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Lv Zheng <lv.zheng@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Aristeu Rozanski <aris@redhat.com>

On Mon, Dec 04, 2017 at 10:38:14PM +0100, Borislav Petkov wrote:
> On Thu, Nov 30, 2017 at 12:40:40PM -0800, Tony Luck wrote:
> >  	dmi_memdev[nr].bank = dmi_string(dm, d[0x11]);
> 
> <---- newline here.
> 
> > +	size = get_unaligned((u16 *)&d[0xC]);
> > +	if (size == 0)
> > +		bytes = 0;
> > +	else if (size == 0xffff)
> > +		bytes = ~0ul;
> > +	else if (size & 0x8000)
> > +		bytes = (u64)(size & 0x7fff) << 10;
> > +	else if (size != 0x7fff)
> > +		bytes = (u64)size << 20;
> > +	else
> > +		bytes = (u64)get_unaligned((u32 *)&d[0x1C]) << 20;
> 
> <---- newline here.

Ok ... it does read better with those breaks. Will add.

> So dmi_memdev_name() also loops over dmi_memdev and returns bank and
> device. This new function returns size.
> 
> If code is going to be calling those one after the other, you could do a
> 
> 	dmi_memdev_desc(u16 handle, struct memdev_desc *desc)

Current callers are from different code paths (dmi_memdev_name() from
ghes and EFI, dmi_memdev_size() just from the Skylake EDAC driver).
If we later find a place that calls both this would be a good cleanup.

> which fills up a descriptor with all fields a caller would need in one
> go so that you don't have to iterate multiple times. Looking at struct
> dmi_memdev_info, there are no more fields so maybe this is probably
> silly though or you can simply return struct dmi_memdev_info directly...
> 
> Meh.

I take it that you talked yourself out of asking for the cleanup now?

-Tony
