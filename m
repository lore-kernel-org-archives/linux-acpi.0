From: keith mannthey <kmannth@us.ibm.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/2] for acpi_memhotplug.c
Date: Wed, 21 Jun 2006 19:19:58 -0700
Message-ID: <1150942799.10001.30.camel@keithlap>
References: <971FCB6690CD0E4898387DBF7552B90E0378BEE7@orsmsx403.amr.corp.intel.com>
	 <437F1766.8090705@jp.fujitsu.com> <1150853300.5873.49.camel@keithlap>
	 <20060621114334.1b954854.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150863525.7865.6.camel@keithlap>
	 <20060621194832.37124aae.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150915426.5830.21.camel@keithlap> <1150932228.9235.6.camel@keithlap>
	 <20060622091336.be46e7a6.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150940220.10001.11.camel@keithlap>
	 <20060622105854.18fa1f16.kamezawa.hiroyu@jp.fujitsu.com>
Reply-To: kmannth@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:21392 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751537AbWFVCUD
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jun 2006 22:20:03 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5M2K2NX016289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 22:20:02 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5M2JcZY280546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 20:19:38 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5M2K0F2010020
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 20:20:02 -0600
In-Reply-To: <20060622105854.18fa1f16.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Prarit Bhargava--redhat <prarit@redhat.com>, linux acpi <linux-acpi@vger.kernel.org>, lhms-devel <lhms-devel@lists.sourceforge.net>, robert.moore@intel.com, konrad <darnok@us.ibm.com>

On Thu, 2006-06-22 at 10:58 +0900, KAMEZAWA Hiroyuki wrote:
> On Wed, 21 Jun 2006 18:37:00 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:
> 
> > > in acpi_bus_driver_init()
> > > - driver->ops.add() is called or not
> > > - what it retruns
> > 
> > It is called.  But that is not the whole story.  
> > In acpi_bus_driver_init it calls driver->ops.add(device). This ops.add
> > is not acpi_memory_device_add.  I do get not any printks that I would
> > expect from acpi_memory_device_add.   
> > 
> > If I print out in acpi_bus_driver_init
> >  printk(" device_add() about %s\n",acpi_device_name(device));
> >  result = driver->ops.add(device);
> > 
> Good Catch :)
> 
> Then, could you print driver name ? like this
> ==
> printk("Call Add driver for name %s/class %s/id %s\n",driver->name,driver->class,driver->id);
> ==

Good idea!
During the hot add I see. 
Call Add driver for name motherboard/class /id PNP0C01

That is the wrong driver for sure. 
> 
> > Maybe I am picking the wrong driver from list_for_each_safe(node, next, &acpi_bus_drivers) 
> > in acpi_bus_find_driver?
> > 
> looks so...BTW, your acpi_memhotplug driver is a module or built-in ?
Built-in. 

Thanks. 
-- 
keith mannthey <kmannth@us.ibm.com>
Linux Technology Center IBM

