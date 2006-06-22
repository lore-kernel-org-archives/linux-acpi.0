From: keith mannthey <kmannth@us.ibm.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/2] for acpi_memhotplug.c
Date: Thu, 22 Jun 2006 10:25:24 -0700
Message-ID: <1150997124.5880.2.camel@keithlap>
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
Reply-To: kmannth@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:62953 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751844AbWFVRZ2
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jun 2006 13:25:28 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5MHPQJH010920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2006 13:25:26 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5MHPbF4093322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2006 11:25:37 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5MHPOcU005605
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2006 11:25:25 -0600
In-Reply-To: <20060622142038.86ec6472.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Prarit Bhargava--redhat <prarit@redhat.com>, linux acpi <linux-acpi@vger.kernel.org>, lhms-devel <lhms-devel@lists.sourceforge.net>, konrad <darnok@us.ibm.com>, robert.moore@intel.com

On Thu, 2006-06-22 at 14:20 +0900, KAMEZAWA Hiroyuki wrote:
> On Wed, 21 Jun 2006 20:55:02 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:
> > > Hmm....curious..but no idead..
> > > Then, could try this ? 
> > 
> > I am trying to make the motherboard driver fail with it looks for
> > resources and finds node.  The motherboard add function alway returns
> > AE_OK which is why the algorithm fails. See attached patch it allows the
> > hot-add event to happen. 
> > 
> > With the event happening and I see 
> > 
> Um...my concern is
> - When notify comes, memory hotplug driver is called.
> - but at acpi_bus_add(), PNP0C01 motherboad driver is attached to the device.

The patch I sent keeps the motherboard driver from attaching and allows
the  PNP0C80 device to attach. 

> I think something is wrong....from your SSDT, ME00 and ME01 memory device has
> valid HID, PNP0C80.
> ==
>         Device (ME01)
>         {
>             Name (_HID, EisaId ("PNP0C80"))
>             Name (_CID, 0x010CD041)
> ==
> What I imagine now is.
> 
> - acpi_memory_device_init() -> acpi_memory_register_notify_handler()
>   installs notify handler for memory hotplug against device handle of memory
>   This doesn't check _CID.
> 
> - acpi_bus_add() attachs motherboard driver because of CID.
>   Above _CID is 32bit compressed EISA-type ID (HID is string but..),
>   it is PNP0C01...motherboad driver is called before PNP0C80 driver.
>   (to covert 32bit ID to string, see acpi_ex_eisa_id_to_string(),
>    I attached program.)
This is a bug in the motherboard driver where it attached to any device
it is presented to. 

> Then what we should do here is...call HID:PNP0C80 driver instead if CID:PNP0C01 driver.
> Because it has driver for HID, calling driver for CID looks not good.
> (But we have to ask acpi people about this..)

The patch allows PNP0C80 driver to be used. 
-- 
keith mannthey <kmannth@us.ibm.com>
Linux Technology Center IBM

