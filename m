From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception code:
 0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Fri, 1 Sep 2006 12:56:48 +0900
Message-ID: <20060901125648.11883533.kamezawa.hiroyu@jp.fujitsu.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4D850BB@orsmsx415.amr.corp.intel.com>
	<200608310248.29861.len.brown@intel.com>
	<1157042913.7859.31.camel@keithlap>
	<200608311707.00817.bjorn.helgaas@hp.com>
	<1157073592.5649.29.camel@keithlap>
	<49303.24.9.204.52.1157080555.squirrel@mail.cce.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:31161 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751097AbWIADyb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Aug 2006 23:54:31 -0400
In-Reply-To: <49303.24.9.204.52.1157080555.squirrel@mail.cce.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: kmannth@us.ibm.com, bjorn.helgaas@hp.com, lenb@kernel.org, robert.moore@intel.com, shaohua.li@intel.com, malattia@linux.it, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, 31 Aug 2006 21:15:55 -0600 (MDT)
"Bjorn Helgaas" <bjorn.helgaas@hp.com> wrote:

> Ok, this is starting to make sense.  It sounds like your memory
> device has _HID of PNP0C80 and _CID of PNP0C01 (or PNP0C02).
> 
> The current ACPI driver binding algorithm in acpi_bus_find_driver()
> looks at each driver, checking whether it can match either the _HID
> or the _CID of a device.  Since we try the motherboard driver first,
> it matches the memory device _CID.
> 
> I couldn't find a specific reference in the spec, but this seems
> intuitively sub-optimal.  It seems like it'd be better to look
> first for a driver that can claim the _HID (which is more specific),
> and only fall back to checking the _CIDs if no _HID-specific driver
> is found.
> 
I like it :)

-Kame

