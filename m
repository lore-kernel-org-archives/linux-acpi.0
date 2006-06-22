From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/2] for acpi_memhotplug.c
Date: Fri, 23 Jun 2006 02:41:49 +0900
Message-ID: <20060623024149.e4ecdf21.kamezawa.hiroyu@jp.fujitsu.com>
References: <971FCB6690CD0E4898387DBF7552B90E0378BEE7@orsmsx403.amr.corp.intel.com>
	<437F1766.8090705@jp.fujitsu.com>
	<1150853300.5873.49.camel@keithlap>
	<20060621114334.1b954854.kamezawa.hiroyu@jp.fujitsu.com>
	<1150863525.7865.6.camel@keithlap>
	<20060621194832.37124aae.kamezawa.hiroyu@jp.fujitsu.com>
	<1150915426.5830.21.camel@keithlap>
	<1150932228.9235.6.camel@keithlap>
	<20060622091336.be46e7a6.kamezawa.hiroyu@jp.fujitsu.com>
	<1150940220.10001.11.camel@keithlap>
	<20060622105854.18fa1f16.kamezawa.hiroyu@jp.fujitsu.com>
	<1150942799.10001.30.camel@keithlap>
	<20060622121356.6326e4a2.kamezawa.hiroyu@jp.fujitsu.com>
	<1150948503.10001.60.camel@keithlap>
	<20060622142038.86ec6472.kamezawa.hiroyu@jp.fujitsu.com>
	<1150997124.5880.2.camel@keithlap>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:21128 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932560AbWFVRmG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jun 2006 13:42:06 -0400
In-Reply-To: <1150997124.5880.2.camel@keithlap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kmannth@us.ibm.com
Cc: prarit@redhat.com, linux-acpi@vger.kernel.org, robert.moore@intel.com, darnok@us.ibm.com, lhms-devel@lists.sourceforge.net

On Thu, 22 Jun 2006 10:25:24 -0700
keith mannthey <kmannth@us.ibm.com> wrote: 
> > Um...my concern is
> > - When notify comes, memory hotplug driver is called.
> > - but at acpi_bus_add(), PNP0C01 motherboad driver is attached to the device.
> 
> The patch I sent keeps the motherboard driver from attaching and allows
> the  PNP0C80 device to attach. 
> 
My point is...motherboard is not memory. Then, it shouldn't have _CRS handler.
Because your ME00/ME01 device has both HID for memory and CID for motherboard,
motherboard handler is called.
(acpi_add_single_object() attaches the driver which is found 1st.)
> > ==
> >         Device (ME01)
> >         {
> >             Name (_HID, EisaId ("PNP0C80"))
> >             Name (_CID, 0x010CD041)
> > ==
As I wrote in other mail, why memory and motherboard is compatible device in
your SSDT ? If this _CID is necessary for some reason, what should we do is
acpi handling problem.
So, what you should ask to acpi people is 
==
my device has both _HID and _CID.  But the driver for _HID is different from
_CID. I'm glad if the driver for _HID is called but driver for _CID is found
before driver for _HID. Then, driver for _CID is called.
How should I do ? (or make patch to fix this..)
==

Cheers,
-Kame

