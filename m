From: keith mannthey <kmannth@us.ibm.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/2] for acpi_memhotplug.c
Date: Wed, 21 Jun 2006 18:37:00 -0700
Message-ID: <1150940220.10001.11.camel@keithlap>
References: <971FCB6690CD0E4898387DBF7552B90E0378BEE7@orsmsx403.amr.corp.intel.com>
	 <437F1766.8090705@jp.fujitsu.com> <1150853300.5873.49.camel@keithlap>
	 <20060621114334.1b954854.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150863525.7865.6.camel@keithlap>
	 <20060621194832.37124aae.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150915426.5830.21.camel@keithlap> <1150932228.9235.6.camel@keithlap>
	 <20060622091336.be46e7a6.kamezawa.hiroyu@jp.fujitsu.com>
Reply-To: kmannth@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:22151 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030482AbWFVBhD
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jun 2006 21:37:03 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5M1b362031436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 21:37:03 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5M1bDpb120364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 19:37:13 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5M1b177025592
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 19:37:02 -0600
In-Reply-To: <20060622091336.be46e7a6.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Prarit Bhargava--redhat <prarit@redhat.com>, linux acpi <linux-acpi@vger.kernel.org>, robert.moore@intel.com, konrad <darnok@us.ibm.com>, lhms-devel <lhms-devel@lists.sourceforge.net>

On Thu, 2006-06-22 at 09:13 +0900, KAMEZAWA Hiroyuki wrote: 
> On Wed, 21 Jun 2006 16:23:47 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:
> > Update.  I have moved to 2.6.17-rc6-mm2 to work with the development
> > acpi_memhotplug driver there. I have added various debug statements and
> > this is what I know. 
> > 
> Thanks, looks informative.
> 
> >   acpi_memory_get_device calls acpi_bus_add
> >   acpi_bus_add calls acpi_add_single_object (fails)
> >   acpi_add_single_object passes acpi_bus_get_flags
> > 				finds the device present
> > 				passes acpi_device_set_context
> > 				calls acpi_device_register
> > 				after calling acpi_bus_find_driver
> > 				ends up 
> > 				if (!result) *child = device;
> > 				and returns. 
> >    
> 
> Then, "acpi_device" itself is added, but no driver data.
> acpi_add_single_object doesn't check return value of acpi_bus_find_driver(), 
> as you know. So...
> ===
> static int acpi_bus_find_driver(struct acpi_device *device)
> {
> <snip>
>         list_for_each_safe(node, next, &acpi_bus_drivers) {
> <snip>
>                 if (!acpi_bus_match(device, driver)) {
> (*)-----------      result = acpi_bus_driver_init(device, driver);
>                         if (!result)
>                                 goto Done;
>                 }
> ....
> }
> ===
> Next check point is:
> - acpi_bus_driver_init() is called or not
> - what acpi_bus_driver_init() returns

result = acpi_bus_driver_init(device, driver);
if (!result)
     goto Done;

I goto Done.  


> in acpi_bus_driver_init()
> - driver->ops.add() is called or not
> - what it retruns

It is called.  But that is not the whole story.  
In acpi_bus_driver_init it calls driver->ops.add(device). This ops.add
is not acpi_memory_device_add.  I do get not any printks that I would
expect from acpi_memory_device_add.   

If I print out in acpi_bus_driver_init
 printk(" device_add() about %s\n",acpi_device_name(device));
 result = driver->ops.add(device);

The device name is null.  I don't think the device / driver combo that
has been passed in are the right ones.  


> int acpi_memory_device_add()
> - it is called or not
> - why this  fails.
This is not called. 


After acpi_bus_driver_init calls the unknown .add it returns successfully. 
it sets 

device->driver = driver;
and
return 0;

Maybe I am picking the wrong driver from list_for_each_safe(node, next, &acpi_bus_drivers) 
in acpi_bus_find_driver?


Thanks for your help. 
-- 
keith mannthey <kmannth@us.ibm.com>
Linux Technology Center IBM

