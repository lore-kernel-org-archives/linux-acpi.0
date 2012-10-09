From: Konrad Rzeszutek Wilk <konrad@kernel.org>
Subject: Re: [PATCH v3 1/2] ACPI: Add early console framework for DBGP/DBG2.
Date: Tue, 9 Oct 2012 12:48:16 -0400
Message-ID: <20121009164815.GD25276@phenom.dumpdata.com>
References: <cover.1347453194.git.zetalog@gmail.com>
 <cover.1348652044.git.lv.zheng@intel.com>
 <f6e58d76efcbdb935b9f433c624686f7d34e0151.1348652044.git.lv.zheng@intel.com>
 <20120928184122.GD17449@localhost.localdomain>
 <1AE640813FDE7649BE1B193DEA596E88B9C3E7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:61204 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab2JIRAE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2012 13:00:04 -0400
Received: by mail-qc0-f174.google.com with SMTP id d3so4104201qch.19
        for <linux-acpi@vger.kernel.org>; Tue, 09 Oct 2012 10:00:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88B9C3E7@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Huang, Ying" <ying.huang@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

On Mon, Oct 08, 2012 at 03:24:12AM +0000, Zheng, Lv wrote:
> Hi,
> 
> This is my first time sending patch to the community, thanks for your suggestion.
> 
> > > + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
> > > +02111-1307  USA
> > Please remove the address.
> Done.
> 
> > > +static inline int acpi_table_parse_dbg2(acpi_early_console_handler
> > > +handler)
> > Why inline?
> Done.
> I was trying to eliminate ABI related callee/caller side generation as this function will be called only once.
> According to your suggestion, I removed the inline to make it a symbol.
> 
> > And somehow I am not able to find acpi_early_console_handler?
> It's in the header file along with other acpi table handlers.
> 
> > > +		pr_warn("DBG2 not present\n");
> > Um, pr_warn in an early printk driver? Perhaps pr_debug?
> Done.
> 
> > > +			if (handler(&devinfo, table_end)) {
> > 
> > Oh! it is a function! Perhaps call it 'func' or just use the raw decleration in the
> > arguments instead of using a typedef.
> This remains unmodified to keep the same style with other acpi table handlers.

OK. Perhaps a different name then? 'fnc_handler' ?

> 
> > > +	pr_info("early: DBG2 console %d detected: %04x:%04x.\n",
> > > +		info->port_index, info->port_type, info->port_subtype);
> Done.
> 
> Best regards/Lv Zheng
> 
