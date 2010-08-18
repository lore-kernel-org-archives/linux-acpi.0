From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 1/4] [Patch-next] ACPI, APEI, ERST Fix the wrong
 checking of Serialization Header's length
Date: Wed, 18 Aug 2010 13:34:56 +0800
Message-ID: <1282109696.2744.1553.camel@yhuang-dev>
References: <4C69DDB5.6060103@np.css.fujitsu.com>
	 <1282008836.2744.1490.camel@yhuang-dev>
	 <4C69F094.1040607@np.css.fujitsu.com>
	 <1282015344.2744.1500.camel@yhuang-dev> <4C6A139D.20507@np.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:57611 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793Ab0HRFfA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Aug 2010 01:35:00 -0400
In-Reply-To: <4C6A139D.20507@np.css.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jin Dongming <jin.dongming@np.css.fujitsu.com>, Lu Yinghai <yinghai@kernel.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Andi Kleen <andi@firstfloor.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, ACPI <linux-acpi@vger.kernel.org>, LKLM <linux-kernel@vger.kernel.org>

On Tue, 2010-08-17 at 12:44 +0800, Jin Dongming wrote:
> (2010/08/17 12:22), Huang Ying wrote:
> > On Tue, 2010-08-17 at 10:14 +0800, Jin Dongming wrote:
> >>> I don't think it is necessary to change the header definition, and
> >>> seri_header is not a good name for me.
> >> Why I added this structure here is that I don't want to do following checking.
> >> For example,
> >> 	if (header_length != 0x0c) {
> >> 		...
> >> 	}
> > 
> > This can be:
> > 
> >  static int erst_check_table(struct acpi_table_erst *erst_tab)
> >  {
> > -       if (erst_tab->header_length != sizeof(struct acpi_table_erst))
> > +       if (erst_tab->header_length !=
> > +           (sizeof(struct acpi_table_erst) - sizeof(erst_tab->header)))
> > 
> > like Yinghai has been done.
> > 
> Yes. It looks good. And I am sorry I am unaware of Yinghai' patch. 

Maybe you can help push this fix in, it seems that Yinghai is busy on
something else?

Hi, Yinghai,

Do you mind for Dongming to push this fix?

Best REgards,
Huang Ying


