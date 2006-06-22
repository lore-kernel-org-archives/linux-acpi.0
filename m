From: keith mannthey <kmannth@us.ibm.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/2] for acpi_memhotplug.c
Date: Thu, 22 Jun 2006 11:29:18 -0700
Message-ID: <1151000958.5880.17.camel@keithlap>
References: <971FCB6690CD0E4898387DBF7552B90E0378BEE7@orsmsx403.amr.corp.intel.com>
	 <437F1766.8090705@jp.fujitsu.com> <1150853300.5873.49.camel@keithlap>
	 <20060621114334.1b954854.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150863525.7865.6.camel@keithlap>
	 <20060621194832.37124aae.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150915426.5830.21.camel@keithlap> <1150932228.9235.6.camel@keithlap>
	 <20060622091336.be46e7a6.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150940220.10001.11.camel@keithlap>
	 <20060622105854.18fa1f16.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150942799.10001.30.camel@keithlap>
	 <20060622121356.6326e4a2.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150948503.10001.60.camel@keithlap>
	 <20060622142038.86ec6472.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150997124.5880.2.camel@keithlap>
	 <20060623024149.e4ecdf21.kamezawa.hiroyu@jp.fujitsu.com>
Reply-To: kmannth@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:2696 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751869AbWFVS30 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jun 2006 14:29:26 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5MITLdc015505
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2006 14:29:21 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5MISuSg223544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2006 12:28:56 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5MITK1a008587
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2006 12:29:20 -0600
In-Reply-To: <20060623024149.e4ecdf21.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Prarit Bhargava--redhat <prarit@redhat.com>, linux acpi <linux-acpi@vger.kernel.org>, lhms-devel <lhms-devel@lists.sourceforge.net>, robert.moore@intel.com, konrad <darnok@us.ibm.com>

On Fri, 2006-06-23 at 02:41 +0900, KAMEZAWA Hiroyuki wrote:
> On Thu, 22 Jun 2006 10:25:24 -0700
> keith mannthey <kmannth@us.ibm.com> wrote: 
> > > Um...my concern is
> > > - When notify comes, memory hotplug driver is called.
> > > - but at acpi_bus_add(), PNP0C01 motherboad driver is attached to the device.
> > 
> > The patch I sent keeps the motherboard driver from attaching and allows
> > the  PNP0C80 device to attach. 
> > 
> My point is...motherboard is not memory. Then, it shouldn't have _CRS handler.
> Because your ME00/ME01 device has both HID for memory and CID for motherboard,
> motherboard handler is called.
> (acpi_add_single_object() attaches the driver which is found 1st.)
> > > ==
> > >         Device (ME01)
> > >         {
> > >             Name (_HID, EisaId ("PNP0C80"))
> > >             Name (_CID, 0x010CD041)
> > > ==
> As I wrote in other mail, why memory and motherboard is compatible device in
> your SSDT ? If this _CID is necessary for some reason, what should we do is
> acpi handling problem.
> So, what you should ask to acpi people is 
> ==
> my device has both _HID and _CID.  But the driver for _HID is different from
> _CID. I'm glad if the driver for _HID is called but driver for _CID is found
> before driver for _HID. Then, driver for _CID is called.
> How should I do ? (or make patch to fix this..)
> ==

I agree this is an acpi_handling problem where the wrong device is
attached.  I am pursuing ACPI folks today. 

I have my patch in place to work around the problem and am looking into
the the memory driver. 

In acpi_memory_enable_device 

in  list_for_each_entry(info, &mem_device->res_list, list) {

if 
printk ("node: %d , start %08lx, end %08lx \n",node,info-
>start_addr,info->start_addr+info->length);
before doing the add memory I see

node: -1 , start 1f0000000, end 270000000
On node -1 totalpages: 0
node: -1 , start 170000000, end 1f0000000

Finding the 2 ranges (these are the right ranges and the right chunks)
is great but acpi_get_node is not working for my handle. 

I am continuing to debug. 


Thanks,  
  Keith 

