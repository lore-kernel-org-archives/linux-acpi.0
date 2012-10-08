From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v3 1/2] ACPI: Add early console framework for DBGP/DBG2.
Date: Mon, 8 Oct 2012 03:24:12 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88B9C3E7@SHSMSX101.ccr.corp.intel.com>
References: <cover.1347453194.git.zetalog@gmail.com>
 <cover.1348652044.git.lv.zheng@intel.com>
 <f6e58d76efcbdb935b9f433c624686f7d34e0151.1348652044.git.lv.zheng@intel.com>
 <20120928184122.GD17449@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12424 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab2JHDYQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Oct 2012 23:24:16 -0400
In-Reply-To: <20120928184122.GD17449@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Huang, Ying" <ying.huang@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

Hi,

This is my first time sending patch to the community, thanks for your suggestion.

> > + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
> > +02111-1307  USA
> Please remove the address.
Done.

> > +static inline int acpi_table_parse_dbg2(acpi_early_console_handler
> > +handler)
> Why inline?
Done.
I was trying to eliminate ABI related callee/caller side generation as this function will be called only once.
According to your suggestion, I removed the inline to make it a symbol.

> And somehow I am not able to find acpi_early_console_handler?
It's in the header file along with other acpi table handlers.

> > +		pr_warn("DBG2 not present\n");
> Um, pr_warn in an early printk driver? Perhaps pr_debug?
Done.

> > +			if (handler(&devinfo, table_end)) {
> 
> Oh! it is a function! Perhaps call it 'func' or just use the raw decleration in the
> arguments instead of using a typedef.
This remains unmodified to keep the same style with other acpi table handlers.

> > +	pr_info("early: DBG2 console %d detected: %04x:%04x.\n",
> > +		info->port_index, info->port_type, info->port_subtype);
Done.

Best regards/Lv Zheng
