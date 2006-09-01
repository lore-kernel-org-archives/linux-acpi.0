From: keith mannthey <kmannth@us.ibm.com>
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception
	code:0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Thu, 31 Aug 2006 20:31:19 -0700
Message-ID: <1157081479.5649.40.camel@keithlap>
References: <B28E9812BAF6E2498B7EC5C427F293A4D850BB@orsmsx415.amr.corp.intel.com>
	 <200608310248.29861.len.brown@intel.com>
	 <1157042913.7859.31.camel@keithlap>
	 <200608311707.00817.bjorn.helgaas@hp.com>
	 <1157073592.5649.29.camel@keithlap>
	 <1157078346.2782.24.camel@sli10-desk.sh.intel.com>
Reply-To: kmannth@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:58765 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750940AbWIADbX
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Aug 2006 23:31:23 -0400
In-Reply-To: <1157078346.2782.24.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


> > Also see   
> > http://sourceforge.net/mailarchive/forum.php? 
> > thread_id=15282420&forum_id=223
> > 
> > I don't claim this is the ACPI correct solution and am welcome to any 
> > input that fixes my issue: acpi_bus_find_driver returning the
> > incorrect 
> > driver for a given handle.    
> Then the issue is your device _CID returned PNP0C01 or PNP0C02. Is this
> intended? Can we change the BIOS?

  The spec talks about _HID for the memory device and that is ok but I
don't see any reference to required _CID. My _CID is listed as hex.  Can
I just convert it?

 Changing the bios is a little bit of a long shot at this point. 

Thanks,
  Keith 

