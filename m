From: keith mannthey <kmannth@us.ibm.com>
Subject: RE: one more ACPI Error (utglobal-0125): Unknown exception code:
	0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Wed, 06 Sep 2006 13:04:28 -0700
Message-ID: <1157573069.5713.24.camel@keithlap>
References: <B28E9812BAF6E2498B7EC5C427F293A4E38B52@orsmsx415.amr.corp.intel.com>
Reply-To: kmannth@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:48575 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751533AbWIFUEc
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Sep 2006 16:04:32 -0400
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A4E38B52@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

On Wed, 2006-09-06 at 11:59 -0700, Moore, Robert wrote:
> From one of the ACPI guys:
> 
> > Get hid
> > Look for driver
> > If you find a match, load it
> > If no match, get CID
> > Look for driver
> > If you find a match, load it
> > If you did not find an hid or cid match, punt

I think this is what my patch is doing.

when looking for a driver: (acpi_bus_find_driver)
I check against the HID 
return if found 
Then I check against the CID
return if found
else
punt 

Any objections to pushing this into -mm and dropping the motherboard
change?

Thanks,
  Keith 
  


